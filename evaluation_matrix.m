function eval = evaluation_matrix(C)

eval = zeros(3,6);
%                      |_________class_________|
%______________________|_1_|_2_|_3_|_4_|_5_|_6_|
%(row1)Recall rate     |   |   |   |   |   |   |
%(row2)Precision rate  |   |   |   |   |   |   |
%(row3)F1 measure      |   |   |   |   |   |   |
%-----------------------------------------------

for i=1:1:6
   TP = C(i,i);
   FN = sum(C(i,:)) - C(i,i);
   FP = sum(C(:,i)) - C(i,i);
   %TN = sum(sum(C)) - TP - FN - FP;
   
   %recall rate
   Rr = (TP/(TP+FN))*100;
   eval(1,i) = Rr;
   %precision rate
   Pr = (TP/(TP+FP))*100;
   eval(2,i) = Pr;
   %F1 measure
   eval(3,i) = 2*(Pr*Rr)/(Pr+Rr);   
end

end
