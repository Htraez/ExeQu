function cr(self, ctrl, target, theta)
    % CR gate => Controlled phase shift, a generalizied form of CZ gate
    import ExeQu.Gates.*;
    
    PhaseShift = Unitary([1 0; 0 exp(1i*theta)]);
    CR = ControlledUnitary(PhaseShift, self.quantumRegister.getSize(), [ctrl], target);
    
    operation.unitaryOperation = CR;
    operation.label = 'CR';
    operation.associatedQubit = [ctrl target];
    self.add(operation);
end