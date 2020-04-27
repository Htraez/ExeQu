import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
circuit = Circuit(15,10);
%include "qelib1.inc"

%gate x a { u3 ( pi,0,pi )  a; }
%creg c1[5];
circuit.cnot(2,3);
circuit.cnot(3,4);
circuit.cnot(4,2);
circuit.u3(4,pi/2,pi/2,pi/2);
circuit.cnot(1,6);
circuit.cnot(2,7);
circuit.cnot(3,8);
circuit.cnot(4,9);
circuit.cnot(5,10);
circuit.cnot(6,11);
circuit.cnot(7,12);
circuit.cnot(8,13);
circuit.cnot(9,14);
circuit.cnot(10,15);
circuit.cnot(11,1);
circuit.cnot(12,2);
circuit.cnot(13,3);
circuit.cnot(14,4);
circuit.cnot(15,5);
circuit.u3(11,pi/2,pi/2,pi/2);
circuit.u3(12,pi/2,pi/2,pi/2);
circuit.u3(13,pi/2,pi/2,pi/2);
circuit.u3(14,pi/2,pi/2,pi/2);
circuit.u3(15,pi/2,pi/2,pi/2);
%CX q[2],q1[0];
%CX q,q1;
%U ( pi/2,pi/2,pi/2 )  q[4];
circuit.measure(3,10);
circuit.measure(1,6);
circuit.measure(2,7);
circuit.measure(3,8);
circuit.measure(4,9);
circuit.measure(5,10);
%comment line
