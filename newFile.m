import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(15,10);
%include "qelib1.inc"



%creg c2[5];
circuit.cnot(1,2);
circuit.u3(1,pi/2,0,0);
circuit.cnot(2,1);
circuit.cnot(2,3);
circuit.u3(4,pi/2,pi/2,pi/2);
circuit.cnot(1,6);
circuit.cnot(2,7);
circuit.cnot(3,8);
circuit.cnot(4,9);
circuit.cnot(5,10);
circuit.u3(11,pi/2,pi/2,pi/2);
circuit.u3(12,pi/2,pi/2,pi/2);
circuit.u3(13,pi/2,pi/2,pi/2);
circuit.u3(14,pi/2,pi/2,pi/2);
circuit.u3(15,pi/2,pi/2,pi/2);
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
