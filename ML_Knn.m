function [top_k_nearest,top_k_index] = ML_Knn(t,t_c,k,index_row)
   %disp(t);
%{
sample_data = [
                 7 7;
                 1 4;
                 7 4;
                 3 4
               ];
%} 
%catagory_vec = [0,0,0,0,0,0,1,1,0,0,0,1,1,0];
 %catagory_vec =string(catagory_vec);
 %test_instance = [0.004168,-0.170975,-0.156748,-0.142151,0.058781,0.026851,0.197719,0.04185,0.066938,-0.056617,-0.02723,-0.137411,0.067776,0.047175,0.155671,0.050766,0.102557,-0.020259,-0.200512,-0.095371,-0.08194,-0.103735,0.093299,0.105475,0.14856,0.085925,0.107879,0.108075,0.085388,0.124026,-0.00365,-0.127376,0.039394,-0.018364,0.050378,0.15719,0.203563,0.111552,0.017907,-0.001126,0.053062,0.140708,0.137118,-0.090282,-0.067809,-0.102396,-0.051758,0.050665,0.007055,0.021674,0.061283,0.083523,0.053235,0.001978,0.077418,0.046762,-0.07573,-0.092787,0.127297,-0.178029,-0.202705,-0.028543,0.032891,0.023189,0.009716,-0.169848,-0.002261,-0.133029,0.082378,-0.21661,0.062425,-0.128243,0.203676,0.143642,0.178602,0.192041,0.154135,-0.175325,-0.133636,0.005524,-0.014981,-0.031946,-0.015114,-0.047175,0.003829,0.010967,-0.006062,-0.02756,-0.019866,-0.024046,-0.025153,-0.009261,-0.025539,0.006166,-0.012976,-0.014259,-0.015024,-0.010747,0.000411,-0.032056,-0.018312,0.030126,0.124722];
 %disp('aaa');
 %disp(index_row);
 
 [row,col]= size(t_c);
 [row_t,col_t] = size(t);
 distance = zeros(row-1,1);
 index_set = 1;
 %disp('for row');
 %disp(index_row);
 for i=1:row_t
     sum = 0.0;
    for j=1:col_t
         if i ~= index_row || row == 1 
            sum = sum + (t(i,j) - t_c(index_row,j)).^2;
         end
    end
    if index_row == i && row ~= 1
        distance(i) = 0;        
    else
        distance(i) = sqrtm(sum);
   %     disp('distance');
   %      disp('For '); disp(i);
   %     disp(distance(i));
    end
 end
 if row ~= 1
        distance(index_row) = max(distance) + 1;
 end 
 [k_nearest,index] = sort(distance);
 % top k nearest neibour with minimum distance
 top_k_nearest = zeros(k,1);
 top_k_index   = zeros(k,1);
 for row = 1:k
     top_k_nearest(row) = k_nearest(row);
     top_k_index(row)   = index(row);
 end
