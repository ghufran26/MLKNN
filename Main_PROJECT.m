%{

7 7 bad 
7 4 bad 
3 4 good
1 4 good
(3,7) test instance
%}

k = 7;
[tr,catg]=sample_data();
% tr,catg
%{  
 tr = [
          1 0.1 3 1 0;
          0 0.9 1 0 1;
          0 0   1 1 0;
          1 0.8 2 0 1;
          1 0   2 0 1
        
         ];
    catg =[
          0 1 1 0;
          1 0 0 0;
          0 1 0 0;
          1 0 0 1;
          0 0 0 1
          ];

tr = [
          1 0.1 3 1 0;
          0 0.9 1 0 1;
          0 0   1 1 0;
          1 0.8 2 0 1;
          1 0   2 0 1;
          0 1   3 1 0;
          1 0   1 2 0;
          1 0   0 1 3;
          2 0   1 1 2;
          0.1 0.80 2 1 3;
          0.30 0.2 1 1 2
         ];
    catg =[
          0 1 1 0;
          1 0 0 0;
          0 1 0 0;
          1 0 0 1;
          0 0 0 1;
          1 0 0 0;
          0 1 1 0;
          1 0 0 1;
          1 1 0 1;
          1 0 0 1;
          1 0 1 1
          ];

      test_data = [0 0 3 1 1];
%}
    %  test_data = zeros(1,103);

[test_d,test_catg]= test_data_colect();
    %disp(test); 
    
     s = 1;
    [row,col]     = size(tr);
    [c_row,c_col] = size(catg); 
    
%[top_min_distance,index_set]=ML_Knn(t,c,k);
sum_label = zeros(1,c_col);
sum = 0;
%disp(c);
% calculate prior probabilty
    for i_col = 1:c_col
         sum = 0;
         for i_cat = 1 : c_row
            sum  = sum + catg(i_cat,i_col);  
         end
         sum_label(i_col) = sum;
    end    
    prior_prob_one  = zeros(1,c_col);
    prior_prob_zero = zeros(1,c_col);
    s = 1;
    for row_i = 1:c_col
        prior_prob_one(row_i) = (s + (sum_label(row_i)))/( (s*2)+ c_row);
        prior_prob_zero(row_i)= 1 - prior_prob_one(row_i); 
    end
     %disp(prior_prob_one);
     %disp(prior_prob_zero);
    %computing the posterior probabilty
   c1_k = zeros(1,(k+1));
   c0_k = zeros(1,(k+1));
   delta=0;
   post_prob_one  = zeros(c_col,k+1);
   post_prob_zero = zeros(c_col,k+1);
  
   for class_label = 1 : c_col
       %disp('for l : ');
       %disp(class_label);
       for j=1:(k+1)
          c1_k(j) = 0;
          c0_k(j) = 0;
        end
        for i=1 : c_row
             Count_ones = 0;
             [k_nearest,k_index_array] = ML_Knn(tr,tr,k,i);
             for cout_ones = 1:k
                if catg(k_index_array(cout_ones),class_label) == 1 
                    Count_ones = Count_ones + 1;
                end
             end   
              delta = Count_ones;
              if catg(i,class_label) == 1
                 c1_k(delta+1) = c1_k(delta+1) + 1; 
              else
                 c0_k(delta+1) = c0_k(delta+1) + 1; 
              end
              % sum_function(catg,k_index_array,class_label,k);
             %disp(delta);
    %         break;
        end
       
       % disp(c1_k);
       % disp(c0_k);
       % totalsum = sum_function(c0_k,k+1);
       % disp('bbbbb');
       % disp(totalsum);
       
        for c = 1:(k+1)
          post_prob_one(class_label,c)  =  (s + c1_k(c))/(s * (k+1) + sum_function(c1_k,k+1)); 
          post_prob_zero(class_label,c) =  (s + c0_k(c))/(s * (k+1)+ sum_function(c0_k,k+1));
        end
      %  disp(post_prob_one);
      % disp(post_prob_zero);        
   end
      c_test_count = 0;
      predict_label = zeros(1,c_col);
      [row_test,col_test] = size(test_catg);
      ranking_function = zeros(row_test,col_test);
      p_labels = zeros(row_test,col_test);
      a_labels = zeros(row_test,col_test);
      for hhh = 1 : row_test
      test_data = zeros(1,col);

      for j=1:col
         test_data(j) = test_d(hhh,j);
      end 
      
      co_count_equal = 0;
      for class_label = 1 : c_col
         [k_nearest,k_index_array] = ML_Knn(tr,test_data,k,1);
       
         for cout_ones = 1:k
                if catg(k_index_array(cout_ones),class_label) == 1 
                    c_test_count = c_test_count + 1;
                end         
         end 
         %disp(c_test_count);
         ones_prob = prior_prob_one(class_label)*(post_prob_one(class_label,c_test_count + 1));
         zero_prob = prior_prob_zero(class_label)*(post_prob_zero(class_label,c_test_count + 1));
         ranking_function(hhh,class_label) = ones_prob/(ones_prob + zero_prob);
         if ones_prob>zero_prob
            predict_label(class_label) = 1;
         else
            predict_label(class_label) = 0;
         end
          p_labels(hhh,class_label)= predict_label(class_label);
          a_labels(hhh,class_label)= test_catg(hhh,class_label);
          c_test_count = 0;
      %   disp(a_labels(hhh));      
      end
   end 
    %disp(p_labels);
%%%%%%%%%%%%%%%%%%%%%%%%%%%         Hamming Loss        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

              counter = 0;
              sum = 0;
              for i = 1 : row_test
                  for j = 1 : col_test
                    if p_labels(i,j) ~= test_catg(i,j)
                     counter = counter + 1;
                    end  
                  end
                 % disp(counter);
                  sum  = sum + (counter/col_test);
                  counter = 0;
              end
              ham = (sum/row_test);
              disp(ham);
     
 %%%%%%%%%%%%%%%%%%%%%%%%% one_error %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     test_catg_ones_index = zeros(row_test,col_test);
     labelones_size = zeros(row_test,1);
     coverage_sum = 0;
     sum=0;
     for i_rank = 1 : row_test
         for count_lb = 1:col_test
               if test_catg(i_rank,count_lb)==1
                  sum = sum +1;
               end
         end
         labelones_size(i_rank) = sum;
         sum = 0;         
         index_counter = 1;
         for j_rank = 1 : col_test
               if  test_catg(i_rank,j_rank) == 1
                   test_catg_ones_index(i_rank,index_counter) = j_rank;
                   index_counter = index_counter + 1;
               end
         end
     end
     oneerror = 0;
        for index_i = 1 : row_test
            flag = 0;
            temp = ranking_function(index_i,:);
          %  disp(temp);
            max1 = 0;
            for temp_i = 1 : col_test
                 if max1 < temp(temp_i)
                     max1 = temp(temp_i);
                 end
            end
            maximum=max1;
            for k = 1 : col_test
                if temp(k) == maximum
                    for ismem = 1 : labelones_size(index_i) 
                        if test_catg_ones_index(index_i,ismem)==k
                            flag =1;
                            break;
                        end
                    end
                    if flag == 1
                       break;
                    end
                end
            end
            if flag == 0
                oneerror = oneerror + 1;
            else
                flag = 0;
            end
        end
     oneError = oneerror/row_test;
     disp(oneError);  
  
     
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Coverage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     test_catg_ones_index_cov = zeros(row_test,col_test);
     labelones_size_cov = zeros(row_test,1);
     coverage_sum = 0;
     sum=0;
     [total_row,total_col]=size(ranking_function);
       test_catg_ones_index = zeros(row_test,col_test);
     
     coverage_sum = 0;
     sum=0;
     for i_rank = 1 : row_test
         for count_lb = 1:col_test
               if test_catg(i_rank,count_lb)==1
                  sum = sum +1;
               end
         end
         labelones_size_cov(i_rank) = sum;
         sum = 0;         
         index_counter = 1;
         for j_rank = 1 : col_test
               if  test_catg(i_rank,j_rank) == 1
                   test_catg_ones_index(i_rank,index_counter) = j_rank;
                   index_counter = index_counter + 1;
               end
         end
     end
       cover=0;
       for i=1:row_test
           temp = ranking_function(i,:);
           [tempvalue,index]=sort(temp);
           temp_min=total_col + 1;
           for m=1:labelones_size_cov(i)
               [tempvalue,index_catg]= ismember(test_catg_ones_index(i,m),index);
               if(index_catg<temp_min)
                   temp_min=index_catg;
               end
           end
           cover=cover+(total_col-temp_min+1);
        end
       Coverage=(cover/total_row)-1;
       disp(Coverage);
     
       
     
     
     