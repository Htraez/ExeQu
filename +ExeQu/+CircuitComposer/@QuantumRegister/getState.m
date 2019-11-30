function state = getState(self, qubit_index)
    persistent numQubit
    
    numQubit = length(self.qubits);
    if nargin > 1
        state = self.qubits(qubit_index).getState();
        return
    end
    
    state = 1;
    for iter = 1:numQubit
        state = kron(state, self.qubits(iter).getState());
    end       
end