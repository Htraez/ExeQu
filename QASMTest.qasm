OPENQASM 2.0;
include "qelib1.inc";
//gate abc a,b,c { CX a,b; U(pi/2,pi/2,pi/2) c;}
gate x c,d { CX d,c; U(pi/2,pi/2,pi/2) d;}
gate yy(theta,phi) a,b {U(theta,phi,0) a; CX b,a;}
//gate ryy(theta,phi) a,b { U(theta,phi,0) a; x b,a; }
gate xx a,b { U(pi/2,0,0) a ; x b,a ; yy(pi/6,pi/4) b,a;}
qreg q[5];
qreg q1[5];
qreg q2[5];
creg c[5];
creg c1[5];
//ryy(pi/2,pi/2) q[1],q[0];
//creg c2[5];
//x q[0],q[1];
xx q[0],q[1];
//abc q[1],q[2],q[3];
//CX q[2],q1[0];
//CX q,q1;
//U(pi/2,pi/2,pi/2) q[4];
measure q[2]->c1[4];
//measure q->c1;
//comment line