classdef QuantumRegister < handle
    properties (Access = private)
        state
    end
    properties (Access = public)
        n_qubits
        notation %initial state notation
    end
    methods (Access = public)
        function obj = QuantumRegister(qreg_n, initState, varargin)
            import ExeQu.CircuitComposer.*
            
            % Initialize state in each index of QuantumRegister using 
            %   state initialize by qubit
            qubits = [];
            obj.notation = "|";
            
            if nargin > 2
                verbose = varargin{1};
            else
                verbose = false;
            end
            
            for index = 1:qreg_n
                if nargin < 2
                    state = '0';
                else 
                    state = initState(index);
                end
                % Get state value initialize by qubit given state specified
                % by user
                qubits = [qubits, Qubit(state)]; 
                obj.notation = obj.notation + state;
            end
            
            % Update total number of qubit
            obj.n_qubits = length(qubits);
            
            % Calculate whole register state through Kronnecker product of
            % each qubit state
            tic
            for iter = 1:obj.n_qubits
                if isempty(obj.state)
                    obj.state = 1;
                end
                % Store calculation result as reguster's state
                obj.state = kron(obj.state, qubits(iter).getState());
                
                % After this loop obj.state should be sparse
            end
            qreg_build_time = toc;
            
            if verbose
                disp('Time used to build qreg:');
                disp(qreg_build_time);
            end
            
            obj.notation = obj.notation + ">";
        end
        
        % Other Functions 
        size = getSize(self);
        state = getState(self);
        density = getDensity(self);
%         setState(self, state);
%         setLabel(self, label);
    end
end