import ExeQu.CircuitComposer.*
import ExeQu.Gates.*
import ExeQu.Utils.*


circuit = Circuit(2, 2);

circuit.x(1)
circuit.cnot(1, 2)
circuit.cz(2, 1)

circuit.draw()

circuit.quantumRegister
circuit.peekOperationQueue
