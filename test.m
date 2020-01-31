
import ExeQu.CircuitComposer.*
import ExeQu.Gates.*
import ExeQu.Utils.*


circuit = Circuit(3, 2)

circuit.x(1)
circuit.cnot(1, 3)
circuit.cy(1, 2)
circuit.ccnot(1, 2, 3);
%circuit.unitary([0 1; 1 0], 2)


circuit.draw()

circuit.quantumRegister
circuit.peekOperations()
