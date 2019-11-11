import os, operator, random, copy

C1_PATH = 'dataset/simple/c1.csv'
C2_PATH = 'dataset/simple/c2.csv'
RESULT_PATH = 'dataset/adapted_smote/c2.csv'
K_VALUE = 5

def euclidean_distance(v1, v2):
    dist = 0
    for i in range(len(v1)-1):
        dist += ((v1[i]-v2[i])*(v1[i]-v2[i]))
    return dist

def k_neighbors(index, k, data):
    
    neighbors = []

    distances = []

    for u in range(len(data)):
        distances.append((u, euclidean_distance(data[u], data[index])))

    distances.sort(key=lambda point: point[1])

    for i in range(index):
        neighbors.append(data[i])

    return neighbors

def interpolate(v, nei):
    vec = map(operator.sub, nei[:-1], v[:-1])
    if nei[-1] == v[-1]:
        rnd = random.random()
    else:
        rnd = random.uniform(0, 0.5)

    npoint = list(map(operator.add, v[:-1], map(operator.mul, [rnd for i in range(len(v)-1)], vec)))
    npoint.append(v[-1])
    return tuple(npoint)

def adapted_smote(c2_set, all_data, c1_len, k):
    extra = c1_len - len(c2_set)

    extra_c2 = []

    cnt = 0

    while extra > 0:
        rnd_v = random.choice(c2_set)

        neighbors = k_neighbors(k, rnd_v, all_data)

        while True:
            rnd_neighbor = random.choice(neighbors)
            npoint = interpolate(rnd_v, rnd_neighbor)
            if npoint not in extra_c2:
                extra_c2.append(npoint)
                extra -= 1
                break
            elif cnt > LIMIT:
                break
            else:
                cnt += 1
        cnt = 0

    return extra_c2

if __name__ == '__main__':

    c1_file = open(C1_PATH)
    c2_file = open(C2_PATH)
    c2_extra = open(RESULT_PATH, 'w')
    c1_set = []
    c2_set = []

    for line in c1_file:
        data = tuple([float(val) for val in line.split(',')])
        c1_set.append(data)
    for line in c2_file:
        data = tuple([float(val) for val in line.split(',')])
        c2_set.append(data)

    all_data = c1_set + c2_set

    new_c2_set = c2_set + adapted_smote(c2_set, all_data, len(c1_set), 5)

    c1_file.close()
    c2_file.close()

    each_row_str = []
    for row in new_c2_set:
        each_row_str.append(','.join([str(val) for val in row]))

    c2_extra.write('\n'.join(each_row_str))
    c2_extra.close()