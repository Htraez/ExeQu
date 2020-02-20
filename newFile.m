import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;
%include"qelib1.inc"
%qreg
%qreg
%creg
%creg
circuit.cnot(0,1);
%cnot
circuit.measure(0,0);
%measure
%comment
