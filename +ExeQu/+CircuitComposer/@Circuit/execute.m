function result = execute(self, n_shots)
    import ExeQu.CircuitComposer.plotHistogram;
    import ExeQu.CircuitComposer.getCount;
    
    if nargin < 2
        n_shots = 1000;
    end
    if ~isempty(self.operationQueue)
        
        % Create empty quantum register to hold probability result
        result.classicalRegister = cell(1, self.classicalBits);
        
        for op = self.operationQueue
            op = op{:}; % Grab one operation from queue
            if isfield(op, 'unitaryOperation') 
                % If it's a gate do this...
                target = self.quantumRegister;
                unitary_result = op.unitaryOperation * target;
                % Store unitary result in "state" property of qreg
                self.quantumRegister.setState(unitary_result);
            elseif isfield(op, 'measurementOperation') 
                % If it's a measurement do this...
                operation = op.measurementOperation;
                destination = operation.getDestination();
                for operator = operation.getOperators() 
                    % Do this for each measurement operator in selected basis
                    % e.g. For basis 0 1
                    % - M0 = Measure |0>
                    % - M1 = Measure |1>
                    
                    state = self.quantumRegister.getState(); % Get lastest state matrix
                    
                    measurement_result.state = operator.name;
                    measurement_result.probability = state'*operator.value*state;

                    result.classicalRegister{destination} = [result.classicalRegister{destination} measurement_result];
                    % classicalRegister{destination} will hold probrability
                    % for M0 and M1 so it's an array
                end
            end
        end
        result.shots = n_shots;
        result.getCount = @(varargin) getCount(result.classicalRegister, result.shots, varargin);
        result.plotHistogram = @() plotHistogram(result.getCount(true), result.shots);
    else
        disp("No operations to execute. Aborted");
    end
end