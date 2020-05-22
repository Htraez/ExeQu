import ExeQu.CircuitComposer.*;

import ExeQu.CircuitComposer.*;
qc = Circuit(2, 2);

% Find |10> in 2 Qubits system

qc.h(1);
qc.h(2);

qc.unitary([
[1, 0, 0, 0],
[0, 1, 0, 0],
[0, 0, -1, 0],
[0, 0, 0, 1]], [1 2])

qc.measure(1, 1)
qc.measure(2, 2)

result = qc.execute(1024);

result.plotHistogram();

