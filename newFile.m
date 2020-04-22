import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(10,10);
%include "qelib1.inc"
circuit.cnot(3,6);
circuit.cnot(1,6);
circuit.cnot(2,7);
circuit.cnot(3,8);
circuit.cnot(4,9);
circuit.cnot(5,10);
circuit.u3(5,pi/2,pi/2,pi/2);
circuit.measure(3,10);
circuit.measure(1,6);
circuit.measure(2,7);
circuit.measure(3,8);
circuit.measure(4,9);
circuit.measure(5,10);
%comment line
