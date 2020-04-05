function quantum_walk()
    import ExeQu.CircuitComposer.*;
    qubits = 8;
    cbits = 5;
    qc = Circuit(qubits, cbits);
    
    %% Position Encoding
    %   We have 5 qubits (1st - 5th) for position encoding
    %   0 0000 = Left End (-15 to -1)
    %   0 1111 = Origin (0)
    %   1 1111 = Right End (1 to 16)
    
    %% Initialize First Position
    qc.x(2)
    qc.x(3)
    qc.x(4)
    qc.x(5)
    
    %% Initialize Coin Flip
    %   We have 1 qubit (6th) to be flipping coin
%     qc.x(6) % Start with |1>
    qc.identity(6); % Start with |0>
    
    %% Start Coin Filpping
    coin = Circuit(qubits, cbits);
    coin.h(6)

    %% Pre-defined Measurement Part
    measure = Circuit(qubits, cbits);
    for i = 1:cbits
        measure.measure(i, i);
    end
    
    %% Pre-defined Shifting Circuit
    shifting = Circuit(qubits, cbits);
    shifting.cnot(6, 1);
    shifting.cnot(6, 2);
    shifting.cnot(6, 3);
    shifting.cnot(6, 4);
    shifting.cnot(6, 5);
    
    shifting.ccnot(4, 5, 7);
    shifting.ccnot(2, 3, 8);
    shifting.ccnot(7, 8, 1);
    shifting.ccnot(2, 3, 8);
    shifting.ccnot(4, 5, 7);
    
    shifting.ccnot(4, 5, 7);
    shifting.ccnot(3, 7, 2);
    shifting.ccnot(4, 5, 7);
    
    shifting.ccnot(4, 5, 3);
    shifting.cnot(5, 4);
    shifting.x(5);
    
    shifting.cnot(6, 1);
    shifting.cnot(6, 2);
    shifting.cnot(6, 3);
    shifting.cnot(6, 4);
    shifting.cnot(6, 5);
    
    %% Contruct Full Circuit
    for i = 1:13
        qc + coin;
        qc + shifting;
    end
    qc + measure;
    
    %% See the Circuit
    qc.draw();
    
    %% Execute
    tic
    result = qc.execute(1024);
    execution_time = toc
    tic
    result.getCount();
    sampling_time = toc
    result.plotHistogram();
end