classdef Measurement
    properties (Access = private)
        measurementOperators
        basis
        actOn
        storeOn
    end
    
    methods
        function obj = Measurement(registerLength, varargin)
            %Measurement Construct an instance of this class
            %   Detailed explanation goes here
            import ExeQu.CircuitComposer.*;
            import ExeQu.Utils.Maths.*;
            
            if nargin >= 2
                obj.basis = varargin{1};
            else
                obj.basis = '01';
            end
            
            if nargin == 4
                obj.actOn = varargin{2};
                obj.storeOn = varargin{3};
            end
            
            switch obj.basis
                case '01'
                    obj.measurementOperators = [];
                    operator.name = '0';
                    operator.value = Qubit('0').getDensity();
                    obj.measurementOperators = [obj.measurementOperators operator];
                    operator.name = '1';
                    operator.value = Qubit('1').getDensity();
                    obj.measurementOperators = [obj.measurementOperators operator];
                case '+-'
                    obj.measurementOperators = [];
                    operator.name = '+';
                    operator.value = Qubit('+').getDensity();
                    obj.measurementOperators = [obj.measurementOperators operator];
                    operator.name = '-';
                    operator.value = Qubit('-').getDensity();
                    obj.measurementOperators = [obj.measurementOperators operator];
                otherwise
                    throw(MException('Measurement:ParameterError', "Invalid basis"))
            end
            
            for i = 1:length(obj.measurementOperators)
                t = cell(1, registerLength);
                for j = 1:registerLength
                    if j == obj.actOn
                        t(j) = {obj.measurementOperators(i).value};
                    else
                        t(j) = {eye(2)};
                    end
                end
                obj.measurementOperators(i).value = tensor(t);
            end
        end  
        
        operators = getOperators(self);
        dest = getDestination(self);
        basis = getBasis(self);
        
    end
end

