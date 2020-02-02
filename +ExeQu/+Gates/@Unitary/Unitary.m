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
        function obj = Unitary(U, registerLength, actOn, varargin)
            import ExeQu.Utils.Maths.*;
            
            % Get number of row and column of the given Unitary Matrix (U)
            [row, column] = size(U);
            
            % Check if it's unitary
            if ~isUnitary(U)  
                throw(MException('Unitary:ParameterError', "1st argument is not a valid unitary matrix"))
            end
            
            % Specify label
            if(nargin < 4)
                label = 'U';
            else
                label = varargin{1};
            end
            
            % Initialize identity matrix
            persistent I
            I = eye(2);
            
            % Contruct unitary matrix for the whole system
            if row < 2^registerLength
                temp = cell(1);
                % Iterate through each qubit in the circuit to determine 
                % which qubit will be transform by U or will be ignored 
                % using Identity (I)
    % <OLD>           for iter = 1:registerLength-log2(row)+1
    %                     if ~ismember(iter, actOn)
    %                         temp{iter} = I;
    %                         disp('I')
    %                     else
    %                         temp{iter} = U;
    %                         disp('U')
    %                     end
    %                 end
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
%                 celldisp(temp)
                U = tensor(temp);
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