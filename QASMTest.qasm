OPENQASM 2.0;
include "gate.inc";
qreg q[5];
creg c[5];
x q[0];
cx q[2],q[3];
u3(pi,pi/2,pi/2) q[4];
//comment
measure q->c;