function oversample( minor_path, major_path, minor_output_path, major_output_path )
    echo off
    
    minor = csvread(minor_path);
    major = csvread(major_path);

    minor_size = size(minor, 1);
    major_size = size(major, 1);
    dif = major_size - minor_size;
    
    copyfile(major_path, major_output_path);
    copyfile(minor_path, minor_output_path);
    
    while dif > 0
        %escolhe randomicamente alguém em classe2 e copia para classe2 novamente
        rand_sample = minor(randi(numel(1:minor_size)),:);
        dlmwrite(minor_output_path, rand_sample, '-append');
        dif = dif - 1
    end
    
end

