# Project ExeQu
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

ExeQu is designed to be easy-to-use. The main workflow of ExeQu is consists of creation of Quantum Circuit, execution of created circuit, and Quantum Circuit visualization.

![Asset 2@2x](https://github.com/Htraez/ExeQu/blob/master/Assets/Images/Asset2_2x.png)

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
As the code suggests. The very first step of using ExeQu is importing the toolbox into the coding environment. The process of simulating this circuit is started by creating empty circuit using `Circuit` constructor passing 2 parameter first is the number of qubit, second is the number of classical bit which will hold the measurement result afterward.

After having empty circuit you can add gates and measurement into the circuit using functions defined in the `Circuit` object itself. Then, by calling `draw()` function, you will see the circuit diagram displaying components in the circuit you composed. 

At this point, to start the execution process, simply call `execute()` passing a `shots` parameter to specify the number of shots to sampling the result after the calculation process finished. 

Finally, in the visualization process, you can use `result` struct returned from `execute()` to call `plotHistogram()` to show the result of the circuit in form of probability histogram of possible quantum state(s)

## Components

To understand the toolbox capability in detail, it's sensible to understand some key components of the toolbox and functions available in packages and classes defined in `ExeQu`

### CircuitComposer

CircuitComposer is the main `package` that user will be using everytime to initiate a Quantum Circuit. It is also an important `package` that need to be imported into the MATLAB script in order to use `ExeQu`. The package itself consists of 4 main classes: `Circuit`, `Qubit`, `QuantumRegister`, `Measurement`

+CircuitComposer: `Package`

* @Circuit: `Class`
  * Circuit(qreg_length, creg_length): `Constructor`
    * `Constructor` of class `Circuit`. Call this constructor to create an instance of circuit. 
    * Parameters:
      * Qreg_length: `int` Number of qubit(s) in the circuit
      * Creg_length: `int` Number of classical bit(s) in the circuit 
  * add(operation): `Function`
    * Add a new unitary operation into `Circuit`.  ** Note: When adding new unitary operations (gate operations) into the circuit using pre-defined gate function (e.g. x(), y(), cnot() etc.) this functions will be called automatically.
    * Parameters:
      * Operation: `Operation struct` A struct describing unitary operation created by others function that initiate unitary operation such as `unitary()` 
  * barrier(from, to): `Function`
    * Add barrier to `Circuit`
    * Parameters:
      *  `Optional` From: `int` Specify starting qubit of the barrier
      *  `Optional` To: `int` Specify ending qubit to be covered by the barrier
  * x(target): `Function`
    * Add Pauli-X gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this Pauli-X gate is operating on. (Starting from 1)
  * y(target): `Function`
    * Add Pauli-Y gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this Pauli-Y gate is operating on. (Starting from 1)
  * z(target): `Function`
    * Add Pauli-Z gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this Pauli-Z gate is operating on. (Starting from 1)
  * controlledU(U, ctrls, target): `Function`
    * Add new Controlled-U gate to the `Circuit`. A controlled-U gate operation is an operation of applying U operator to certain `target` qubit based on the state of `control` qubit. `U` operator must be 2x2 dimensions or 1 qubit and must be initialized by a constructor of `Unitary` class or one of its inheritances.
    * Parameters:
      * U: `Instance of Unitary class` The unitary operation `U` that is meant to be operate on the `target` qubit when the `control` qubit(s) is all in state |1>.
      * Ctrls: `int[]` An integer array specifying list of control qubit(s).
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * cnot(ctrl, target): `Function`
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-X` gate and having only one control qubit. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `Cnot` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * ccnot(self, ctrl1, ctrl2, target): `Function`
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-X` gate and having 2 control qubits. (This gate is also known as `Toffoli` Gate). Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl1, Ctrl2: `int` Index of first and second qubit that controlling this `CCnot` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * cr(ctrl, target, theta): `Function`
    * Also known as `Controlled phase shift`. A pre-defined `Controlled-U` gate where `U` is `Phase Shift` operation and having 1 control qubits. (This gate is a generalization of the `CZ` gate). Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `CR` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * cy(ctrl, target): `Function`
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-Y` gate and having only one control qubit. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `Cy` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * cz(ctrl, target): `Function`
    * A pre-defined `Controlled-U` gate where `U` is defined as `Pauli-Z` gate and having only one control qubit. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrl: `int` An index of qubit that controlling this `Cz` gate.
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * mct(ctrls, target): `Function`
    * Multiple Controlled Toffoli Gate. Another variant of `controlled-U` where `U` is defined as `Pauli-X` gate but have multiple (more than 2) `control` qubits. Call this function to add the operation into `Circuit`.
    * Parameters:
      * Ctrls: `int[]` An integer array specifying list of control qubit(s).
      * Target: `int` An index of qubit this `U` is operating on. (Starting from 1)
  * h(target): `Function`
    * Add `Hadamard` into the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `H`-gate is operating on. (Starting from 1)
  * s(target): `Function`
    * Add `Phase gate` (or S gate) into the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `S`-gate is operating on. (Starting from 1)
  * t(target): `Function`
    * Add `T gate` into the `Circuit`. The T gate is related to the `S`-gate by the relationship  S= T<sup>2</sup>.
    * Parameters:
      * Target: `int` An index of qubit this `T`-gate is operating on. (Starting from 1)
  * sdag(target): `Function`
    * Add conjugate transpose of the `S`-gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `Sdag`-gate is operating on. (Starting from 1)
  * tdag(target): `Function`
    * Add conjugate transpose of the `T`-gate to the `Circuit`
    * Parameters:
      * Target: `int` An index of qubit this `Tdag`-gate is operating on. (Starting from 1)
  * rx(target, theta): `Function`
    * Add `Rx`-gate into the `Circuit`. `Rx`-gate is one of the `Rotation Operators` which represent an arbitrary rotation around X axis.
    * Parameters:
      * Target: `int` An index of qubit this `Rx`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * ry(target, theta): `Function`
    * Add `Ry`-gate into the `Circuit`. `Ry`-gate is one of the `Rotation Operators` which represent an arbitrary rotation around Y axis.
    * Parameters:
      * Target: `int` An index of qubit this `Ry`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * rz(target, theta): `Function`
    * Add `Rz`-gate into the `Circuit`. `Rz`-gate is one of the `Rotation Operators` which represent an arbitrary rotation around Z axis.
    * Parameters:
      * Target: `int` An index of qubit this `Rz`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
  * identity(target): `Function`
    * Add `Identity` gate to the `Circuit`. An identity gate is represented by an identity matrice. Adding identity gate to `target` qubit mean doing nothing to that qubit.
    * Parameters:
      * Target: `int` An index of qubit this `I`-gate is operating on. (Starting from 1)
  * u3(target, theta, phi, lambda): `Function`
    * Add `Generic single-qubit rotation` gate: `U3` into the `Circuit`. The `U3` gate is an unitary operation of rotation around X, Y and Z axis specified by parameter `theta`, `phi`, and `lambda` which are angle of rotation around each axis respectively in radians.
    * Parameters:
      * Target: `int` An index of qubit this `U3`-gate is operating on. (Starting from 1)
      * Theta: `float` An angle of rotation `theta` *θ* in radians
      * Phi: `float` An angle of rotation `phi` ** in radians
      * Lambda: `float` An angle of rotation `lambda` ** in radians
  * u2(target, phi, lambda): `Function`
    * Add `Generic single-qubit rotation` gate: `U2` into the `Circuit`. U2 gate is a `U3`-gate with theta = pi/2
    * Parameters:
      * Target: `int` An index of qubit this `U3`-gate is operating on. (Starting from 1)
      * Phi: `float` An angle of rotation `phi` ** in radians
      * Lambda: `float` An angle of rotation `lambda` ** in radians
  * u1(target, lambda): `Function`
    * Add `Generic single-qubit rotation` gate: `U1` into the `Circuit`. U1 gate is a `U3`-gate with theta = phi = 0
    * Parameters:
      * Target: `int` An index of qubit this `U3`-gate is operating on. (Starting from 1)
      * Lambda: `float` An angle of rotation `lambda` ** in radians
  * operation = unitary(operator, ctrls, target): `Function`
    * Add custom unitary operation into `Circuit`.
    * Parameters:
      * Operator: `matrice` A unitary matrix representing behaviour of the unitary operation. (Can be complex number)
      * Ctrls: `int[]` An integer array specifying list of control qubit(s).
      * Target: `int` An index of qubit this `U` is operating on (Starting from 1).
  * measure(Qtarget, Ctarget, basis): `Function`
    * Add measurement operation into `Circuit`. This will create a new instance of `Measurement` class containing measurement operators for a particular `basis` and will be operated on 1 `qubit` and store the measurement result in one `classical bit`.
    * Parameters:
      * Qtarget: `int` An index of qubit to be measured.
      * Ctarget: `int` An index of classical bit the result will be stored.
      * `Optional` Basis: `char` Basis of measurement. Can be `X`, `Y`, or `Z`(default).
  * draw(): `Function`
    * Draw circuit diagram in MATLAB figure.
  * result = execute(n_shots): `Function`
    * Execute the circuit. Calculate the theoretical result of the Quantum Circuit and sampling the result in number of `n_shots`.
    * Return Values:
      * Result: `struct` A struct containing the result of execution and all measurement result. Also, containing 2 visualization `function` : getCounts() and plotHistogram()
  * out = peekOperations(): `Function`
    * Display all operations both Gate Operation and Measurement Operation inside operation queue of `Circuit`
  * getMaxLength(): `Function`
    * Get maximum number of gate operating on a qubit in the `Circuit`
* @Qubit
* @QuantumRegister
* @Measurement

## Quantum Gates

A quantum gate could be added to a circuit using methods defined in the `Circuit`. Right now there several of them available as shown below.

Suppose a circuit instantiated using this code 

```matlab
circuit = Circuit(`number_of_qubit`, `number_of_cbit`);
```

| Gates           | Name          | Syntax                       |
| :-------------: |:-------------:| :---------------------------:|
| ![alt text][x]  | Pauli-x Gate  | circuit.x(`target_qubit`)    |
| ![alt text][y]  | Pauli-y Gate  | circuit.y(`target_qubit`)    |
| ![alt text][z]  | Pauli-z Gate  | circuit.z(`target_qubit`)    |
| ![alt text][i]  | Identity Gate | circuit.i(`target_qubit`)    |
| ![alt text][h]  | Hadamard Gate | circuit.h(`target_qubit`)    |
| ![alt text][cx] | CNOT Gate     | circuit.cnot(`control_qubit`,`target_qubit`) |
| ![alt text][ccx] | Toffoli Gate     | circuit.ccnot(`control_qubit1`,`control_qubit2`,`target_qubit`) |

## Measurement

A measurement unit can be added to a `Circuit` at a certain point using command
```matlab
circuit.measure(`target_qubit`, `destination_classical_bit`, `basis (optional)`)
```
User need to specify which qubit to be measured and also a classical bit that will hold the measurement result.
Also 3 different axis of measurement can be specified: `x`, `y`, `z`. If no basis specified the `z` axis will be use by default which mean the measurement operator would be |0><0| and |1><1|

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
[x]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/c51de67e35e3428b85cb383834263479x.png "Pauli X"
[y]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/1fe22994647245299d2c257958d14562y.png "Pauli Y"
[z]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/3c02d82e71984f0884ee1b5e798674edz.png "Pauli Z"
[i]: https://s3.us-south.cloud-object-storage.appdomain.cloud/strapi/f3e724b5de7342a4b7b355d6a5973b83id.png "Identity"
[cx]: https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/CNOT_gate.svg/150px-CNOT_gate.svg.png "Controlled-not"
[ccx]: https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Toffoli_gate.svg/1200px-Toffoli_gate.svg.png "Toffoli"
[h]: https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Hadamard_gate.svg/150px-Hadamard_gate.svg.png "Hadamard"
