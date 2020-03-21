function out = samplingDistribution(proba)
    r = rand;
    out = sum(r >= cumsum([0, proba]));
end