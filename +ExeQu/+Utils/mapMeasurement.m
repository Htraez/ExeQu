function out = mapMeasurement(n_bits, c_reg, measureMap)
    import ExeQu.Utils.*;
    
    cregIndex = measureMap.keys;
    maxCregIndex = max([cregIndex{:}]);
    out = createStateMap(n_bits);
    for key = c_reg.keys
        keyStr = key{:};
        newKeyStr = repmat('0', [1 n_bits]);
        for i = cregIndex
            newKeyStr(i{:}) = keyStr(measureMap(i{:}));
        end
%         newKeyStr
        oldValue = out(newKeyStr);
        newValue = c_reg(keyStr);
        out(newKeyStr) = oldValue + newValue;
    end
%     c_reg.values
%     out.values
end