function rx(self, target, theta)
    import ExeQu.Gates.*;
    Rx = RX(self.quantumRegister.getSize(), target, theta);
    operation.unitaryOperation = Rx;
    operation.label = Rx.label;
    operation.associatedQubit = [target];
    self.add(operation);
end