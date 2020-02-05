function plotCircuit(qreg)
    import ExeQu.Utils.*;
    clf;                                                                    % clear figure
    %notation_width=2;
    numberOfQubit = qreg.n_qubits;
    %n_element=zeros(1,numberOfQubit);
    xline=[2 20];
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