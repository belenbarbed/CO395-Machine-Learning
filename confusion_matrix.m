function C = confusion_matrix(actual,predicted)
    % Matlab built-in function:
    %C = confusionmat(actual,predicted);
    
    % Ben implementation, tested against Matlab function
    C = zeros(6,6);
    
    for i = 1:length(actual)
        if ~isnan(predicted(i))
            C(actual(i),predicted(i)) = C(actual(i),predicted(i)) + 1;
        end
    end
    