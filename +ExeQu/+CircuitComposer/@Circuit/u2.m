function operation = u2(self, target, phi, lambda)
    import ExeQu.Gates.*;
    registerSize = self.quantumRegister.getSize();

    U2 = U3(registerSize, target, pi/2, phi, lambda);
    U2.label = 'U2';
    operation.unitaryOperation = U2;
    operation.label = U2.label;
    operation.theta = pi/2;
    operation.phi = phi;
    operation.lambda = lambda;
    operation.associatedQubit = [target];
    self.add(operation);
end