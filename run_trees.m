function run_trees()

A = load('cleandata_students.mat');
all_exs = A.x;
all_tgts = A.y;

part_exs = partition(all_exs);
part_tgts = partition(all_tgts);

for i=1:1:10
    tmp_e = part_exs;
    tmp_e(i) = [];
    examples(i) = squeeze(tmp_e);
    tmp_t = part_tgts;
    tmp_t(i) = [];
    targets(i) = squeeze(tmp_t);
    
    tree(i) = decision_tree(examples(i), targets(i));
end

end