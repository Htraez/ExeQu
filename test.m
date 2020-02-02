
import ExeQu.CircuitComposer.*
import ExeQu.Gates.*
import ExeQu.Utils.*


circuit = Circuit(3, 3)

circuit.h(1)
circuit.x(2)
circuit.cnot(1, 2)
U = circuit.unitary([0 1; 1 0]);
circuit.controlledU(U,[1, 2], 3);
circuit.controlledU(@PauliX,[1, 2], 3);
circuit.controlledU('x',[1, 2], 3);
circuit.measure(1, 1)
circuit.measure(2, 2)
circuit.measure(3, 3)
% circuit.cnot(2, 1)
circuit.cy(1, 2)
circuit.ccnot(1, 2, 3)
circuit.unitary([0 1; 1 0], 2)

circuit.draw();
circuit.peekOperations()
result = circuit.execute(2000);
result
result.getCount();
result.plotHistogram();
