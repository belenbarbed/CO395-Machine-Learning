function [decision_tree] = decision_tree_learning(examples,attrs,tgts)
%if all binary targets are the same, return a leaf node with that target
if all(tgts==0) || all(tgts==1)
    decision_tree = struct('class',tgts(1),'kids',[]);

%if no more attributes to pick, return leaf with majority value
elseif isempty(attrs)
    %majority value == mode of targets
    decision_tree = struct('class',mode(tgts),'kids',[]);

%else perform ID3 algorithm to select which attribute to split on
else
    best_attr = choose_best_decision_attribute(examples,attrs,tgts);
    new_tree.op = best_attr;
    [rows, ~] = size(examples);
    
    zero_ex = [];
    zero_tgt = [];
    one_ex = [];
    one_tgt = [];
    
    %split examples according to the selected attribute
    for row=1:rows
        if examples(row,best_attr)==0
            zero_ex=[zero_ex, examples(row,:)];
            zero_tgt=[zero_tgt, tgts(row)];
        else 
            one_ex=[one_ex, examples(row,:)];
            one_tgt=[one_tgt, tgts(row)];
        end
    end
        
    %handle zero cases
    if isempty(zero_ex)
        new_tree.kids{0} = struct('class',mode(zero_tgt),'kids',[]);
    else
        new_attrs = attrs;
        new_attrs(best_attr) = [];
        new_tree.kids{0} = decision_tree_learning(zero_ex, new_attrs, zero_tgt);
    end    
    %handle one cases
    if isempty(one_ex)
        new_tree.kids{1} = struct('class',mode(one_tgt),'kids',[]);
    else
        new_attrs = attrs;
        new_attrs(best_attr) = [];
        new_tree.kids{1} = decision_tree_learning(one_ex, new_attrs, one_tgt);
    end    
%return
    decision_tree = new_tree;
end
end

