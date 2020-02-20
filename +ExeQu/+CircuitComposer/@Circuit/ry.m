function ry(self, target, theta)
    import ExeQu.Gates.*;
    Ry = RY(self.quantumRegister.getSize(), target, theta);
    operation.unitaryOperation = Ry;
    operation.label = Ry.label;
    operation.associatedQubit = [target];
    self.add(operation);
end