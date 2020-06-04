# ExeQu v1.0.0 Documentation
### Quantum Gates and Circuit Simulator in MATLAB

ExeQu is a `MATLAB` toolbox designed to provide quantum programming enthusiats a tool for creating quantum circuit as well as simulating it result.

## Installation
#### [OPTION 1.] Clone Source Code
ExeQu is currently under development. You can clone ExeQu using [remote url](https://github.com/Htraez/ExeQu.git)

```bash
git clone https://github.com/Htraez/ExeQu.git
```

#### [OPTION 2.] Installing Toolbox Using MLTBX Installer
The easiest way to install ExeQu to your MATLAB path. Download the lastest release of ExeQu [here](https://github.com/Htraez/ExeQu/releases)

```html
https://github.com/Htraez/ExeQu/releases
```

## Workflow

ExeQu is designed to be easy-to-use. The main workflow of ExeQu is consists of creation of Quantum Circuit, execution of the circuit, and circuit visualization.
<img src="./Assets/Images/workflow_1.png" style="height:200px; margin-left:50%; transform: translate(-50%)" />

## Usage

As shown in the figure above, the main workflow is consists of composing a circuit, execution and visualization of the created circuit. To make use of the toolbox, here is the example code showing a simple example circuit that follows such workflow.

```matlab
import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;

%Create new quantum circuit with 2 qubits, 2 classical bits
circuit = Circuit(2, 2); 

%Add some quantum gates
circuit.h(1); %Add hadamard gate to the first qubit
circuit.cnot(1, 2); %Add controlled-not gate to with 1st as control and 2nd as target
circuit.measure(1, 1);
circuit.measure(2, 2);

circuit.draw(); %Draw circuit structure
result = circuit.execute(1024); %Simulate circuit (1024 shots)
result.plotHistogram(); %Visualize result
```
As the code suggests, the very first step of using ExeQu is to import the toolbox into MATLAB coding environment. The process of simulating this circuit is started by creating empty circuit using `Circuit` constructor. To do so, pass 2 parameters. First, the number of qubit. Second, the number of classical bit which will hold the measurement result afterward.

After having an empty circuit, you could add gates and measurement into the circuit using functions defined in the `Circuit` object itself. Then, by calling `draw()` function, you will see the circuit diagram displaying all components in the circuit you have just composed. 

At this point, to start the execution process, simply call `execute()` passing a `shots` parameter to specify the number of shots that the result will be sampled after the calculation process finished. 

Finally, in visualization process, you could use `result` struct which returned from `execute()` to call `plotHistogram()` to show the result of the circuit in form of probability histogram of possible quantum state(s)



## Available Quantum Gates

A quantum gate could be added to a circuit using methods defined in the `Circuit`. Right now, there are several of them available as shown. For more detail on each parameters, please refer to classes and functions breakdown in `Components` section.

Suppose a circuit instantiated using this code.

```matlab
circuit = Circuit(`number_of_qubit`, `number_of_cbit`);
```

|       Gates       |                             Name                             |                            Syntax                            |
| :---------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|  ![alt text][x]   | [Pauli-x Gate](https://github.com/Htraez/ExeQu#xtarget-function) |                  circuit.x(`target_qubit`)                   |
|  ![alt text][y]   | [Pauli-y Gate](https://github.com/Htraez/ExeQu#ytarget-function) |                  circuit.y(`target_qubit`)                   |
|  ![alt text][z]   | [Pauli-z Gate](https://github.com/Htraez/ExeQu#ztarget-function) |                  circuit.z(`target_qubit`)                   |
|  ![alt text][u]   | [Unitary Gate](https://github.com/Htraez/ExeQu#operation--unitaryoperator-ctrls-target-function) |  circuit.unitary(`operator`, `ctrl_qubits`, `target_qubit`)  |
|  ![alt text][u3]  | [U3 Gate](https://github.com/Htraez/ExeQu#u3target-theta-phi-lambda-function) |     circuit.u3(`target_qubit`, `theta`, `phi`, `lambda`)     |
|  ![alt text][u2]  | [U2 Gate](https://github.com/Htraez/ExeQu#u2target-phi-lambda-function) |         circuit.u2(`target_qubit`, `phi`, `lambda`)          |
|  ![alt text][u1]  | [U1 Gate](https://github.com/Htraez/ExeQu#u1target-lambda-function) |             circuit.u1(`target_qubit`, `lambda`)             |
|  ![alt text][s]   |  [S Gate](https://github.com/Htraez/ExeQu#starget-function)  |                  circuit.s(`target_qubit`)                   |
| ![alt text][sdag] | [S Dagger Gate](https://github.com/Htraez/ExeQu#sdagtarget-function) |                 circuit.sdag(`target_qubit`)                 |
|  ![alt text][t]   |  [T Gate](https://github.com/Htraez/ExeQu#ttarget-function)  |                  circuit.t(`target_qubit`)                   |
| ![alt text][tdag] | [T Dagger Gate](https://github.com/Htraez/ExeQu#tdagtarget-function) |                 circuit.tdag(`target_qubit`)                 |
|  ![alt text][rx]  | [Rx Gate](https://github.com/Htraez/ExeQu#rxtarget-theta-function) |             circuit.rx(`target_qubit`, `theta`)              |
|  ![alt text][ry]  | [Ry Gate](https://github.com/Htraez/ExeQu#rytarget-theta-function) |             circuit.ry(`target_qubit`, `theta`)              |
|  ![alt text][rz]  | [Rz Gate](https://github.com/Htraez/ExeQu#rztarget-theta-function) |             circuit.rz(`target_qubit`, `theta`)              |
|  ![alt text][cz]  | [Cz Gate](https://github.com/Htraez/ExeQu#czctrl-target-function) |          circuit.cz(`ctrl_qubits`, `target_qubit`)           |
|  ![alt text][cy]  | [Cy Gate](https://github.com/Htraez/ExeQu#cyctrl-target-function) |          circuit.cy(`ctrl_qubits`, `target_qubit`)           |
|  ![alt text][cr]  | [Cr Gate](https://github.com/Htraez/ExeQu#crctrl-target-theta-function) |      circuit.cr(`ctrl_qubits`, `target_qubit`, `theta`)      |
|  ![alt text][i]   | [Identity Gate](https://github.com/Htraez/ExeQu#identitytarget-function) |               circuit.identity(`target_qubit`)               |
|  ![alt text][h]   | [Hadamard Gate](https://github.com/Htraez/ExeQu#htarget-function) |                  circuit.h(`target_qubit`)                   |
|  ![alt text][cx]  | [CNOT Gate](https://github.com/Htraez/ExeQu#cnotctrl-target-function) |         circuit.cnot(`control_qubit`,`target_qubit`)         |
| ![alt text][ccx]  | [Toffoli Gate](https://github.com/Htraez/ExeQu#ccnotself-ctrl1-ctrl2-target-function) | circuit.ccnot(`control_qubit1`,`control_qubit2`,`target_qubit`) |
| ![alt text][mct]  | [Mutiple Control Toffoli Gate](https://github.com/Htraez/ExeQu#mctctrls-target-function) |          circuit.mct(`ctrl_qubits`, `target_qubit`)          |
|  ![alt text][cu]  | [Controlled-U Gate](https://github.com/Htraez/ExeQu#controlleduu-ctrls-target-function) | circuit.controlledU(`U_operator`, `ctrl_qubits`, `target_qubit`) |

<div style="page-break-after: always;"></div>
## Measurement

A measurement unit can be added to a `Circuit` at a certain point using command

```matlab
circuit.measure(`target_qubit`, `destination_classical_bit`, `basis (optional)`)
```

User need to specify which qubit to be measured and also a classical bit that will hold the measurement result.
Also 3 different axis of measurement can be specified: `x`, `y`, `z`. If no basis specified the `z` axis will be use by default which mean the measurement operator would be |0><0| and |1><1|

## Components

To understand toolbox's capability in detail, it is sensible to firstly understand some key components of the toolbox. There are several functions available in packages and classes defined in `ExeQu` as shown below.

###### List of Packages:

* [CircuitComposer](https://github.com/Htraez/ExeQu#circuitcomposer)
* [Gates](https://github.com/Htraez/ExeQu#gates)
* [Utils](https://github.com/Htraez/ExeQu#utils)
* [Transpiler](https://github.com/Htraez/ExeQu#qasm-transpiler)

### CircuitComposer

CircuitComposer is the main `package` that user will be using everytime to instantiate a Quantum Circuit. It is also an important `package` that need to be imported into a MATLAB script in order to use `ExeQu`. The package itself consists of 4 main classes: `Circuit`, `Qubit`, `QuantumRegister`, and `Measurement`

###### +CircuitComposer: `Package`

* ###### @Circuit: `Class`
  
  * ###### Circuit(qreg_length, creg_length): `Constructor`
    
    * `Constructor` of class `Circuit`. Call this constructor to create an instance of circuit. 
    * Parameters:
      * Qreg_length: `int` Number of qubit(s) in the circuit
      * Creg_length: `int` Number of classical bit(s) in the circuit 
  * ###### add(operation): `Function`
    
    * Add a new unitary operation into `Circuit`.  ** Note: When adding new unitary operations (gate operations) into the circuit using pre-defined gate function (e.g. x(), y(), cnot() etc.) this functions will be called automatically.
    * Parameters:
      * Operation: `Operation struct` A struct describing unitary operation created by others function that initiate unitary operation such as `unitary()` 
  * ###### barrier(from, to): `Function`
    
    * Add barrier to `Circuit`
    * Parameters:
      *  `Optional` From: `int` Specify starting qubit of the barrier
      *  `Optional` To: `int` Specify ending qubit to be covered by the barrier
  * ###### x(target): `Function`
    
    * Add Pauli-X gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this Pauli-X gate is operating on. (Starting from 1)
  * ###### y(target): `Function`
    
    * Add Pauli-Y gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this Pauli-Y gate is operating on. (Starting from 1)
  * ###### z(target): `Function`
    
    * Add Pauli-Z gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this Pauli-Z gate is operating on. (Starting from 1)
  * ###### controlledU(U, ctrls, target): `Function`
    
    * Add new Controlled-U gate to the `Circuit`. A controlled-U gate operation is an operation of applying U operator to certain `target` qubit based on the state of `control` qubit. `U` operator must be 2x2 dimensions or 1 qubit and must be initialized by a constructor of `Unitary` class or one of its inheritances.
    * Parameters:
      * U: `Instance of Unitary class` The unitary operation `U` that is meant to be operate on the `target` qubit when the `control` qubit(s) is all in state |1>.
      * Ctrls: `int[]` An integer array specifying list of control qubit(s).
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ###### cnot(ctrl, target): `Function`
    
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-X` gate and having only one control qubit. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `Cnot` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ###### ccnot(self, ctrl1, ctrl2, target): `Function`
    
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-X` gate and having 2 control qubits. (This gate is also known as `Toffoli` Gate). Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl1, Ctrl2: `int` Index of first and second qubit that controlling this `CCnot` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ###### cr(ctrl, target, theta): `Function`
    
    * Also known as `Controlled phase shift`. A pre-defined `Controlled-U` gate where `U` is `Phase Shift` operation and having 1 control qubits. (This gate is a generalization of the `CZ` gate). Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `CR` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * ###### cy(ctrl, target): `Function`
    
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-Y` gate and having only one control qubit. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `Cy` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ###### cz(ctrl, target): `Function`
    
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-Z` gate and having only one control qubit. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `Cz` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ###### mct(ctrls, target): `Function`
    
    * Multiple Controlled Toffoli Gate. Another variant of `controlled-U` where `U` is defined as `Pauli-X` gate but have multiple (more than 2) `control` qubits. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrls: `int[]` An integer array specifying list of control qubit(s).
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ###### h(target): `Function`
    
    * Add `Hadamard` into the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `H`-gate is operating on. (Starting from 1)
  * ###### s(target): `Function`
    
    * Add `Phase gate` (or S gate) into the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `S`-gate is operating on. (Starting from 1)
  * ###### t(target): `Function`
    
    * Add `T gate` into the `Circuit`. The T gate is related to the `S`-gate by the relationship  S= T<sup>2</sup>.
    * Parameters:
      * Target: `int` An index of qubit this `T`-gate is operating on. (Starting from 1)
  * ###### sdag(target): `Function`
    
    * Add conjugate transpose of the `S`-gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `Sdag`-gate is operating on. (Starting from 1)
  * ###### tdag(target): `Function`
    
    * Add conjugate transpose of the `T`-gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `Tdag`-gate is operating on. (Starting from 1)
  * ###### rx(target, theta): `Function`
    
    * Add `Rx`-gate into the `Circuit`. `Rx`-gate is one of the `Rotation Operators` which represent an arbitrary rotation around X axis.
    * Parameters:
      * Target: `int` An index of qubit this `Rx`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * ###### ry(target, theta): `Function`
    
    * Add `Ry`-gate into the `Circuit`. `Ry`-gate is one of the `Rotation Operators` which represent an arbitrary rotation around Y axis.
    * Parameters:
      * Target: `int` An index of qubit this `Ry`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * ###### rz(target, theta): `Function`
    
    * Add `Rz`-gate into the `Circuit`. `Rz`-gate is one of the `Rotation Operators` which represent an arbitrary rotation around Z axis.
    * Parameters:
      * Target: `int` An index of qubit this `Rz`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * ###### identity(target): `Function`
    
    * Add `Identity` gate to the `Circuit`. An identity gate is represented by an identity matrice. Adding identity gate to `target` qubit mean doing nothing to that qubit.
    * Parameters:
      * Target: `int` An index of qubit this `I`-gate is operating on. (Starting from 1)
  * ###### u3(target, theta, phi, lambda): `Function`
    
    * Add `Generic single-qubit rotation` gate: `U3` into the `Circuit`. The `U3` gate is an unitary operation of rotation around X, Y and Z axis specified by parameter `theta`, `phi`, and `lambda` which are angle of rotation around each axis respectively in radians.
    * Parameters:
      * Target: `int` An index of qubit this `U3`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
      * Phi: `float` An angle of rotation `phi` ** in radians
      * Lambda: `float` An angle of rotation `lambda` ** in radians
  * ###### u2(target, phi, lambda): `Function`
    
    * Add `Generic single-qubit rotation` gate: `U2` into the `Circuit`. U2 gate is a `U3`-gate with theta = pi/2
    * Parameters:
      * Target: `int` An index of qubit this `U3`-gate is operating on. (Starting from 1)
      * Phi: `float` An angle of rotation `phi` ** in radians
      * Lambda: `float` An angle of rotation `lambda` ** in radians
  * ###### u1(target, lambda): `Function`
    
    * Add `Generic single-qubit rotation` gate: `U1` into the `Circuit`. U1 gate is a `U3`-gate with theta = phi = 0
    * Parameters:
      * Target: `int` An index of qubit this `U3`-gate is operating on. (Starting from 1)
      * Lambda: `float` An angle of rotation `lambda` ** in radians
  * ###### operation = unitary(operator, ctrls, target): `Function`
    
    * Add custom unitary operation into `Circuit`.
    * Parameters:
      * Operator: `matrice` A unitary matrix representing behaviour of the unitary operation. (Can be complex number)
      * Ctrls: `int[]` An integer array specifying list of control qubit(s).
      * Target: `int` An index of qubit this `U` is operating on (Starting from 1).
  * ###### measure(Qtarget, Ctarget, basis): `Function`
    
    * Add measurement operation into `Circuit`. This will create a new instance of `Measurement` class containing measurement operators for a particular `basis` and will be operated on 1 `qubit` and store the measurement result in one `classical bit`.
    * Parameters:
      * Qtarget: `int` An index of qubit to be measured.
      * Ctarget: `int` An index of classical bit the result will be stored.
      * `Optional` Basis: `char` Basis of measurement. Can be `X`, `Y`, or `Z`(default).
  * ###### draw(): `Function`
    
    * Draw circuit diagram in MATLAB figure.
  * ###### result = execute(n_shots): `Function`
    
    * Execute the circuit. Calculate the theoretical result of the Quantum Circuit and sampling the result in number of `n_shots`.
    * Return Values:
      * Result: `struct` A struct containing the result of execution and all measurement result. Also, containing 2 visualization `function` : getCounts() and plotHistogram()
  * ###### out = peekOperations(): `Function`
    
    * Display all operations both Gate Operation and Measurement Operation inside operation queue of `Circuit`
  * ###### getMaxLength(): `Function`
    
    * Get maximum number of gate operating on a qubit in the `Circuit`
* ###### @Qubit : `Class`
  
  * ###### Qubit(initState): `Constructor`
    
    * `Constructor` of class Qubit. Call this constructor to create an instance of Qubit. **Note: When create new instance of Circuit, the instance of this class is created automatically. 
    * Parameters:
      * initState: `char` Initial quantum state for this qubit. Can be '0', '1', '+', '-', 'R' or 'L'
  * ###### state = getState(): `Function`
    
    * Getter function. Get current quantum state of this `Qubit`
    * Return Value:
      * State: `Matrice` Matrix of complex number describing current quantum state of this Qubit
  * ###### ket = getKet(): `Function`
    
    * Getter function. Get current quantum state of this `Qubit` in form of Ket
    * Return Value:
      * Ket: `Matrice` Matrix of complex number describing current quantum state of this Qubit
  * ###### bra = getBra(): `Function`
    
    * Getter function. Get current quantum state of this `Qubit` in form of Bra
    * Return Value:
      * Bra: `Matrice` Matrix of complex number describing current quantum state of this Qubit
  * ###### dense = getDensity(): `Function`
    
    * Getter function. Get density matrix of current quantum state of this `Qubit` 
    * Return Value:
      * Density: `Matrice` Matrix of complex number describing current quantum state of this Qubit in form of density matrix
  * ###### result = apply(operator): `Function`
    
    * Apply unitary operation or measurement operation on this qubit.
    * Parameters:
      * Operator: `struct` Unitary operation initialized as an instance of classes from Gates package or an instance of Measurement class
    * Return Value:
      * Result: `Matrice` Result of unitary operation or measurement operation on this Qubit.
* ###### @QuantumRegister: `Class`
  
  * ###### QuantumRegister(qreg_n, initState): `Constructor`
    
    * `Constructor` of class QuantumRegister. Call this constructor to create an instance of Quantum Register. **Note: When create new instance of Circuit, the instance of this class is created automatically. 
    * Parameters:
      * qreg_n: `int` Number of qubit in this Quantum Register.
      * initState: `char[]` Initial quantum state for this register in form of String. (e.g. '0000' or '0110+').
  * ###### size = getSize(): `Function`
    
    * Getter function. Get number of qubit in this quantum register.
    * Return Value:
      * Size: `int` Number of qubit in this quantum register.
  * ###### state = getState(): `Function`
    
    * Getter function. Get current state of this register.
    * Return Value:
      * State: `Matrice` Matrix of complex number describing current quantum state of this register.
  * ###### density = getDensity(): `Function`
    
    * Getter function. Get density matrix of current quantum state of this `Quantum Register` 
    * Return Value:
      * Density: `Matrice` Matrix of complex number describing current quantum state of this register in form of density matrix.
* ###### @Measurement: `Class`
  
  * ###### obj = Measurement(registerLength, basis, actOn, storeOn): `Constructor`
    
    * `Constructor` of class Measurement. Call this constructor to create an instance of Quantum Measurement. **Note: When add new measurement to a Circuit, new instance of this class will be initiated and add to the operation queue of the circuit automatically. 
    * Parameters:
      * registerLength: `int` Number of qubit in target Quantum Register.
      * basis: `char` Basis of measurement. Can be 'X', 'Y' or 'Z'.
      * actOn: `int` Index of Qubit in target Quantum Register to be measured.
      * storeOn: `int` Index of classical bit in target Quantum Register to store the measurement result.
  * ###### obj = Measurement(basis): `Constructor`
    
    * `Constructor` of class Measurement. Another variant of Measurement's constructor. This will create an instance of Measurement to be used with a Qubit instead of Quantum Register.
    * Parameters:
      * basis: `char` Basis of measurement. Can be 'X', 'Y' or 'Z'.
  * ###### operators = getOperators(): `Function`
    
    * Getter function. Get list of measurement operator of this instance of Measurement
    * Return Value:
      * Operators: `Map` List of measurement operator for specified basis in form of containers.Map.
  * ###### origin = getOrigin(): `Function`
    
    * Getter function. Get index of target Qubit to be measured.
    * Return Value:
      * origin: `int` Index of target Qubit to be measured.
  * ###### dest = getDestination(): `Function`
    
    * Getter function. Get index of target classical bit to hold result of this measurement.
    * Return Value: 
      * Dest: `int` Index of target classical bit to hold result of this measurement.
  * ###### basis = getBasis(): `Function`
    
    * Getter function. Get current measurement basis of this instance of Measurement.
    * Return Value: 
      * Basis: `char` Current measurement basis of this instance of Measurement.
<div style="page-break-after: always;"></div>
-----

### Gates

Gates is another `package` defined in `ExeQu`. The package itself doesn't have to be imported to the MATLAB script in basic use-cases unless user wishes to initiate an instance of quantum gates manually. Main purpose of this package is to define classes of quantum gates that will be used by `CircuitComposer`. All gate classes has it definition defined here.

###### +Gates: `Package`

* ###### @Unitary: `Class` `Super Class` 
  
  * Super class of all gates. Every gate is an inheritance of Unitary operation.
  * ###### Unitary(U, registerLength, actOn, label): `Constructor`
    
    * `Constructor` of class Unitary. This class define basic properties of every gate classes such as Label, UnitaryMatrix, Dimension etc.
    * Parameters:
      * U: `Matrice` Unitary matrix representation of gate.
      * RegisterLength: `int` Number of qubit in target quantum register that this Unitary will operate on.
      * actOn: `int` Index of qubit in target quantum register
      * Label: `int` Index of classical bit in target quantum register
  * ###### matrix = toMatrice(): `Function`
    
    * Getter function. Get matrice representation of this instance of Unitary.
    * Return Value:
      * Matrix: `matrice` Matrice representation of this instance of Unitary.
  * ###### label = getLabel(): `Function`
    
    * Getter function. Get label of this instance of Unitary.
    * Return Value:
      * Label: `String` Label of this instance of Unitary.
  * ###### mt = mtimes(varargin): `Function`
    
    * `MATLAB` operator overloading for operator '*'. This overloading define instructions to be perform in case this instance of Unitary are multiplied with an instance of Qubit or Quantum Register.
* ###### @ControlledU: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Controlled-U gate.
  * ###### ControlledU(U, registerLength, ctrl, target): `Constructor`
    
    * Parameters:
      * U: `Instance of Unitary` Another Instance of Unitary as U operator.
      * registerLength: : `int` Number of qubit in target quantum register that this Unitary will operate on.
      * Ctrl: `int[]` Array of integer specifying indexes of control qubit(s) for this ControlledU gate.
      * Target: `int` An integer specifying index of target qubit.
  * ###### uType = getUType(): `Function`
    
    * Getter function. Get type of U operator (Label).
    * Return Value:
      * uType: `String` Get type of U operator (Label).
  * ###### ctrl = getControl(): `Function`
    
    * Getter function. Get list of control qubits
    * Return Value:
      * ctrl: `int[]` List of control qubits.
  * ###### target = getTarget(): `Function`
    
    * Getter function. Get index of target qubits
    * Return Value:
      * Target: `int` Index of target qubits.
* ###### @U3: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of U3 gate.
  * ###### obj = U3(registerLength, target, theta, phi, lambda): `Constructor`
    
    * Parameters:
      * `Optional` RegisterLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
      * Theta: `float` Rotation angle around X-axis in radians 
      * Phi: `float` Rotation angle around Y-axis in radians 
      * Lambda: `float` Rotation angle around Z-axis in radians 
* ###### @PauliX: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Pauli-X gate.
  * ###### obj = PauliX(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @PauliY: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Pauli-Y gate.
  * ###### obj = PauliX(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @PauliZ: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Pauli-Z gate.
  * ###### obj = PauliX(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @RX: `Class ` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Rx gate.
  * ###### obj = PauliX(registerLength, target, theta): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
      * theta: `float` Rotation angle in radians
  * ###### theta = getTheta(): `Function`
    
    * Getter function. Get value of rotation angle set for this gate.
    * Return Value:
      * Theta: `float` Rotation angle in radians
* ###### @RY: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Ry gate.
  * ###### obj = PauliX(registerLength, target, theta): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
      * theta: `float` Rotation angle in radians
  * ###### theta = getTheta(): `Function`
    
    * Getter function. Get value of rotation angle set for this gate.
    * Return Value:
      * Theta: `float` Rotation angle in radians
* ###### @RZ: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Rz gate.
  * ###### obj = PauliX(registerLength, target, theta): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
      * theta: `float` Rotation angle in radians
  * ###### theta = getTheta(): `Function`
    
    * Getter function. Get value of rotation angle set for this gate.
    * Return Value:
      * Theta: `float` Rotation angle in radians
* ###### @S: `Class ` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of S gate.
  * ###### obj = S(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @Sdag: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Sdag gate (Conjugate transpose of S gate).
  * ###### obj = Sdag(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @T: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of T gate.
  * ###### obj = T(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @Tdag: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Tdag gate  (Conjugate transpose of T gate).
  * ###### obj = Tdag(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @Hadamard: `Class ` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of Hadamard gate.
  * ###### obj = Hadamard(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.
* ###### @Identity: `Class` `Subclass of Unitary`
  
  * Subclass of `Unitary`. This class define properties of I gate.
  * ###### obj = Identity(registerLength, target): `Constructor`
    
    * Parameters:
      * `Optional` registerLength: `int` Number of qubit in target quantum register that this gate will operate on.
      * `Optional` target: `int` An integer specifying index of target qubit.

**Note: 

* When working with Circuit, there is no need to import or calling constructors of these classes. Simply call functions like `x()`, `cnot()` or `h()` defined in a Circuit instance. Calling those functions, a quantum gate instances will be instantiated and added to the operation queue automatically.
* Also note that, some parameters are labeled `Optional` because parameters like `RegisterLength` or `Target` is not needed when creating these gates instance for working with `Qubit` through `apply()` function instead of `Circuit`
<div style="page-break-after: always;"></div>
----

### QASM Transpiler

ExeQu QASM Transpiler is a `package` responsible for conversion of openQASM 2.0 script to MATLAB script. Users could transcompile their openQASM 2.0 script in `.qasm` format to ExeQu script written in `.m` format using `Transpiler` class defined in this `package`

###### Supported Instructions
|       Instructions       |             Supported?             |
| :---------------: | :--------------------------: |
|  OPENQASM 2.0;  |         Yes         |
|  qreg name[size];  |         Yes         |
|  creg name[size];  |         Yes         |
|  include “filename”;  |         Yes         |
|  gate name(params) qargs  |         Yes         |
|  // comment text  |         Yes         |
|  U(theta, phi, lambda) qubit&#124;qreg;  |         Yes         |
|  CX qubit&#124;qreg, qubit&#124;qreg;  |         Yes         |
|  measure qubit&#124;qreg -> bit&#124;creg;  |         Yes         |
|  gatename(params) qargs;  |         Yes         |
|  barrier qargs;  |         Yes         |
|  if(creg==int) qop;  |         No         |
|  opaque name(params) qargs;  |         No         |
|  reset qubit&#124;qreg;  |         No         |

###### Usage

To start trancompiling, import the package to MATLAB script and instantiate new `Transpiler` instance. Then, use the instance to call `convert()` and pass 2 parameters: `inFileName` and `outFileName` which is the path of `.qasm` file to be transpile and the path of `.m` file to hold output.

```matlab
import ExeQu.Trsnapiler.*;

%Create Transpiler Instance
converter = Transpiler();

%Transcompile openQASM to MATLAB
converter = converter.convert('qasmCode.qasm', 'outCode.m');
```

###### +Transpiler: `package`

* ###### @Transpiler: `class`

  * ###### self = convert(inFileName, outFileName): `function`

    * Parameters:
      * inFileName: `String` Path of `.qasm` file to be transpile.
      * outFileName: `String` Path of `.m` file to hold output.
    * Return Value:
      * Self: `Transpiler` This instance of Transpiler.
<div style="page-break-after: always;"></div>
---

### Utils

Utils or Utilities is another `package` in ExeQu that defined some useful functions for Mathemetic calculation, Visualization and more.

###### +Utils: `package`

* ###### +Maths: `package`
  
  * ###### result = tensor(varargin): `function`
    
    * Calculate tensor product of multiple matrices.
    * Parameters:
      * Varargin: `Variable length of parameters` Matrices to be tensor together. (ex. tensor(matrixA, matrixB, matrixC);)
    * Return Value:
      * Result: `Matrice` Tensor product of matrices.
  * ###### bool = isUnitary(U): `function`
    
    * Validate if `U` is a valid unitary matrix.
    * Parameters:
      * U: `Matrice` A matrix to be validated.
    * Return Value:
      * Bool: `Boolean` A validation result whether `U` is an unitary matrix or not.
* ###### @Visualization: `class`
  
  * ###### plotOperation(op): `function`
    
    * Plot operation from operation queue into Circuit Diagram. **Note: This function is called by `Draw()` function in `Circuit`
    * Parameters:
      * Op: `Operation Struct` An operation from a Circuit's operation queue.
  * ###### plotCircuit(qreg,maxLength): `function`
    
    * Plot empty circuit diagram without any quantum gate. **Note: This function is called by `Draw()` function in `Circuit`
    * Parameters:
      * Qreg: `int` Number of qubit in target circuit's quantum register.
      * maxLength: `int` Maximum number of quantum gate applied on a single qubit. (This can be retrieved via `getMaxLength()` function in `Circuit`)
<div style="page-break-after: always;"></div>
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors

* **Pattharapong Chotechuang** - *Initial work* - [Htraez](https://github.com/Htraez)
* **Chanin Chongtanapaitoon** - *Visualization* - [jojojj007](https://github.com/jojojj007)
* **Nawakanok Muangkham** - *QASM Transpiler* - [guitarsk](https://github.com/guitarsk)

See also the list of [contributors](https://github.com/Htraez/ExeQu/graphs/contributors) who participated in this project.

## License
[MIT](https://choosealicense.com/licenses/mit/)

[flow]: ./Assets/Images/workflow_1.png "Workflow"

[x]: ./Assets/Images/x_gate.png "Pauli X"

[y]: ./Assets/Images/y_gate.png "Pauli Y"

[z]: ./Assets/Images/z_gate.png "Pauli Z"

[rx]: ./Assets/Images/rx_gate.png "RX"

[ry]: ./Assets/Images/ry_gate.png "RY"

[rz]: ./Assets/Images/rz_gate.png "RZ"

[s]: ./Assets/Images/s_gate.png "S"

[sdag]: ./Assets/Images/sdag_gate.png "S Dagger"

[t]: ./Assets/Images/t_gate.png "T"

[tdag]: ./Assets/Images/tdag_gate.png "T Dagger"

[cy]: ./Assets/Images/cy1_gate.png "CY"

[cz]: ./Assets/Images/cz1_gate.png "CZ"

[Cr]: ./Assets/Images/cr_gate.png "Cr"

[i]: ./Assets/Images/identity_gate.png "Identity"

[u3]: ./Assets/Images/u3_gate.png "U3"

[u2]: ./Assets/Images/u2_gate.png "U2"

[u1]: ./Assets/Images/u1_gate.png "U1"

[cx]: ./Assets/Images/cx_gate.png "Controlled-not"

[ccx]: ./Assets/Images/ccx_gate.png "Toffoli"

[mct]: ./Assets/Images/mct_gate.png "Multiple Control Toffoli"

[h]: ./Assets/Images/h_gate.png "Hadamard"

[u]: ./Assets/Images/u_gate.png "Unitary Gate"

[cu]: ./Assets/Images/cu_gate.png "Controlled-U"
