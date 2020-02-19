% Circuit
%% Create new circuit
import ExeQu.CircuitComposer.*;
circuit = Circuit(2, 2); % circuit with 2 qubit, 2 classical bit

%% Apply gate to circuit
circuit.x(1);

%% Execute circuit
result = circuit.execute(100);
    % - execute circuit with 100 shots parameter (Default: 1024)
    % - Get returned result from circuit for further use

%% Visualize result as count
result.getCount();

%% Visualize result as histogram of state
result.plotHistogram();

%% Visualize circuit composition
circuit.draw();


%%
% Qubits
%% Create new Qubit
q1 = Qubit('0'); % Create new qubit with initial state of |0>
q2 = Qubit('1'); % Create new qubit with initial state of |1>
q3 = Qubit('+'); % Create new qubit with initial state of |+>
q4 = Qubit('-'); % Create new qubit with initial state of |->
q5 = Qubit('l'); % Create new qubit with initial state of |L>
q6 = Qubit('r'); % Create new qubit with initial state of |R>

%% Apply gate on Qubit
import ExeQu.Gates.*;
x = PauliX();
result = q1.apply(x);

%% Measure qubit
import ExeQu.CircuitComposer.Measurement;
m = Measurement('z');
result = q1.apply(m);
