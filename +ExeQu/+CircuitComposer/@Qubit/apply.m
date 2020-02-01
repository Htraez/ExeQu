function result = apply(self, operator)
    if strfind(class(operator), "Measurement") >= 0
        result = self.getBra() * operator.toMatrice() * self.getKet();
    elseif strfind(class(operator), "Gates") >= 0
        result = operator.toMatrice() * self.getKet();
    end
end