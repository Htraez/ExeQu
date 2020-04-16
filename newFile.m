import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(10,10);
%include "qelib1.inc"
circuit.cnot(1,2);
circuit.cnot(1,6);
circuit.cnot(2,7);
circuit.cnot(3,8);
circuit.cnot(4,9);
circuit.cnot(5,10);
circuit.measure(1,1);
circuit.measure(1,1);
circuit.measure(2,2);
circuit.measure(3,3);
circuit.measure(4,4);
circuit.measure(5,5);
%comment line
