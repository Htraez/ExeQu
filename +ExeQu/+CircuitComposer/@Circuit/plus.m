function plus(self, b)
    import ExeQu.CircuitComposer.*;
    import ExeQu.Utils.o2c;
    if isequal(class(self), class(b)) && ...
            isequal(class(b), 'ExeQu.CircuitComposer.Circuit')
        
        % Handle different size
        sizeOrigin = self.quantumRegister.getSize();
        c_sizeOrigin = self.classicalBits;
        sizeTarget = b.quantumRegister.getSize();
        c_sizeTarget = b.classicalBits;
        
        % Origin < Target
        if sizeOrigin < sizeTarget
            oldOperations = self.peekOperations();
            self.quantumRegister = QuantumRegister(sizeTarget);
            self.classicalBits = max(c_sizeOrigin, c_sizeTarget);
            self.operationQueue = {};
            self.n_element = zeros(1, self.quantumRegister.getSize());
            o2c(self, oldOperations);
        end
        
        o2c(self, b.peekOperations());
    else
        throw(MException('Circuit:ParameterError', "Can't concat Circuit with other class than Circuit"))
    end
end