function bool = isUnitary(U)
    [row, col] = size(U);
    bool = row==col & abs(U*U'-eye(row)) < 0.0001; %replace from: isequal(U*U', eye(row*1.0));
end