import random
import math
import shutil

TRAINING_PATH = 'dataset/adapted_smote/concat/training.csv'
VALIDATION_PATH = 'dataset/adapted_smote/concat/validation.csv'
TEST_PATH = 'dataset/adapted_smote/concat/test.csv'

FINAL_TRAINING_PATH = 'dataset/adapted_smote/final/training.csv'
FINAL_VALIDATION_PATH = 'dataset/adapted_smote/final/validation.csv'
FINAL_TEST_PATH = 'dataset/adapted_smote/final/test.csv'

def merge(file, output):
    lines = []
    with open(file) as infile:
        for line in infile:
            line = line.replace("\n", "")
            lines.append(line)
    with open(output, 'w') as outfile:
        outfile.write(",".join(lines))

merge(TRAINING_PATH, FINAL_TRAINING_PATH);

merge(VALIDATION_PATH, FINAL_VALIDATION_PATH);

merge(TEST_PATH, FINAL_TEST_PATH);