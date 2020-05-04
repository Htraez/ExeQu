function result = execute(self, n_shots, varargin)
    import ExeQu.CircuitComposer.plotHistogram;
    import ExeQu.CircuitComposer.getCount;
    import ExeQu.Utils.*;
    
    if nargin < 2
        n_shots = 1000;
        snapshotMode = false;
    elseif nargin > 2
        snapshotMode = varargin{1};
    else
        snapshotMode = false;
    end
    if ~isempty(self.operationQueue)
        
        % Create empty quantum register to hold probability result
        result.classicalRegister = ...
            createStateMap(self.quantumRegister.getSize());
        result.measurementQueue = [];
        result.measureMap = ...
            containers.Map('KeyType','double', 'ValueType','double');
        
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
                if snapshotMode
                    calculateMeasurement(op);
                end
                origin = op.measurementOperation.getOrigin();
                dest = op.measurementOperation.getDestination();
                result.measurementQueue = [result.measurementQueue op];
                result.measureMap(dest) = origin;
            end
        end
        
        if ~snapshotMode
            for op = result.measurementQueue
                calculateMeasurement(op);
            end
        end
        
        % Re-map classicalRegister
        result.classicalRegister = mapMeasurement(self.classicalBits, result.classicalRegister, result.measureMap);
        
        result.shots = n_shots;
        result.getCount = @(varargin) getCount(result.classicalRegister, result.shots, varargin);
        result.plotHistogram = @() plotHistogram(result.getCount(true), result.shots);
    else
        disp("No operations to execute. Aborted");
    end
    
    function calculateMeasurement(op)
        operators = op.measurementOperation.getOperators();
        state = self.quantumRegister.getState();

        for operatorKey = operators.keys
            % Do this for each measurement operator in selected basis
            % This will calculate measurement result for all qubits
            %   in the system at once in all possible combinations
            %   using operators generated when user call
            %   circuit.measure(circuitLen, basis, fromQ, toC)
            % e.g. For basis 'z' in 2 qubit system
            % - M00 = Measure |00>
            % - M01 = Measure |01>
            % - M10 = Measure |10>
            % - M11 = Measure |11>
            result.classicalRegister(operatorKey{:}) = ...
                state'*operators(operatorKey{:})*state;
        end
    end
end