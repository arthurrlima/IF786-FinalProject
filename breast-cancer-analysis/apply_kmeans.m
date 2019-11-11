MAJOR_CLASS_PATH = 'dataset/simple/ca.csv'
MINOR_CLASS_PATH = 'dataset/simple/cb.csv'
KMEANS_CLASS_PATH = 'dataset/kmeans/c1.csv'

k = size(csvread(MINOR_CLASS_PATH), 1)

dataset = csvread(MAJOR_CLASS_PATH)

[idx, clusters] = kmeans(dataset, k)

dlmwrite(KMEANS_CLASS_PATH, clusters)