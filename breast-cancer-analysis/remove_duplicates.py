INFILE = 'dataset/mammography.csv'
OUTFILE = 'dataset/mammography_clean.csv'

lines_seen = set() # holds lines already seen
outfile = open(OUTFILE, "w")
for line in open(INFILE, "r"):
    if line not in lines_seen: # not a duplicate
        outfile.write(line)
        lines_seen.add(line)
outfile.close()