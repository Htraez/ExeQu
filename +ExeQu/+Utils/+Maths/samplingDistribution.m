function out = samplingDistribution(proba)
    if length(proba) > 2 
        % In case measure to 1 creg-bit multiple time, will focus only the
        % lastest measurement's probability
        proba = [proba(end-1) proba(end)];
    end
    r = rand;
    out = sum(r >= cumsum([0, proba]));
end