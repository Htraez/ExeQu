function result = apply(self, operator)
    if strfind(class(operator), "ExeQu.CircuitComposer.Measurement") == 1
        result = [];
        for op = operator.getOperators()
            temp.state = op.name;
            temp.probability = self.getBra() * op.value * self.getKet();
            result = [result temp];
        end
    elseif strfind(class(operator), 'ExeQu.Gates') == 1
        result = operator.toMatrice() * self.getKet();
    end
end