classdef Circuit < handle
    properties (Access = public)
        quantumRegister
        operationQueue
        classicalBits
    end
    methods
%       Circuit Constructor
        function obj = Circuit(qreg_length, creg_length)
            import ExeQu.CircuitComposer.*
            obj.quantumRegister = QuantumRegister(qreg_length);
            obj.operationQueue = {};
            obj.classicalBits = qreg_length;
            if nargin > 1
                obj.classicalBits = creg_length;
            end
        end
        
%       Gate Functions:
%           These functions call Gates.<gate name> to get an operator
%           and wrap them in 'operation' struct before adding
%           them to the circuit's 'operationQueue'
        x(self, target);
        y(self, target);
        z(self, target);
        cnot(self, ctrl, target);
        ccnot(self, ctrl1, ctrl2, target);
        cy(self, ctrl, target);
        cz(self, ctrl, target);
        mct(self, ctrls, target);
        h(self, target);
        s(self, target);
        t(self, target);
        rx(self, target, theta);
        ry(self, target, theta);
        rz(self, target, theta);
        identity(self, target);
        
%       Custom Gate Function:
%           This will create custom unitary gate operation 
%           from user-defined operator 
        unitary(self, operator, ctrls, target);
        
%       Measure Function:
%           This will create proper measurement operator for the circuit
%           given desired basis then wrap them in 'operation' struct
%           before adding them to the circuit's 'operationQueue'
        measure(self, Qtarget, Ctarget, basis);
        
%       Circuit Visualization:
%           Plot graphical summary of the circuit composition
        draw(self);
        
%       Execution:
%           Begin the calculation of circuit and return the result of
%           measurement in form of 'Result' struct
        result = execute(self, n_shots);
        
%       Miscellaneous:
%           Begin the calculation of circuit and return the result of
%           measurement in form of 'Result' struct
        peekOperations(self);
        
    end
    
end