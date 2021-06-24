function [test_data,catagory_test] = test_data_colect()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%a = importdata('test_data.txt');


samle_dat = importdata('E:\MSCS-1\Machine Learning\ML_PROJECT\yeast_t.txt');
%samle_dat = importdata('E:\MSCS-1\Machine Learning\ML_PROJECT\scene-test.arff');

[row,col] = size(samle_dat);  
%{
test_data = zeros(row,294);
catagory_test = zeros(row,6);
%disp(catagory_data);

  %  disp(row);
for i=1:row
    for j=1:294
         test_data(i,j) = samle_dat(i,j);
        end
end

  for i=1:row
    count_col = 1;
    for j=295:300
     catagory_test(i,count_col) = samle_dat(i,j);
     count_col = count_col + 1;
    end
 %}   

test_data = zeros(row,103);
catagory_test = zeros(row,14);
%disp(catagory_data);

  %  disp(row);
for i=1:row
    for j=1:103
         test_data(i,j) = samle_dat(i,j);
        end
end

for i=1:row
    count_col = 1;
    for j=104:117
     catagory_test(i,count_col) = samle_dat(i,j);
     count_col = count_col + 1;
    end

end
end

