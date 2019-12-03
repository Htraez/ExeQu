classdef Visualization < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = Visualization(inputArg1,inputArg2)
            import ExeQu.CircuitComposer.*
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
%       Plot Functions:
        plotCircuit(self, qreg);
        plotOperation(self, op);
    end
end

