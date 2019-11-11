clear

mkdir('./result_smote/');

% Number of iterations for each experiment
iterations = 5;

%{
Config for each neural network execution
format:
    
    config = [
        [training_algorithm,
        output_activation_function,
        hidden_activation_function,
        learning_rates,
        number_hidden_nodes],
        ...
    ]

example:
config = [
    ['trainscg', 'tansig', 'tansig', 0.001, 1],
    ['trainscg', 'tansig', 'tansig', 0.001, 20]
]

%}
%training, output_act, hidden_act, learning rate, number_hidden
config = {
    {'trainlm', 'tansig', 'tansig', 0.1, 60},
    {'trainlm', 'tansig', 'tansig', 0.001, 60},
    {'trainlm', 'tansig', 'tansig', 0.05, 60},
    {'trainlm', 'tansig', 'tansig', 0.07, 60},
    {'trainlm', 'tansig', 'tansig', 0.01, 30}
    }




for i = 1:size(config)
    
    training_algorithm = config{i}{1};
    output_act = config{i}{2};
    hidden_act = config{i}{3};
    learning_rate = config{i}{4};
    hidden_number = config{i}{5};
    
  
    result_directory = sprintf('./result_smote/hidden_nodes=%d--learning_rate=%g--hidden_act_funct=', hidden_number,learning_rate);
    result_directory = strcat(result_directory,hidden_act);
    result_directory = strcat(result_directory,'--output_act_funct=');
    result_directory = strcat(result_directory,output_act);
    result_directory = strcat(result_directory,'--training_algo=');
    result_directory = strcat(result_directory,training_algorithm);

    mkdir(result_directory);
    
    trainMseVector = [];
    validMseVector = [];
    testMseVector = [];
    
    auc0Vector = [];
    auc1Vector = [];
    
    for n = 1:iterations
        fprintf('Running iteration number: %d ...', n);
      
        [targets, otuputs, MSE_train, MSE_valid, MSE_test] = run_neural_network(hidden_number, learning_rate, hidden_act, output_act, training_algorithm);
        
        %Adicionando os valores do MSE
        trainMseVector(end+1) = MSE_train;
        validMseVector(end+1) = MSE_valid;
        testMseVector(end+1) = MSE_test;
        %Calcula a area embaixo da curva ROC
        [X_0,Y_0,T_0,AUC_0] = perfcurve(targets(1,:), otuputs(1,:), 1);
        [X_1,Y_1,T_1,AUC_1] = perfcurve(targets(2,:), otuputs(2,:), 1);
        
        %Adicionando os valores do AUC
        auc0Vector(end+1) = AUC_0;
        auc1Vector(end+1) = AUC_1;
        
        %Criando diretorio de resultados
        iteration = sprintf('/Iteration%d',n);
        outdir2 = strcat(result_directory,iteration);
        mkdir(outdir2);
        
        %Plota a matriz de confusao
        a = figure('Name', 'Confusion Matriz', 'Visible', 'Off');
        plotconfusion(targets, otuputs);
        print(strcat(outdir2, '/Confusion') , '-dpng');
        
        %Plota a curva ROC
        b = figure('Name', 'ROC Curve', 'visible', 'off');
        plotroc(targets, otuputs);
        print(strcat(outdir2, '/ROC'), '-dpng');
        
        delete(a);
        delete(b);
        
    end
    
    meanTrainMse = mean(trainMseVector);
    meanValidMse = mean(validMseVector);
    meanTestMse = mean(testMseVector);
    meanAuc0 = mean(auc0Vector);
    meanAuc1 = mean(auc1Vector);
    
    fileID = fopen(strcat(result_directory, '/results.txt'), 'w');
    fprintf(fileID, 'Results counting %d iterations... \r\n\r\n', n);
    
    str = mat2str(trainMseVector);
    fprintf(fileID, '%s\r\n' ,str);
    fprintf(fileID, 'Mean MSE of the training set: %6.5f \r\n',meanTrainMse);
    fprintf(fileID, 'MSE (standard deviation) of training set: %6.5f \r\n\r\n',std(trainMseVector));
    
    str = mat2str(validMseVector);
    fprintf(fileID, '%s\r\n' ,str);
    fprintf(fileID, 'Mean MSE of the validation set: %6.5f \r\n',meanValidMse);
    fprintf(fileID, 'MSE (standard deviation) of validation set: %6.5f \r\n\r\n',std(validMseVector));
    
    str = mat2str(testMseVector);
    fprintf(fileID, '%s\r\n' ,str);
    fprintf(fileID, 'Mean MSE of the test set: %6.5f \r\n',meanTestMse);
    fprintf(fileID, 'MSE (standard deviation) of test set: %6.5f \r\n\r\n',std(testMseVector));
    
    str = mat2str(auc0Vector);
    fprintf(fileID, 'AUCs-0: %s\r\n' ,str);
    str = mat2str(auc1Vector);
    fprintf(fileID, 'AUCs-1: %s\r\n' ,str);
    
    fprintf(fileID, 'Mean of AUC for both classes:\r\nAUC-0: %0.10f\r\nAUC-1: %0.10f \r\n', meanAuc0, meanAuc1);
    fprintf(fileID, 'Standard deviation of AUC for both classes:\r\nAUC-0: %0.10f\r\nAUC-1: %0.10f \r\n', std(auc0Vector), std(auc1Vector));
    fclose(fileID);
    
    
end







