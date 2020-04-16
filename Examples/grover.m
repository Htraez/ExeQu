function grover()
    import ExeQu.CircuitComposer.*;
    qc = Circuit(2, 2);
    
    % Find |10> in 2 Qubits system
    
    qc.h(1);
    qc.h(2);
    
    qc.unitary([
    [1, 0, 0, 0,],
    [0, 1, 0, 0,],
    [0, 0, -1, 0,],
    [0, 0, 0, 1,]], [1 2])

    qc.h(1);
    qc.h(2);
    
    qc.x(1);
    qc.x(2);
    
    qc.h(2);
    qc.cnot(1, 2);
    qc.h(2);
    
    qc.x(1);
    qc.x(2);
    qc.h(1);
    qc.h(2);
    
    qc.measure(1, 1)
    qc.measure(2, 2)
    
    qc.draw();
    tic
    result = qc.execute(1024);
    execution_time = toc
    tic
    result.getCount();
    sampling_time = toc
    result.plotHistogram();
end