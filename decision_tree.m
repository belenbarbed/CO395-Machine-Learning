function tree=decision_tree()

A = load('cleandata_students.mat');
ex = A.x;
all_t = A.y;

att = 1:45;

for i=1:6
    t = all_t;
    t(t~=i)=0;
    t(t==i)=1;
    [tree(i)]=decision_tree_learning(ex, att, t);
end
end