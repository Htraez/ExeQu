function operation = unitary(self, operator, target)
    import ExeQu.Gates.*;
    registerSize = self.quantumRegister.getSize();

    U = Unitary(operator, registerSize, target);
    operation.unitaryOperation = U;
    operation.label = U.label;
    operation.associatedQubit = [target];
    self.add(operation);
end