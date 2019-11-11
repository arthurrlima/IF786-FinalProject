C1_CLASS_PATH = './dataset/adapted_smote/c1.csv';
C1_TRAINING_PATH = './dataset/adapted_smote/partitioned/c1_training.csv';
C1_VALIDATION_PATH = './dataset/adapted_smote/partitioned/c1_validation.csv';
C1_TEST_PATH = './dataset/adapted_smote/partitioned/c1_test.csv';

C2_CLASS_PATH = './dataset/adapted_smote/c2.csv';
C2_TRAINING_PATH = './dataset/adapted_smote/partitioned/c2_training.csv';
C2_VALIDATION_PATH = './dataset/adapted_smote/partitioned/c2_validation.csv';
C2_TEST_PATH = './dataset/adapted_smote/partitioned/c2_test.csv';

partition(C1_CLASS_PATH, C1_TRAINING_PATH, C1_VALIDATION_PATH, C1_TEST_PATH);
partition(C2_CLASS_PATH, C2_TRAINING_PATH, C2_VALIDATION_PATH, C2_TEST_PATH);
