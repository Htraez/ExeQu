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
            [row, column] = size(U);
            if ~isUnitary(U) %Check if it's unitary 
                throw(MException('Unitary:ParameterError', "1st argument is not a valid unitary matrix"))
            end
            
            if(nargin < 4)
                label = 'U';
            else
                label = varargin{1};
            end
            
            persistent I
            I = [1 0; 0 1];
            
            if row < 2^registerLength
                temp = cell(1);
                for iter = 1:registerLength-log2(row)+1
                    if ~ismember(iter, actOn)
                        temp{iter} = I;
                    else
                        temp{iter} = U;
                    end
                end
                U = tensor(temp);
            end
            
            obj.unitaryMatrix = U;
            obj.actOn = actOn;
            obj.label = label;
            obj.dimension = [row column];
        end
        
        matrix = toMatrice(self);
        label = getLabel(self);
    end
    
end