function [training_data,catagory_data] = sample_data(  )
samle_dat = importdata('E:\MSCS-1\Machine Learning\ML_PROJECT\yeast_tr.txt');
%samle_dat = importdata('E:\MSCS-1\Machine Learning\ML_PROJECT\scene-train.arff');

[row,col] = size(samle_dat);  

%{
 training_data = zeros(row,294);

catagory_data = zeros(row,6);

for i=1:row
    for j=1:294
         training_data(i,j) = samle_dat(i,j);
        end
end
for i=1:row
    count_col = 1;
    for j=295:300
     catagory_data(i,count_col) = samle_dat(i,j);
     count_col = count_col + 1;
    end
end
%}

training_data = zeros(row,103);
catagory_data = zeros(row,14);
for i=1:row
    for j=1:103
         training_data(i,j) = samle_dat(i,j);
    end
end
for i=1:row
    count_col = 1;
    for j=104:117
     catagory_data(i,count_col) = samle_dat(i,j);
     count_col = count_col + 1;
    end
end
%disp(training_data(1,103));
%disp(catagory_data);
end