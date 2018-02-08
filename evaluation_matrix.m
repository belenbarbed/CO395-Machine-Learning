function [eval,CR] = evaluation_matrix(C)

eval = zeros(3,6);
%                      |_________class_________|
%______________________|_1_|_2_|_3_|_4_|_5_|_6_|
%(row1)Recall rate     |   |   |   |   |   |   |
%(row2)Precision rate  |   |   |   |   |   |   |
%(row3)F1 measure      |   |   |   |   |   |   |
%-----------------------------------------------
Total_TP = 0;
Total = sum(sum(C));
CR_array = zeros(1,6);

for i=1:1:6
   TP = C(i,i);
   FN = sum(C(i,:)) - C(i,i);
   FP = sum(C(:,i)) - C(i,i);
   TN = Total - TP - FN - FP;
   Total_TP = Total_TP + TP;
   
   %recall rate
   Rr = (TP/(TP+FN))*100;
   eval(1,i) = Rr;
   %precision rate
   Pr = (TP/(TP+FP))*100;
   eval(2,i) = Pr;
   %F1 measure
   eval(3,i) = 2*(Pr*Rr)/(Pr+Rr);
   %CR
   CR_array(i) = 100*(TP+TN)/Total;
end

CR = mean(CR_array);

end
