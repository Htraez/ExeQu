import ExeQu.CircuitComposer.*;

qc = Circuit(3, 1);

qc.x(1);
qc.y(1);
qc.z(1);

qc.unitary(eye(4), [2 3]);

qc.draw();
