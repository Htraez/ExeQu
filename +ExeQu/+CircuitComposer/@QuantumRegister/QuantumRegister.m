classdef QuantumRegister
    properties (Access = private)
        state
    end
    properties (Access = public)
        qubits
        notation %initial state notation
    end
    methods (Access = public)
        function obj = QuantumRegister(qreg_n, initState)
            import ExeQu.CircuitComposer.*
            persistent state
           
            obj.qubits = [];
            obj.notation = "|";
            for index = 1:qreg_n
                if nargin < 2
                    state = '0';
                else 
                    state = initState(index);
                end
                obj.qubits = [obj.qubits, Qubit(state, index)];
                obj.notation = obj.notation + state;
            end
            
            obj.notation = obj.notation + ">";
        end
        size = getSize(self);
        state = getState(self, qubit_index);
        setLabel(self, label);
        onUpdate(self);
    end
end