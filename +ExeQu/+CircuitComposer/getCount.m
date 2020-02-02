function out = getCount(c_reg, shots, varargin)
    n_bits = length(c_reg);
    
    if ~isempty(varargin{1})
        omit_summary = varargin{1}{1};
    else
        omit_summary = false;
    end
    
    out = containers.Map(string(dec2bin(0:2^n_bits-1))',zeros(1, 2^n_bits));
    %for samplingSize here
    for round = 1:shots
        sample = '';
        for i = 1:n_bits
            bit_i = c_reg{i};
            vals = [];
            proba = [];
            for proba_j = bit_i
                vals = [vals, str2num(proba_j.state)];
                proba = [proba proba_j.probability];
            end
    %       Generate number from distribution
            if isempty([vals; proba])
                sample = [sample num2str(0)];
                continue;
            end
            import ExeQu.Utils.Maths.samplingDistribution;
            x = samplingDistribution(proba);
            sample = [sample num2str(vals(x))];
        end
        out(sample) = out(sample) + 1;
    end
    
    if ~omit_summary
        disp(table(cell2mat(out.keys'), ...
            cell2mat(out.values'), ...
            cell2mat(out.values')/shots*100, ...
            'VariableNames',{'State','Count','%'}));
    end
    
end