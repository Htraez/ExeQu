function plotCircuit(qreg,maxLength)
    import ExeQu.CircuitComposer.*;
    import ExeQu.Utils.*;
    numberOfQubit = qreg.n_qubits;
    %n_element=zeros(1,numberOfQubit);
    
    xline=[2 2.25*maxLength];
    % set(gca,'visible','off')              %hide axis
    for i= 1:numberOfQubit                                                  % loop figure
        line(xline,[-2*i -2*i]);
        line(xline,[-(2+2*numberOfQubit) -(2+2*numberOfQubit)]);
        line(xline,[-(2+2*numberOfQubit)-0.2 -(2+2*numberOfQubit)-0.2]);

        quantumName="q["+i+"]  |0>";        % name quantum
        text(1,-2*i,quantumName);
        text(1,-2*numberOfQubit-2,'c');
    end
    
    daspect([1 1 1]);
end