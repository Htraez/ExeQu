OPENQASM 2.0;
include "importCode.inc";
//gate abc a,b,c { CX a,b; U(pi/2,pi/2,pi/2) c;}
//gate xx a,b { U(pi/2,0,0) a ; x b,a ; yy(pi/6,pi/4) b,a;}
qreg q[5];
qreg q1[5];
creg c[5];
creg c1[5];
ryy(pi/6,pi/4,pi/3,pi/5) q[1],q[0];
//creg c2[5];
//x q[0],q[1];
//xx q[0],q[1];
//abc q[1],q[2],q[3];
//CX q[2],q1[0];
//CX q,q1;
//U(pi/2,pi/2,pi/2) q[4];
//measure q[2]->c1[4];
//measure q->c1;
//comment line