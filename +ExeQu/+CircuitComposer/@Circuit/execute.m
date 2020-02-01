function result = execute(self, n_shots)
    import ExeQu.CircuitComposer.plotHistogram;
    import ExeQu.CircuitComposer.getCount;
    
    if nargin < 2
        n_shots = 1000;
    end
    if ~isempty(self.operationQueue)
        
        result.classicalRegister = cell(1, self.classicalBits);
        for op = self.operationQueue
            op = op{:};
            if isfield(op, 'unitaryOperation')
                unitary_result = op.unitaryOperation * self.quantumRegister;
                self.quantumRegister.setState(unitary_result);
            elseif isfield(op, 'measurementOperation')
                operation = op.measurementOperation;
                destination = operation.getDestination();
                for operator = operation.getOperators()
                    state = self.quantumRegister.getState();
                    
                    measurement_result.state = operator.name;
                    measurement_result.probability = state'*operator.value*state;

                    result.classicalRegister{destination} = [result.classicalRegister{destination} measurement_result];
                    result.shots = n_shots;
                    result.getCount = @(varargin) getCount(result.classicalRegister, result.shots, varargin);
                    result.plotHistogram = @() plotHistogram(result.getCount(true), result.shots);
                end
            end
        end
    else
        disp("No operations to execute. Aborted");
    end
end