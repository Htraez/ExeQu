function measure(self, Qtarget, Ctarget, basis)
    import ExeQu.CircuitComposer.*;
    
    if nargin <= 3
        basis = 'z';
    end
    
    M = Measurement(self.quantumRegister.getSize(), basis, Qtarget, Ctarget);
    operation.measurementOperation = M;
    operation.label = 'Measurement';
    operation.associatedQubit = [Qtarget];
    self.add(operation);
end