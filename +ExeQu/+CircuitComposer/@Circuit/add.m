function add(self, operation)
    if ~(isfield(operation, "unitaryOperation")||isfield(operation, "measurementOperation")||isequal(operation.label, 'barrier')) ...
            || ~isfield(operation, "associatedQubit") ...
            || ~isfield(operation, "label")
        throw(MException('Add:ParameterError', "1st argument is not a valid operation"));
    end    

    if lower(operation.label)=="measurement"
        temp = max(self.n_element(min(operation.associatedQubit):length(self.n_element))+1);
        self.n_element(min(operation.associatedQubit):length(self.n_element))=temp;
    elseif lower(operation.label)=="u" && ...
            max(operation.associatedQubit)-min(operation.associatedQubit)>0
        temp = max(self.n_element(min(operation.associatedQubit):max(operation.associatedQubit))+2);
        self.n_element(min(operation.associatedQubit):max(operation.associatedQubit))=temp;
    else
        temp = max(self.n_element(min(operation.associatedQubit):max(operation.associatedQubit))+1);
        self.n_element(min(operation.associatedQubit):max(operation.associatedQubit))=temp;
    end
    
    self.maxLength = max(self.n_element);
    self.operationQueue = [self.operationQueue operation];
end