gate yy(theta,phi) a,b {U(theta,phi,0) a; CX b,a;}
gate ryy(theta,phi,zeta,test) a,b { U(theta,phi,0) a; x b,a; yy(zeta,test) a,b;}