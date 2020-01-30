function peekOperations(self)
    op_struct = self.operationQueue;
    
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