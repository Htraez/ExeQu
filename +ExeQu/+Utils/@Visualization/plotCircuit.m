function plotCircuit(self, qreg)
    import ExeQu.Utils.*;
    clf;
    %notation_width=2;
    numberOfQubit = length(qreg.qubits);
    %n_element=zeros(1,numberOfQubit);
    xline=[2 10];
    for i= 1:numberOfQubit                                      % loop figure
        line(xline,[-2*i -2*i]);
        line(xline,[-(2+2*numberOfQubit) -(2+2*numberOfQubit)]);
        line(xline,[-(2+2*numberOfQubit)-0.2 -(2+2*numberOfQubit)-0.2]);

        quantumName="q["+i+"]  |0>";        % name quantum
        text(1,-2*i,quantumName);
        text(1,-2*numberOfQubit-2,'c');
    end
end