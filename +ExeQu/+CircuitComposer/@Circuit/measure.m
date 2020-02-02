function measure(self, Qtarget, Ctarget, basis)
    import ExeQu.CircuitComposer.*;
    
    if nargin <= 3
        basis = '01';
    end
    
    M = Measurement(self.quantumRegister.getSize(), basis, Qtarget, Ctarget);
    operation.measurementOperation = M;
    operation.label = 'Measurement';
    operation.associatedQubit = [Qtarget];
    self.operationQueue = [self.operationQueue operation];
end