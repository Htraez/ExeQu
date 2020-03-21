function operation = u1(self, target, lambda)
    import ExeQu.Gates.*;
    registerSize = self.quantumRegister.getSize();

    U1 = U3(registerSize, target, 0, 0, lambda);
    U1.label = 'U1';
    operation.unitaryOperation = U1;
    operation.label = U1.label;
    operation.theta = 0;
    operation.phi = 0;
    operation.lambda = lambda;
    operation.associatedQubit = [target];
    self.add(operation);
end