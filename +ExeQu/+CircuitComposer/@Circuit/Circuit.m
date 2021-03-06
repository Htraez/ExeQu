classdef Circuit < handle
    properties (Access = public)
        quantumRegister
        operationQueue
        classicalBits
    end
    properties (Access = private)
        n_element
        maxLength
    end
    methods
%       Circuit Constructor
        function obj = Circuit(qreg_length, creg_length)
            import ExeQu.CircuitComposer.*
            import ExeQu.Utils.clearFigure;
            clearFigure();
            obj.quantumRegister = QuantumRegister(qreg_length);
            obj.operationQueue = {};
            obj.classicalBits = qreg_length;
            obj.n_element = zeros(1, obj.quantumRegister.getSize());
            if nargin > 1
                obj.classicalBits = creg_length;
            end
        end
        
%       Gate Functions:
%           These functions call Gates.<gate name> to get an operator
%           and wrap them in 'operation' struct before adding
%           them to the circuit's 'operationQueue'
        add(self, operation);
        barrier(self, varargin);
        x(self, target);
        y(self, target);
        z(self, target);
        controlledU(self, U, ctrls, target)
        cnot(self, ctrl, target);
        ccnot(self, ctrl1, ctrl2, target);
        cr(self, ctrl, target, theta)
        cy(self, ctrl, target);
        cz(self, ctrl, target);
        mct(self, ctrls, target);
        h(self, target);
        s(self, target);
        t(self, target);
        sdag(self, target);
        tdag(self, target);
        rx(self, target, theta);
        ry(self, target, theta);
        rz(self, target, theta);
        identity(self, target);
        u1(self, target, lambda);
        u2(self, target, phi, lambda);
        u3(self, target, theta, phi, lambda);
        
%       Custom Gate Function:
%           This will create custom unitary gate operation 
%           from user-defined operator 
        operation = unitary(self, operator, ctrls, target);
        
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
        result = execute(self, n_shots, varargin);
        
%       Miscellaneous:
%           Other useful functions
        out = peekOperations(self);
        getMaxLength(self);
        
%       Operator Overloading
        plus(self, b);
    end
end