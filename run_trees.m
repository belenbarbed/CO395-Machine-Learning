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

for i=1:1:10   
    trees{i} = decision_tree(examples{i}, targets{i});
end

end