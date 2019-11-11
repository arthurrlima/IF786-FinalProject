C1_TRAINING_PATH = './dataset/adapted_smote/partitioned/c1_training.csv';
C1_VALIDATION_PATH = './dataset/adapted_smote/partitioned/c1_validation.csv';
C1_TEST_PATH = './dataset/adapted_smote/partitioned/c1_test.csv';

C1_OVERSAMPLED_TRAINING_PATH = './dataset/adapted_smote/oversampled/c1_training.csv';
C1_OVERSAMPLED_VALIDATION_PATH = './dataset/adapted_smote/oversampled/c1_validation.csv';
C1_OVERSAMPLED_TEST_PATH = './dataset/adapted_smote/oversampled/c1_test.csv';

C2_TRAINING_PATH = './dataset/adapted_smote/partitioned/c2_training.csv';
C2_VALIDATION_PATH = './dataset/adapted_smote/partitioned/c2_validation.csv';
C2_TEST_PATH = './dataset/adapted_smote/partitioned/c2_test.csv';

C2_OVERSAMPLED_TRAINING_PATH = './dataset/adapted_smote/oversampled/c2_training.csv';
C2_OVERSAMPLED_VALIDATION_PATH = './dataset/adapted_smote/oversampled/c2_validation.csv';
C2_OVERSAMPLED_TEST_PATH = './dataset/adapted_smote/oversampled/c2_test.csv';

oversample(C2_TRAINING_PATH, C1_TRAINING_PATH, C2_OVERSAMPLED_TRAINING_PATH, C1_OVERSAMPLED_TRAINING_PATH);
oversample(C2_VALIDATION_PATH, C1_VALIDATION_PATH, C2_OVERSAMPLED_VALIDATION_PATH, C1_OVERSAMPLED_VALIDATION_PATH);
oversample(C2_TEST_PATH, C1_TEST_PATH, C2_OVERSAMPLED_TEST_PATH, C1_OVERSAMPLED_TEST_PATH);