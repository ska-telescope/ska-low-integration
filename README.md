# SKA Low Integration

This repository is dedicated to the integration of components for the SKA Low telescope. It provides tools, scripts, and configurations to support the integration, deployment, and verification of various telescope subsystems.
This Repository is only meant for Deployment and integration of subsystems.

## Overview
The SKA Telescope system is divided into two telescopes:

1. **Low Telescope**
2. **Mid Telescope**

Each telescope involves two testing phases:

1. **Pairwise Testing**: Focuses on individual subsystems.
2. **System-Level Testing**: Validates the overall functionality of the telescope.


### Low Telescope Testing Structure
#### Pairwise Tests
- **tmc_csp**
- **tmc_sdp**
- **tmc_mccs**

#### System-Level Deployment
- **MARK**: `system_level_tests`

### Mid Telescope 
#### Pairwise Deployment
- **tmc_csp**
- **tmc_sdp**
- **tmc_dish**

---


### System-Level Deployment
To deploy system-level charts for the Low Telescope:

```bash
make k8s-test MARK=system_level_tests
```

---

## Flowchart

### Testing Structure

```plaintext
SKA Telescope
|
|-- Low Telescope
|   |-- Pairwise Testing
|   |   |-- tmc_csp
|   |   |-- tmc_sdp
|   |   |-- tmc_mccs
|   |
|   |-- System-Level Testing
|       |-- system_level_tests
|
|-- Mid Telescope
    |-- Pairwise Testing
    |   |-- tmc_csp
    |   |-- tmc_sdp
    |   |-- tmc_dish
    |
    |-- System-Level Testing
        |-- system_level_tests
```

### Deployment Commands
```plaintext
make k8s-install-chart MARK=<test_type>
```
- Replace `<test_type>` with:
  - For Low Pairwise Deployment: `tmc_csp`, `tmc_sdp`, or `tmc_mccs`
  - For Mid Pairwise Deployment: `tmc_csp`, `tmc_sdp`, or `tmc_dish`
  - For System-Level Deployment: `system_level_tests`

---

## Contributing
We welcome contributions! Please feel free to open issues or submit merge requests for improvements.

For further assistance, refer to the [ska-low-integration](https://gitlab.com/ska-telescope/ska-low-integration) and [ska-mid-integration](https://gitlab.com/ska-telescope/ska-mid-integration) repositories.

---



