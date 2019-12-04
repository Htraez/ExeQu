import ExeQu.CircuitComposer.*
import ExeQu.Gates.*
import ExeQu.Utils.*


circuit = Circuit(2, 2);
circuit.x(1)
circuit.h(2)

circuit.quantumRegister
circuit.peekOperationQueue