classdef Unitary
    properties (Access = public)
        label
    end
    properties (Access = private)
        unitaryMatrix
        actOn
        dimension
    end
    methods 
        function obj = Unitary(U, varargin)
            % Unitary(U)
            % Unitary(U, registerLength, actOn, label)
            import ExeQu.Utils.Maths.*;

            % Get number of row and column of the given Unitary Matrix (U)
            [row, column] = size(U);
            
            % Check if it's unitary
            if ~isUnitary(U)  
                throw(MException('Unitary:ParameterError', "1st argument is not a valid unitary matrix"))
            end
            
            % Verify parameters
            switch nargin
                case 1
                    label = 'U';
                    registerLength = 1;
                    actOn = [];
                case 3
                    label = 'U'; % If not specified label is 'U' by default
                    registerLength = varargin{1};
                    actOn = varargin{2};
                case 4
                    registerLength = varargin{1};
                    actOn = varargin{2};
                    label = varargin{3};
                otherwise
                    throw(MException('Unitary:ParameterError', "Invalid number of parameter"))
            end
            
            % Initialize identity matrix
            persistent I
            I = sparse(eye(2));
            U = sparse(U);
            
            % Contruct unitary matrix for the whole system
            if row < 2^registerLength
                temp = cell(1);
                % Iterate through each qubit in the circuit to determine 
                % which qubit will be transform by U or will be ignored 
                % using Identity (I)

                iter = 1;
                while iter <= registerLength
                    if ~ismember(iter, actOn)
                        temp{iter} = I;
                        iter = iter + 1;
                    else
                        temp{iter} = U;
                        iter = iter + log2(row);
                    end
                end

                % Tensor product all information gathered above into one 
                % unitary matrix (U)
                temp = temp(~cellfun(@isempty, temp));
%                 tic
                U = tensor(temp);
%                 U_tensor_time = toc
            end
            
            % Set object attributes
            obj.unitaryMatrix = U;
            obj.actOn = actOn;
            obj.label = label;
            obj.dimension = [row column];
        end
        
        % Other Functions
        matrix = toMatrice(self);
        label = getLabel(self);
        mt = mtimes(varargin);
    end
end