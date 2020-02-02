function operation = unitary(self, operator, varargin)
    import ExeQu.Gates.*;
    registerSize = self.quantumRegister.getSize();
    if nargin < 3 
        % In case user just want 2x2 unitary without caring about
        % register size
        target = 1;
        registerSize = 1;
    else 
        target = varargin{1};
    end

    U = Unitary(operator, registerSize, target);
    operation.unitaryOperation = U;
    operation.label = U.label;
    operation.associatedQubit = [target];
end