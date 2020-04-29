import ExeQu.CircuitComposer.*;

qc = Circuit(4, 3);
qc.h(3);
qc.cnot(3,1);
qc.cnot(3,2);

qc.measure(1, 1);
qc.measure(2, 2);

qc.draw();
result = qc.execute(1000);
result.getCount();
result.plotHistogram();