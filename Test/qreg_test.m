% Test quantum register Class
current_prj_path = fullfile(pwd, '..');
addpath(current_prj_path)
import ExeQu.CircuitComposer.*;
import ExeQu.Utils.Maths.*;

% preconditions
ketZero = [1; 0];
ketOne = [0; 1];
ketPlus = sqrt(1/2)*(ketZero + ketOne);
ketMinus = sqrt(1/2)*(ketZero - ketOne);
ketR = sqrt(1/2)*(ketZero + 1i*ketOne);
ketL = sqrt(1/2)*(ketZero - 1i*ketOne);

%% QREG: Init 1 qubit Qreg ket 0
qr = QuantumRegister(1, '0');
act = full(qr.getState());
exp = ketZero;
assert(compare(act, exp));

%% QREG: Init 1 qubit Qreg ket 1
qr = QuantumRegister(1, '1');
act = full(qr.getState());
exp = ketOne;
assert(compare(act, exp));

%% QREG: Init 1 qubit Qreg ket plus
qr = QuantumRegister(1, '+');
act = full(qr.getState());
exp = ketPlus;
assert(compare(act, exp));

%% QREG: Init 1 qubit Qreg ket minus
qr = QuantumRegister(1, '-');
act = full(qr.getState());
exp = ketMinus;
assert(compare(act, exp));

%% QREG: Init 1 qubit Qreg ket R
qr = QuantumRegister(1, 'R');
act = full(qr.getState());
exp = ketR;
assert(compare(act, exp));

%% QREG: Init 1 qubit Qreg ket L
qr = QuantumRegister(1, 'L');
act = full(qr.getState());
exp = ketL;
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket 00
qr = QuantumRegister(2, '00');
act = full(qr.getState());
exp = tensor(ketZero, ketZero);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket 01
qr = QuantumRegister(2, '01');
act = full(qr.getState());
exp = tensor(ketZero, ketOne);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket 10
qr = QuantumRegister(2, '10');
act = full(qr.getState());
exp = tensor(ketOne, ketZero);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket 11
qr = QuantumRegister(2, '11');
act = full(qr.getState());
exp = tensor(ketOne, ketOne);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket pp
qr = QuantumRegister(2, '++');
act = full(qr.getState());
exp = tensor(ketPlus, ketPlus);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket pm
qr = QuantumRegister(2, '+-');
act = full(qr.getState());
exp = tensor(ketPlus, ketMinus);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket mp
qr = QuantumRegister(2, '-+');
act = full(qr.getState());
exp = tensor(ketMinus, ketPlus);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket mm
qr = QuantumRegister(2, '--');
act = full(qr.getState());
exp = tensor(ketMinus, ketMinus);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket RR
qr = QuantumRegister(2, 'RR');
act = full(qr.getState());
exp = tensor(ketR, ketR);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket RL
qr = QuantumRegister(2, 'RL');
act = full(qr.getState());
exp = tensor(ketR, ketL);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket LR
qr = QuantumRegister(2, 'LR');
act = full(qr.getState());
exp = tensor(ketL, ketR);
assert(compare(act, exp));

%% QREG: Init 2 qubit Qreg ket LL
qr = QuantumRegister(2, 'LL');
act = full(qr.getState());
exp = tensor(ketL, ketL);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 000
qr = QuantumRegister(3, '000');
act = full(qr.getState());
exp = tensor(ketZero, ketZero, ketZero);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 001
qr = QuantumRegister(3, '001');
act = full(qr.getState());
exp = tensor(ketZero, ketZero, ketOne);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 010
qr = QuantumRegister(3, '010');
act = full(qr.getState());
exp = tensor(ketZero, ketOne, ketZero);
assert(compare(act, exp));


%% QREG: Init 3 qubit Qreg ket 011
qr = QuantumRegister(3, '011');
act = full(qr.getState());
exp = tensor(ketZero, ketOne, ketOne);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 100
qr = QuantumRegister(3, '100');
act = full(qr.getState());
exp = tensor(ketOne, ketZero, ketZero);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 101
qr = QuantumRegister(3, '101');
act = full(qr.getState());
exp = tensor(ketOne, ketZero, ketOne);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 110
qr = QuantumRegister(3, '110');
act = full(qr.getState());
exp = tensor(ketOne, ketOne, ketZero);
assert(compare(act, exp));

%% QREG: Init 3 qubit Qreg ket 111
qr = QuantumRegister(3, '111');
act = full(qr.getState());
exp = tensor(ketOne, ketOne, ketOne);
assert(compare(act, exp));

function bool = compare(act, exp)
    if ~isreal(act) || ~isreal(exp)
        realAct = real(act);
        realExp = real(exp);
        imagAct = imag(act);
        imagExp = imag(exp);
        boolReal = ismembertol(realAct, realExp, 'ByRows', true);
        boolImag = ismembertol(imagAct, imagExp, 'ByRows', true);
        bool = [boolReal boolImag];
    else
        bool = ismembertol(act, exp, 'ByRows', true);
    end
    
    [actR, actC] = size(act);
    [expR, expC] = size(exp);
    
    if actR ~= expR || actC ~= expC
        bool = false;
    else
        bool = all(bool(:));
    end
end