C1_TRAINING_PATH = './dataset/adapted_smote/oversampled/c1_training.csv';
C1_VALIDATION_PATH = './dataset/adapted_smote/oversampled/c1_validation.csv';
C1_TEST_PATH = './dataset/adapted_smote/oversampled/c1_test.csv';

C2_TRAINING_PATH = './dataset/adapted_smote/oversampled/c2_training.csv';
C2_VALIDATION_PATH = './dataset/adapted_smote/oversampled/c2_validation.csv';
C2_TEST_PATH = './dataset/adapted_smote/oversampled/c2_test.csv';

TRAINING_PATH = './dataset/adapted_smote/concat/training.csv';
VALIDATION_PATH = './dataset/adapted_smote/concat/validation.csv';
TEST_PATH = './dataset/adapted_smote/concat/test.csv';

concat(C1_TRAINING_PATH, C2_TRAINING_PATH, TRAINING_PATH);
concat(C1_VALIDATION_PATH, C2_VALIDATION_PATH, VALIDATION_PATH);
concat(C1_TEST_PATH, C2_TEST_PATH, TEST_PATH);