function trees=run_trees()

A = load('cleandata_students.mat');
all_exs = A.x;
all_tgts = A.y;

[e1, e2, e3, e4, e5, e6, e7, e8, e9, e10] = partition(all_exs);
[t1, t2, t3, t4, t5, t6, t7, t8, t9, t10] = partition(all_tgts);

examples = {};
targets = {};

examples = [examples, [e2; e3; e4; e5; e6; e7; e8; e9; e10]];
targets = [targets, [t2; t3; t4; t5; t6; t7; t8; t9; t10]];

examples = [examples, [e1; e3; e4; e5; e6; e7; e8; e9; e10]];
targets = [targets, [t1; t3; t4; t5; t6; t7; t8; t9; t10]];

examples = [examples, [e1; e2; e4; e5; e6; e7; e8; e9; e10]];
targets = [targets, [t1; t2; t4; t5; t6; t7; t8; t9; t10]];

examples = [examples, [e1; e2; e3; e5; e6; e7; e8; e9; e10]];
targets = [targets, [t1; t2; t3; t5; t6; t7; t8; t9; t10]];

examples = [examples, [e1; e2; e3; e4; e6; e7; e8; e9; e10]];
targets = [targets, [t1; t2; t3; t4; t6; t7; t8; t9; t10]];

examples = [examples, [e1; e2; e3; e4; e5; e7; e8; e9; e10]];
targets = [targets, [t1; t2; t3; t4; t5; t7; t8; t9; t10]];

examples = [examples, [e1; e2; e3; e4; e5; e6; e8; e9; e10]];
targets = [targets, [t1; t2; t3; t4; t5; t6; t8; t9; t10]];

examples = [examples, [e1; e2; e3; e4; e5; e6; e7; e9; e10]];
targets = [targets, [t1; t2; t3; t4; t5; t6; t7; t9; t10]];

examples = [examples, [e1; e2; e3; e4; e5; e6; e7; e8; e10]];
targets = [targets, [t1; t2; t3; t4; t5; t6; t7; t8; t10]];

examples = [examples, [e1; e2; e3; e4; e5; e6; e7; e8; e9]];
targets = [targets, [t1; t2; t3; t4; t5; t6; t7; t8; t9]];

test_examples = {e1, e2, e3, e4, e5, e6, e7, e8, e9, e10};
actual_tgt = {t1, t2, t3, t4, t5, t6, t7, t8, t9, t10};

for i=1:1:1   
    trees{i} = decision_tree(examples{i}, targets{i});
    [test_rows, ~] = size(test_examples{i})
    
    %preallocate the prediction vector
    predict_tgt = zeros(test_rows,1);
    
    % for each row in examples, classify the example using the tree
    for r=1:test_rows
        % test for each of the 6 emotions
        bin_test = [];
        for e=1:1:6
            
            %call classification function
            class_result = get_class(trees{i}(e), test_examples{i}(r:r,:), 0); 
            
            %add to array of solutions if found something
            if class_result
                bin_test = [bin_test, e];
            end
        end
        
        %check how many solutions we have
        sols_found = numel(bin_test);
        
        %ideal scenario - we are sure an example is emotion e
        if (sols_found == 1)
            predict_tgt(r) = bin_test(1);
            
        %non-ideal scenario - we need to pick one of the possible options
        elseif (sols_found > 1)
            %TODO: make this do something smarter than just picking the
            %first one...
            predict_tgt(r) = bin_test(1);
        else
            fprintf("Lie down, try not to cry, cry a lot - the tree isn't working.")
        end
    end
    
    %DO SOME STATS HERE
    
end

end