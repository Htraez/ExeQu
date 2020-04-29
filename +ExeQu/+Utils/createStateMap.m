function out = createStateMap(n_bits)
    strKeys = string(dec2bin(0:2^n_bits-1))';
    charKeys = cellstr(strKeys(:))';
    defaultValues = zeros(1, 2^n_bits);
    out = containers.Map('KeyType','char', 'ValueType','any');
    for charKey = charKeys
        out(charKey{:}) = sparse(0);
    end
%     out = containers.Map(charKeys, defaultValues);
end