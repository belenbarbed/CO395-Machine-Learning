function entropy = get_entropy(binary_targets)

[p,~] = size(find(binary_targets == 1));
[n,~] = size(find(binary_targets == 0));

entropy = -(p/(p+n))*log2(p/(p+n))-(n/(p+n))*log2(n/(p+n));

end

