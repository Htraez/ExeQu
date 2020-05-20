% Test qubit Class
current_prj_path = fullfile(pwd, '..');
addpath(current_prj_path)
import ExeQu.CircuitComposer.*;

% preconditions
ketZero = [1; 0];
ketOne = [0; 1];
ketPlus = sqrt(1/2)*(ketZero + ketOne);
ketMinus = sqrt(1/2)*(ketZero - ketOne);
ketR = sqrt(1/2)*(ketZero + 1i*ketOne);
ketL = sqrt(1/2)*(ketZero - 1i*ketOne);

%% Qubit: Init Ket 0 Qubit
q = Qubit('0');
act = full(q.getState());
exp = ketZero;
assert(compare(act, exp));

%% Qubit: Try Getting Bra 0 
q = Qubit('0');
act = full(q.getBra());
exp = ketZero';
assert(compare(act, exp));

%% Qubit: Try Getting Density 0 
q = Qubit('0');
act = full(q.getDensity());
exp = ketZero * ketZero';
assert(compare(act, exp));

%% Qubit: Init Ket 1 Qubit
q = Qubit('1');
act = full(q.getState());
exp = ketOne;
assert(compare(act, exp));

%% Qubit: Try Getting Bra 1
q = Qubit('1');
act = full(q.getBra());
exp = ketOne';
assert(compare(act, exp));

%% Qubit: Try Getting Density 1 
q = Qubit('1');
act = full(q.getDensity());
exp = ketOne * ketOne';
assert(compare(act, exp));

%% Qubit: Init Ket Plus Qubit
q = Qubit('+');
act = full(q.getState());
exp = ketPlus;
assert(compare(act, exp));

%% Qubit: Try Getting Bra Plus
q = Qubit('+');
act = full(q.getBra());
exp = ketPlus';
assert(compare(act, exp));

%% Qubit: Try Getting Density Plus
q = Qubit('+');
act = full(q.getDensity());
exp = ketPlus * ketPlus';
assert(compare(act, exp));

%% Qubit: Init Ket Minus Qubit
q = Qubit('-');
act = full(q.getState());
exp = ketMinus;
assert(compare(act, exp));

%% Qubit: Try Getting Bra Minus
q = Qubit('-');
act = full(q.getBra());
exp = ketMinus';
assert(compare(act, exp));

%% Qubit: Try Getting Density Minus
q = Qubit('-');
act = full(q.getDensity());
exp = ketMinus * ketMinus';
assert(compare(act, exp));

%% Qubit: Init Ket R Qubit
q = Qubit('R');
act = full(q.getState());
exp = ketR;
assert(compare(act, exp));

%% Qubit: Try Getting Bra R
q = Qubit('R');
act = full(q.getBra());
exp = ketR';
assert(compare(act, exp));

%% Qubit: Try Getting Density R
q = Qubit('R');
act = full(q.getDensity());
exp = ketR * ketR';
assert(compare(act, exp));

%% Qubit: Init Ket L Qubit
q = Qubit('L');
act = full(q.getState());
exp = ketL;
assert(compare(act, exp));

%% Qubit: Try Getting Bra L
q = Qubit('L');
act = full(q.getBra());
exp = ketL';
assert(compare(act, exp));

%% Qubit: Try Getting Density L
q = Qubit('L');
act = full(q.getDensity());
exp = ketL * ketL';
assert(compare(act, exp));

% We use ismembertol() when comparing information because it's floating point.
% The simple 'isequal()' will not work correctly due to tolerance issue
% Instead, we compare each row of values and assert if all row are equal within tolerance. 
% By default, ismembertol uses a tolerance test of the form abs(u-v) <= tol*DS, 
% where DS automatically scales based on the magnitude of the input data

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