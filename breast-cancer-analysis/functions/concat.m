function concat( a_path, b_path, output_path )

    a = csvread(a_path);
    b = csvread(b_path);
    
    merged = [a;b];
    
    shuffled = merged(randperm(size(merged,1)),:);
    
    dlmwrite(output_path, shuffled);

end

