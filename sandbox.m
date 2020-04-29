import ExeQu.Gates.*;
import ExeQu.CircuitComposer.*;

qubits = 8;
cbits = 5;
qc = Circuit(qubits, cbits);

qc.x(1);
qc.x(2);
qc.x(3);
qc.x(5);

qc.x(8);

for i = 1:1
    qc.h(8);
    qc.cnot(8, 1);
    qc.cnot(8, 2);
    qc.cnot(8, 3);
%     qc.cnot(8, 5);
%     qc.cnot(8, 7);
    
%     qc.ccnot(1, 2, 4);
%     qc.ccnot(3, 5, 6);
%     qc.ccnot(4, 6, 7);
%     qc.ccnot(3, 5, 6);
%     qc.ccnot(1, 2, 4);
%     
%     qc.ccnot(1, 2, 4);
%     qc.ccnot(3, 4, 5);
%     qc.ccnot(1, 2, 4);
%     
%     qc.ccnot(1, 2, 3);
%     qc.cnot(1, 2);
%     qc.x(1);
%     
%     qc.cnot(8, 1);
%     qc.cnot(8, 2);
%     qc.cnot(8, 3);
%     qc.cnot(8, 5);
%     qc.cnot(8, 7);
end

qc.measure(1, 1);
qc.measure(2, 2);
qc.measure(3, 3);
qc.measure(5, 4);
qc.measure(7, 5);

qc.draw();

result = qc.execute(1000);
result.plotHistogram();

