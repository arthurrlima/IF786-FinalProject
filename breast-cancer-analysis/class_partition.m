DATASET_PATH = './dataset/mammography_clean.csv';
C1_PATH = './dataset/simple/c1.csv';
C2_PATH = './dataset/simple/c2.csv';

dataset = csvread(DATASET_PATH);
dataset_size = size(dataset, 1);

fopen(C1_PATH, 'w');
fopen(C2_PATH, 'w');

for i = 1:dataset_size
   if dataset(i,end) == 0
      dlmwrite(C1_PATH, [dataset(i, :) 1], '-append'); 
   else
      dlmwrite(C2_PATH, [dataset(i, :) 0], '-append'); 
   end
end

fclose('all');