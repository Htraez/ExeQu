gate u3(theta,phi,lambda) q { U(theta,phi,lambda) q; }
gate cx c,t { CX c,t; }
gate x a { u3(pi,0,pi) a; }