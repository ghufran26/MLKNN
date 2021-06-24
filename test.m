function [] = test()
        label = cell(5,1);
       % label{1,1} = [label{1,1},2];
       lb  = [1 0 1 1];
       i =1;
       for j=1:4
           if lb(j) == 1
             label{i,1} = [label{i,1},j];
           end
       end
       lb_p = [1 1 0 1];
       [temp index] = sort(lb_p);
      disp(index);
      disp(label{1,1});
       temp_min = 5;
       for l = 1:3
        [val loc] = ismember(label{1,1}(l),index);
         if loc < temp_min
          temp_min = loc;
         end
       end
       disp(temp_min);
       
       % disp(loc);
        %{
         index = [2 5 1 3 4];
        %label{1,1} = 1; 
       [val loc]   = ismember(label{1,1}(1),index);
 %}
       
%disp(label{1,1});

end
%{

pred_array = [
                   0     0     0     0     0     0     0     0     0     0     0     1     1     0;
                   0     0     1     0     0     0     0     0     0     0     0     1     1     0;
                   0     1     1     0     0     0     0     0     0     0     0     1     1     0;
                   0     1     1     0     0     0     0     0     0     0     0     1     1     0;
                   0     0     0     0     0     0     0     0     0     0     0     1     1     0;
                   0     0     0     0     0     0     0     0     0     0     0     1     1     0;
                   1     0     0     0     0     0     0     0     0     0     0     1     1     0;
                   0     1     0     0     0     0     0     0     0     0     0     1     1     0
                  ];
actual          = [
                    0     0     0     0     0     0     1     1     0     0     0     1     1     0;
                    0     0     1     1     0     0     0     0     0     0     0     0     0     0;
                    0     1     1     0     0     0     0     0     0     0     0     1     1     0;
                    0     0     1     1     0     0     0     0     0     0     0     0     0     0;
                    0     0     1     1     1     1     0     0     0     0     0     0     0     0;
                    0     0     0     0     0     0     0     0     0     1     1     1     1     0;
                    1     0     0     0     0     0     0     0     0     0     0     1     1     0;
                    1     0     1     1     0     0     0     0     0     0     0     1     1     0

                  ]; 
              counter = 0;
              sum = 0;
              for i = 1 : 8
                  for j = 1 : 14
                    if pred_array(i,j) ~= actual(i,j)
                     counter = counter + 1;
                    end
                    
                  end
                  disp(counter);
                  sum  = sum + (counter/14);
                  counter = 0;
              end
              ham = (sum/8);
              disp(ham);
%}
