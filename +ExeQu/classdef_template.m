classdef classdef_template
    properties (Access = public)
    end
    properties (Access = private)
    end
    methods
        function obj = classdef_template()
%             Implementation of constructure
        end
        
%        Implement these function in separate file 
%        in class folder named '@classdef_template'
        returnValue = functionName(self, arg1);
        functionWithoutReturn(self);
    end
    
    methods (Static)
%        Implement these function in separate file 
%        in class folder named '@classdef_template'
        returnValue = staticFunctionName(self, arg1);
        staticFunctionWithoutReturn(self);
    end
    
end