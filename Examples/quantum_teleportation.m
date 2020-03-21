function quantum_teleportation()
    import ExeQu.CircuitComposer.*;
    qc = Circuit(3, 3);
    
    % Prepare sample data to be sent
    qc.x(1);
    qc.h(1); % We'll be sending |-> to Bob
    
    % Create bell pair between Alice and Bob
    qc.h(2);
    qc.cnot(2, 3);
    
    % Alice entangle sample data with her bell pair
    qc.cnot(1, 2);
    
    % Do z-measurement and Hadamard measurement
    qc.h(1)
    qc.measure(1, 1)
    qc.measure(2, 2) 
    % The result then send to Bob so he can prepare proper gates 
    % to decipher Alice sample data correctly
    % In this case, according to type of bell-state both side use
    %   the proper circuit for Bob is NOT and Z
    
    % Bob decipher the message
    qc.cnot(2, 3)
    qc.cz(1, 3)
    
    % Check data at Bob's side. If correct he should have |-> that will
    %   become |1> if transformed by hadamard gate
    qc.h(3);
    qc.measure(3, 3);
    
    qc.draw();
    tic
    result = qc.execute(1024);
    execution_time = toc
    tic
    result.getCount();
    sampling_time = toc
    result.plotHistogram();
end