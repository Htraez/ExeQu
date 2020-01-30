classdef Qubit
    properties (Access = private)
        state
        densityMatrix
    end
    properties (Access = public)
        index
        label
        notation %initial state notation
    end
    methods (Access = public)
        function obj = Qubit(initState, index)
            persistent ketzero
            persistent ketone
            
            ketzero = [1+0i;0+0i];
            ketone = [0+0i;1+0i];
            if nargin < 2
                obj.index = 1;
            else
                obj.index = index;
            end
            if isa(initState, 'char')
                switch initState
                    case '0'
                        obj.state = ketzero;
                        obj.notation = '|0>';
                    case '1'
                        obj.state = ketone;
                        obj.notation = '|1>';
                    case '+'
                        obj.state = (1/sqrt(2))*(ketzero+ketone);
                        obj.notation = '|+>';
                    case '-'
                        obj.state = (1/sqrt(2))*(ketzero-ketone);
                        obj.notation = '|->';
                    otherwise
                        error('Unknow state supply for qubit initialization')
                end
            end
        end
        
        state = getState(self) 
        ket = getKet(self)
        bra = getBra(self)
        dense = getDensity(self)
        result = apply(self, operator)
    end
end