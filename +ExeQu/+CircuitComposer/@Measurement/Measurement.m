classdef Measurement
    properties (Access = private)
        measurementOperators
        operatorMap
        basis
        actOn
        storeOn
    end
    
    methods
        function obj = Measurement(varargin)
            %Measurement Construct an instance of this class
            %   Detailed explanation goes here
            % obj = Measurement(registerLength, basis, actOn, storeOn)
            % obj = Measurement(basis)
            import ExeQu.CircuitComposer.*;
            import ExeQu.Utils.Maths.*;
            import ExeQu.Utils.*;

            switch nargin
                case 1
                    obj.basis = varargin{1};
                    registerLength = 1;
                    obj.actOn = 1;
                    obj.storeOn = 1;
                case 4
                    registerLength = varargin{1};
                    obj.basis = varargin{2};
                    obj.actOn = varargin{3};
                    obj.storeOn = varargin{4};
            end

            obj.operatorMap = createStateMap(registerLength);
            for key = obj.operatorMap.keys
                keyStr = key{:};
                notation = keyStr;
                switch obj.basis
                    case 'z'
                        notation = notation;
                    case 'x'
                        notation = strrep(notation,'0','+');
                        notation = strrep(notation,'1','-');
                    case 'y'
                        notation = strrep(notation,'0','R');
                        notation = strrep(notation,'1','L');
                    otherwise
                        throw(MException('Measurement:ParameterError', "Invalid basis"))
                end
                value = QuantumRegister(registerLength, notation).getDensity();
                obj.operatorMap(keyStr) = value;
            end
            
%             switch obj.basis
%                 case 'z'
%                     obj.measurementOperators = [];
%                     operator.name = '0';
%                     operator.value = Qubit('0').getDensity();
%                     obj.measurementOperators = [obj.measurementOperators operator];
%                     operator.name = '1';
%                     operator.value = Qubit('1').getDensity();
%                     obj.measurementOperators = [obj.measurementOperators operator];
%                 case 'x'
%                     obj.measurementOperators = [];
%                     operator.name = '0'; % In X-axis state 0 is |+>
%                     operator.value = Qubit('+').getDensity();
%                     obj.measurementOperators = [obj.measurementOperators operator];
%                     operator.name = '1';
%                     operator.value = Qubit('-').getDensity();
%                     obj.measurementOperators = [obj.measurementOperators operator];
%                 case 'y'
%                     obj.measurementOperators = [];
%                     operator.name = '0'; % In Y-axis state 0 is |R>
%                     operator.value = Qubit('R').getDensity();
%                     obj.measurementOperators = [obj.measurementOperators operator];
%                     operator.name = '1'; 
%                     operator.value = Qubit('L').getDensity();
%                     obj.measurementOperators = [obj.measurementOperators operator];
%                 otherwise
%                     throw(MException('Measurement:ParameterError', "Invalid basis"))
%             end
            
%             for i = 1:length(obj.measurementOperators)
%                 t = cell(1, registerLength);
%                 for j = 1:registerLength
%                     if j == obj.actOn
%                         t(j) = {obj.measurementOperators(i).value};
%                     else
%                         t(j) = {eye(2)};
%                     end
%                 end
%                 obj.measurementOperators(i).value = tensor(t);
%             end
        end  
        
        operators = getOperators(self);
        origin = getOrigin(self);
        dest = getDestination(self);
        basis = getBasis(self);
        
    end
end

