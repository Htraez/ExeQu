# Project ExeQu
### Quantum Gates and Circuit Simulator in MATLAB

ExeQu is a `MATLAB` toolbox designed to provide quantum programming enthusiats a tool for creating quantum circuit as well as simulating it result.

## Installation

ExeQu is currently under development. You can clone ExeQu using [remote url](https://github.com/Htraez/ExeQu.git)

```bash
git clone https://github.com/Htraez/ExeQu.git
```

### Download MATLAB Toolbox Installer 

You could install `ExeQu` into your MATLAB addons path using `.mltbx` file in the release section of this repository. Current release is `_`, download [here](https://github.com/Htraez/ExeQu/releases/tag/untagged-1ece0e76941a2866c102)

## Usage

```matlab
import ExeQu.CircuitComposer.*;
import ExeQu.Gates.*;

%Create new quantum circuit with 2 qubits, 2 classical bits
circuit = Circuit(2, 2); 

%Add some quantum gates
circuit.h(1); %Add hadamard gate to the first qubit
circuit.cnot(1, 2); %Add controlled-not gate to with 1st as control and 2nd as target

circuit.draw(); %Draw circuit structure
result = circuit.execute(1024); %Simulate circuit (1024 shots)
result.plotHistogram(); %Visualize result
```
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
