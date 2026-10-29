# Design and Verification of AXI4 Protocol Using UVM with Functional Coverage and Assertions

## Overview

This project focuses on the **design and verification of the AXI4 protocol** using **SystemVerilog and Universal Verification Methodology (UVM)**.

An **AXI4 Slave Memory** is developed as the Design Under Test (DUT) and verified using a reusable UVM-based verification environment. The environment uses constrained-random transaction generation, scoreboard-based checking, functional coverage, and SystemVerilog Assertions (SVA) to verify AXI4 protocol behavior and data transfer correctness.

The verification environment covers **single and burst read/write transactions**, different burst types, multiple burst lengths, AXI4 VALID/READY handshaking, data integrity, and protocol compliance.

## Project Objectives

- Design and implement an AXI4 Slave Memory.
- Develop a reusable UVM-based verification environment.
- Verify AXI4 read and write transactions.
- Verify burst transactions with different burst types and lengths.
- Apply constrained-random stimulus generation.
- Implement a scoreboard for transaction and data checking.
- Implement functional coverage to measure verification completeness.
- Implement SystemVerilog Assertions for AXI4 protocol checking.
- Analyze simulation waveforms and verification results.

## AXI4 Protocol

The AXI4 protocol uses five independent communication channels:

- **AW – Write Address Channel**
- **W – Write Data Channel**
- **B – Write Response Channel**
- **AR – Read Address Channel**
- **R – Read Data Channel**

The channels use the **VALID/READY handshake mechanism** for controlled data transfer.

The project verifies the communication between an AXI4 master and the developed AXI4 slave memory.

## UVM Verification Environment

The verification environment is developed using UVM and consists of reusable components including:

- **Sequence Item** – Represents AXI4 transactions.
- **Sequence** – Generates AXI4 read/write stimulus with randomized parameters.
- **Sequencer** – Controls transaction flow to the driver.
- **Driver** – Converts transactions into AXI4 interface signals.
- **Monitor** – Observes AXI4 interface activity.
- **Agent** – Groups the driver, monitor, and sequencer.
- **Environment** – Integrates the verification components.
- **Scoreboard** – Compares expected and actual transaction results.
- **Functional Coverage** – Measures verification scenario coverage.
- **SystemVerilog Assertions** – Checks AXI4 protocol rules and handshake behavior.

The monitor sends captured transactions to both the scoreboard and functional coverage components, while assertions monitor protocol behavior at the interface level.

## AXI4 Slave Memory

The DUT is an **AXI4 Slave Memory** designed to support read and write operations.

The memory design includes:

- Write address processing
- Write data handling
- Read address processing
- Read data generation
- Internal memory array
- Address generation
- Read/write control
- AXI4 handshake control
- Burst transaction support

The slave memory is verified through the UVM environment using both read and write transactions.

## Verification Features

### Constrained-Random Verification

The UVM sequences generate randomized AXI4 transactions to exercise different protocol scenarios.

### Scoreboard-Based Checking

The scoreboard compares expected transaction data with the actual observed results and checks data integrity.

### Functional Coverage

Functional coverage tracks important AXI4 verification scenarios including:

- Read/Write operations
- Burst types
- Burst lengths
- Burst transactions

### Assertion-Based Verification

SystemVerilog Assertions are used to check:

- VALID/READY handshaking
- Protocol behavior
- Signal stability
- Timing-related protocol conditions

## Test Scenarios

The project verifies:

### Single Transactions

- Single Write Transaction
- Single Read Transaction

### Burst Transactions

The following AXI4 burst types are verified:

- **FIXED**
- **INCR**
- **WRAP**

Different burst lengths are exercised during simulation.

The simulation includes **24 randomized AXI4 transactions**, consisting of:

- 12 Burst Write transactions
- 12 Burst Read transactions
- FIXED, INCR, and WRAP burst types
- Burst lengths of 1, 2, 3, and 4 beats

## Tools and Technologies

- **SystemVerilog**
- **UVM 1.2**
- **AXI4 Protocol**
- **Siemens QuestaSim 2025.2**
- **EDA Playground**
- **Constrained-Random Verification**
- **Functional Coverage**
- **SystemVerilog Assertions (SVA)**
- **Scoreboard-Based Verification**
- **Simulation Waveform Analysis**

## Verification Results

The implemented verification environment successfully verified AXI4 read and write operations.

### Coverage Results

- **Overall Functional Coverage: 100%**
- Burst Write: 12 transactions
- Burst Read: 12 transactions
- FIXED Burst: Pass
- INCR Burst: Pass
- WRAP Burst: Pass
- Scoreboard Check: Pass

The report records **100% functional coverage** for the defined verification scenarios.

### Assertion Results

The AXI4 protocol assertions passed successfully without reported protocol violations.

The simulation report also records:

- **0 warnings**
- **0 errors**
- **0 fatal errors**

The scoreboard reported successful checking of the transactions.

## Waveform Analysis

Simulation waveforms were analyzed for:

- AXI4 Single Write
- AXI4 Single Read
- AXI4 Burst Write
- AXI4 Burst Read
- AXI4 INCR Burst Write
- Internal Slave Memory and Address Counter Operation

The waveforms were used to verify correct VALID/READY handshaking, data transfer, memory access, burst operation, and response behavior.

## Verification Flow

```text
        AXI4 Transaction
               │
               ▼
          UVM Sequence
               │
               ▼
           Sequencer
               │
               ▼
            Driver
               │
               ▼
       AXI4 Interface
               │
               ▼
       AXI4 Slave Memory
               │
        ┌──────┴──────┐
        ▼             ▼
     Monitor        SVA
        │
   ┌────┴─────┐
   ▼          ▼
Scoreboard  Coverage
   │          │
   └────┬─────┘
        ▼
 Verification Results
```

## Key Skills Demonstrated

**SystemVerilog | UVM | AXI4 | RTL Verification | Constrained-Random Verification | Functional Coverage | SystemVerilog Assertions | Scoreboard | Protocol Verification | QuestaSim | EDA Playground | Waveform Analysis**

## Learning Outcomes

This project provided practical experience in:

- AXI4 protocol and transaction mechanisms
- UVM testbench development
- Reusable verification components
- Constrained-random verification
- Functional coverage
- Assertion-based verification
- Scoreboard-based checking
- Simulation and waveform analysis
- Protocol debugging and validation

## Future Scope

The verification environment can be extended to include:

- Multiple outstanding transactions
- Out-of-order responses
- Exclusive accesses
- Quality of Service (QoS) verification
- Additional constrained-random test scenarios
- Larger coverage models
- Integration with complex AXI4-based SoCs
- Regression automation
- Advanced protocol compliance testing
- Performance analysis

## Conclusion

The project successfully developed a **UVM-based verification environment for an AXI4 Slave Memory** using SystemVerilog, functional coverage, assertions, constrained-random stimulus, and scoreboard-based checking.

The verification environment successfully validated AXI4 read and write transactions across FIXED, INCR, and WRAP burst types. The reported results include **100% functional coverage, successful scoreboard checking, and passing assertions**, demonstrating the effectiveness of the developed verification methodology.
