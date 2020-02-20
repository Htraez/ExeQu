function rz(self, target, theta)
    import ExeQu.Gates.*;
    Rz = RZ(self.quantumRegister.getSize(), target, theta);
    operation.unitaryOperation = Rz;
    operation.label = Rz.label;
    operation.associatedQubit = [target];
    self.add(operation);
end