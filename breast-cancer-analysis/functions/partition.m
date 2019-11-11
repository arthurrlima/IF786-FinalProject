function partition(class_path, training_path, validation_path, test_path)
    class = csvread(class_path);
    class_size = size(class,1);

    shuffled = class(randperm(class_size),:);

    training_size = floor(0.50*class_size);
    validation_size = floor(0.25*class_size);
    test_size = class_size - training_size - validation_size;
    
    fopen(training_path, 'w');
    fopen(validation_path, 'w');
    fopen(test_path, 'w');
    
    for i=1:training_size
        dlmwrite(training_path, shuffled(i,:), '-append');
    end
    for i=1:validation_size
        dlmwrite(validation_path, shuffled(i + training_size,:), '-append');
    end
    for i=1:test_size
        dlmwrite(test_path,shuffled(i + training_size + validation_size,:), '-append');
    end
    
    fclose('all');

end