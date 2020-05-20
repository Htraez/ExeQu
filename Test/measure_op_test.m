% Test measurement Class (test measurement operator initialization)
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

%% Measure Ops: Independent Basis Z (Zero, One)
m = Measurement('z');
ops =  m.getOperators();
bool0 = compare(full(ops('0')), ketZero * ketZero');
bool1 = compare(full(ops('1')), ketOne * ketOne');
act = [bool0, bool1];
assert(all(act(:)));

%% Measure Ops: Independent Basis X (Plus, Minus)
m = Measurement('x');
ops =  m.getOperators();
bool0 = compare(full(ops('0')), ketPlus * ketPlus');
bool1 = compare(full(ops('1')), ketMinus * ketMinus');
act = [bool0, bool1];
assert(all(act(:)));

%% Measure Ops: Independent Basis Y (R, L)
m = Measurement('y');
ops =  m.getOperators();
bool0 = compare(full(ops('0')), ketR * ketR');
bool1 = compare(full(ops('1')), ketL * ketL');
act = [bool0, bool1];
assert(all(act(:)));

%% Measure Ops: 2 Qubit Basis Z
m = Measurement(2, 'z', 1, 1);
ops =  m.getOperators();
bool0 = compare(full(ops('00')), tensor(ketZero, ketZero) * tensor(ketZero, ketZero)');
bool1 = compare(full(ops('01')), tensor(ketZero, ketOne) * tensor(ketZero, ketOne)');
bool2 = compare(full(ops('10')), tensor(ketOne, ketZero) * tensor(ketOne, ketZero)');
bool3 = compare(full(ops('11')), tensor(ketOne, ketOne) * tensor(ketOne, ketOne)');
act = [bool0, bool1, bool2, bool3];
assert(all(act(:)));

%% Measure Ops: 3 Qubit Basis Z
m = Measurement(3, 'z', 1, 1);
ops =  m.getOperators();
bool0 = compare(full(ops('000')), tensor(ketZero, ketZero, ketZero) * tensor(ketZero, ketZero, ketZero)');
bool1 = compare(full(ops('001')), tensor(ketZero, ketZero, ketOne) * tensor(ketZero, ketZero, ketOne)');
bool2 = compare(full(ops('010')), tensor(ketZero, ketOne, ketZero) * tensor(ketZero, ketOne, ketZero)');
bool3 = compare(full(ops('011')), tensor(ketZero, ketOne, ketOne) * tensor(ketZero, ketOne, ketOne)');
bool4 = compare(full(ops('100')), tensor(ketOne, ketZero, ketZero) * tensor(ketOne, ketZero, ketZero)');
bool5 = compare(full(ops('101')), tensor(ketOne, ketZero, ketOne) * tensor(ketOne, ketZero, ketOne)');
bool6 = compare(full(ops('110')), tensor(ketOne, ketOne, ketZero) * tensor(ketOne, ketOne, ketZero)');
bool7 = compare(full(ops('111')), tensor(ketOne, ketOne, ketOne) * tensor(ketOne, ketOne, ketOne)');
act = [bool0, bool1, bool2, bool3, bool4, bool5, bool6, bool7];
assert(all(act(:)));

%% Measure Ops: 2 Qubit Basis X
m = Measurement(2, 'x', 1, 1);
ops =  m.getOperators();
bool0 = compare(full(ops('00')), tensor(ketPlus, ketPlus) * tensor(ketPlus, ketPlus)');
bool1 = compare(full(ops('01')), tensor(ketPlus, ketMinus) * tensor(ketPlus, ketMinus)');
bool2 = compare(full(ops('10')), tensor(ketMinus, ketPlus) * tensor(ketMinus, ketPlus)');
bool3 = compare(full(ops('11')), tensor(ketMinus, ketMinus) * tensor(ketMinus, ketMinus)');
act = [bool0, bool1, bool2, bool3];
assert(all(act(:)));

%% Measure Ops: 3 Qubit Basis X
m = Measurement(3, 'x', 1, 1);
ops =  m.getOperators();
bool0 = compare(full(ops('000')), tensor(ketPlus, ketPlus, ketPlus) * tensor(ketPlus, ketPlus, ketPlus)');
bool1 = compare(full(ops('001')), tensor(ketPlus, ketPlus, ketMinus) * tensor(ketPlus, ketPlus, ketMinus)');
bool2 = compare(full(ops('010')), tensor(ketPlus, ketMinus, ketPlus) * tensor(ketPlus, ketMinus, ketPlus)');
bool3 = compare(full(ops('011')), tensor(ketPlus, ketMinus, ketMinus) * tensor(ketPlus, ketMinus, ketMinus)');
bool4 = compare(full(ops('100')), tensor(ketMinus, ketPlus, ketPlus) * tensor(ketMinus, ketPlus, ketPlus)');
bool5 = compare(full(ops('101')), tensor(ketMinus, ketPlus, ketMinus) * tensor(ketMinus, ketPlus, ketMinus)');
bool6 = compare(full(ops('110')), tensor(ketMinus, ketMinus, ketPlus) * tensor(ketMinus, ketMinus, ketPlus)');
bool7 = compare(full(ops('111')), tensor(ketMinus, ketMinus, ketMinus) * tensor(ketMinus, ketMinus, ketMinus)');
act = [bool0, bool1, bool2, bool3, bool4, bool5, bool6, bool7];
assert(all(act(:)));

%% Measure Ops: 2 Qubit Basis Y
m = Measurement(2, 'y', 1, 1);
ops =  m.getOperators();
bool0 = compare(full(ops('00')), tensor(ketR, ketR) * tensor(ketR, ketR)');
bool1 = compare(full(ops('01')), tensor(ketR, ketL) * tensor(ketR, ketL)');
bool2 = compare(full(ops('10')), tensor(ketL, ketR) * tensor(ketL, ketR)');
bool3 = compare(full(ops('11')), tensor(ketL, ketL) * tensor(ketL, ketL)');
act = [bool0, bool1, bool2, bool3];
assert(all(act(:)));

%% Measure Ops: 3 Qubit Basis Y
m = Measurement(3, 'y', 1, 1);
ops =  m.getOperators();
bool0 = compare(full(ops('000')), tensor(ketR, ketR, ketR) * tensor(ketR, ketR, ketR)');
bool1 = compare(full(ops('001')), tensor(ketR, ketR, ketL) * tensor(ketR, ketR, ketL)');
bool2 = compare(full(ops('010')), tensor(ketR, ketL, ketR) * tensor(ketR, ketL, ketR)');
bool3 = compare(full(ops('011')), tensor(ketR, ketL, ketL) * tensor(ketR, ketL, ketL)');
bool4 = compare(full(ops('100')), tensor(ketL, ketR, ketR) * tensor(ketL, ketR, ketR)');
bool5 = compare(full(ops('101')), tensor(ketL, ketR, ketL) * tensor(ketL, ketR, ketL)');
bool6 = compare(full(ops('110')), tensor(ketL, ketL, ketR) * tensor(ketL, ketL, ketR)');
bool7 = compare(full(ops('111')), tensor(ketL, ketL, ketL) * tensor(ketL, ketL, ketL)');
act = [bool0, bool1, bool2, bool3, bool4, bool5, bool6, bool7];
assert(all(act(:)));

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