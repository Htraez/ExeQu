function deutsch_constant()
    import ExeQu.CircuitComposer.*;
     %% Test II: with Uf of constant function
    %   f(0,0) => 1
    %   f(0,1) => 1
    %   f(1,0) => 1
    %   f(1,1) => 1
    %   which indicate that it is a constant function
    
    %% Build Circuit
    qc = Circuit(3, 2);
    
    % Prepare Ancillia Bit
    qc.x(3);
    
    % Get every qubit to superposition
    qc.h(1);
    qc.h(2);
    qc.h(3);
    
    % Oracle Function
    qc.cnot(2,3);
    qc.cnot(1,3);
    qc.ccnot(1,2,3);
    qc.x(1);
    qc.x(2);
    qc.ccnot(1,2,3)
    
    % Stop superposition on qubit 1 and 2 to measure
    qc.h(1);
    qc.h(2);
    
    % Measure Result
    %   Expect qubit 1 and 2 to be |00> as this is a constant function
    qc.measure(1, 1);
    qc.measure(2, 2);
    
    %% Execute all operation to see result
    tic
    result = qc.execute(1024);
    execution_time = toc
    tic
    result.getCount();
    sampling_time = toc
    result.plotHistogram();
end