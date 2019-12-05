function bool = isUnitary(U)
    [row, col] = size(U);
    bool = row==col && isequal(U*U', eye(row));
end