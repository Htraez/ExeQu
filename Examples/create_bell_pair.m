function create_bell_pair()
    import ExeQu.CircuitComposer.*;
    circuit = Circuit(2, 2);
    circuit.h(1);
    circuit.cnot(1, 2);
    circuit.draw()
end