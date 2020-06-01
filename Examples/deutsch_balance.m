function [elapsed_time, visualize_time] = deutsch_balance(q, c)
    import ExeQu.CircuitComposer.*;
    
    %% Test I: with Uf of XOR function on 2 bit
    %   f(0,0) => 0
    %   f(0,1) => 1
    %   f(1,0) => 1
    %   f(1,1) => 0
    %   which indicate that it is a balanced function
    
    %% Build Circuit
    qc = Circuit(q, c);
    
    % Prepare Ancillia Bit
    qc.x(3);
    
    % Get every qubit to superposition
    qc.h(1);
    qc.h(2);
    qc.h(3);
    
    % Oracle Function
    qc.cnot(2,3);
    qc.cnot(1,3);
    
    % Stop superposition on qubit 1 and 2 to measure
    qc.h(1);
    qc.h(2);
    
    % Measure Result
    %   Expect qubit 1 and 2 to be |11> as this is a balanced function
    qc.measure(1, 1);
    qc.measure(2, 2);

    %% Execute all operation to see result
    tic
    result = qc.execute(1024);
    elapsed_time = toc;
    tic
    qc.draw();
    result.plotHistogram();
    visualize_time = toc;
end