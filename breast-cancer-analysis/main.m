clear

mkdir('./result');

% Number of iterations for each experiment
iterations = 2;

% Possible values for the number of hidden neurons
number_hidden_nodes =  [1, 5, 15, 30, 60];

% Possible values for the learning rate
learning_rates = [0.001, 0.05, 0.1, 0.4, 0.7, 0.9];

% Possible values for the activation function of intermediate hidden neurons
hidden_activation_function = {'tansig', 'logsig'};

% Possible values for the activation function of output neurons
output_activation_function = {'tansig', 'logsig'};

% Possible values for the learning algorithm 
training_algorithms = {'trainscg', 'trainlm', 'traingdm'};

for v = 1:size(training_algorithms,2)
    for y = 1:size(output_activation_function,2)
        for k = 1:size(hidden_activation_function,2)
            for j = 1:size(learning_rates,2)
                for i = 1:size(number_hidden_nodes,2)
                    result_directory = sprintf('./result/hidden_nodes=%d--learning_rate=%g--hidden_act_funct=', number_hidden_nodes(1,i),learning_rates(1,j));
                    result_directory = strcat(result_directory,hidden_activation_function(1,k));
                    result_directory = strcat(result_directory,'--output_act_funct=');
                    result_directory = strcat(result_directory,output_activation_function(1,y));
                    result_directory = strcat(result_directory,'--training_algo=');
                    result_directory = strcat(result_directory,training_algorithms(1,v));
                    s = result_directory{1};
                    mkdir(s);

                    trainMseVector = [];
                    validMseVector = [];
                    testMseVector = [];

                    auc0Vector = [];
                    auc1Vector = [];

                    for n = 1:iterations
                        fprintf('Running iteration number: %d ...', n);

                        %Assinatura da fun?ao redes neurais, em ordem:
                        %num_intermediate_nodes    num de n?s na camada intermedi?ria(int)
                        %learning_rate             taxa de aprendizagem(doubleO)
                        %activation_function_name  fun?ao de ativa?ao(string)
                        %output_function_name      fun?ao dos n?s de sa?da(string)
                        %learning_algorithm_name   algoritmo de aprendizagem(string)
                        %weigth_algorithm_name)    algoritmo de aprendizegem do pesos(string)

                        %Op??es de fun?ao de ativa?ao:
                        %'tansig', 'logsig', or 'purelin'

                        %Op??es de fun?ao de n? de sa?da:
                        %'tansig', 'logsig', or 'purelin'

                        %Op??es de algoritmo de aprendizagem:
                        %'traincgb', 'traincgf', 'traincgp', 'traingda', 'traingdm', 'traingdx', 'trainlm',
                        %'trainoss', 'trainrp', 'trainscg

                        %Op??es de algoritmo de aprendizagem de peso:
                        %'learngd' or 'learngdm'

                        training_algorithm = training_algorithms(1,v);
                        neurons = number_hidden_nodes(1,i);
                        learning_rate = learning_rates(1,j);
                        act = hidden_activation_function(1,k);
                        out = output_activation_function(1,y);
                        [targets, otuputs, MSE_train, MSE_valid, MSE_test]=run_neural_network(neurons, learning_rate, act{1}, out{1}, training_algorithm{1});

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
                        mkdir(outdir2{1});

                        %Plota a matriz de confusao
                        a = figure('Name', 'Confusion Matriz', 'Visible', 'Off');
                        plotconfusion(targets, otuputs);
                        print(strcat(outdir2{1}, '/Confusion') , '-dpng');

                        %Plota a curva ROC
                        b = figure('Name', 'ROC Curve', 'visible', 'off');
                        plotroc(targets, otuputs);
                        print(strcat(outdir2{1}, '/ROC'), '-dpng');

                        delete(a);
                        delete(b);

                    end

                    meanTrainMse = mean(trainMseVector);
                    meanValidMse = mean(validMseVector);
                    meanTestMse = mean(testMseVector);
                    meanAuc0 = mean(auc0Vector);
                    meanAuc1 = mean(auc1Vector);

                    fileID = fopen(strcat(result_directory{1}, '/results.txt'), 'w');
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
            end
        end
    end
end