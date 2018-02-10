function [class, final_depth] = get_class(tree, example, curr_depth)

if isempty(tree.kids)
    class = tree.class;
    final_depth = curr_depth;
else
    [class, final_depth] = get_class(tree.kids{example(tree.op)+1}, example, curr_depth+1);
end

end

