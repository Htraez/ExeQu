function operation = u3(self, target, theta, phi, lambda)
    import ExeQu.Gates.*;
    registerSize = self.quantumRegister.getSize();

    U3obj = U3(registerSize, target, theta, phi, lambda);
    operation.unitaryOperation = U3obj;
    operation.label = U3obj.label;
    operation.theta = theta;
    operation.phi = phi;
    operation.lambda = lambda;
    operation.associatedQubit = [target];
    self.add(operation);
end