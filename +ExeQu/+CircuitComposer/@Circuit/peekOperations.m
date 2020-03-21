function out = peekOperations(self, varargin)
    verbose = false;
    if nargin > 1
        if(isequal(class(varargin{1}),'logical'))
            verbose = varargin{1};
        end
    end
    
    op_struct = self.operationQueue;
    out = op_struct;
    
    if ~verbose
        return
    end
    
    iter = 1;
    for i = op_struct
        i = cell2mat(i);
        disp("Operation #"+iter);
        disp("Label: "+i.label);
        disp("Act On: ["+i.associatedQubit+"]");
        if isfield(i, 'unitaryOperation')
            disp(i.unitaryOperation.toMatrice());
        end
        if isfield(i, 'measurementOperation')
            if isequal(i.measurementOperation.getBasis(), '+-')
                disp("Basis: {|+>, |->}")
            elseif isequal(i.measurementOperation.getBasis(), '01')
                disp("Basis: {|0>, |1>}")
            end
            for operator = i.measurementOperation.getOperators()
                disp("  operator: |"+operator.name+"><"+operator.name+"|")
                disp(operator.value);
            end
        end
        iter = iter + 1;
    end
    
end