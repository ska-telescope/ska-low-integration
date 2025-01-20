# SKA Low Integration

This repository is dedicated to the integration of components for the SKA Low telescope. It provides tools, scripts, and configurations to support the integration, deployment, and verification of various telescope subsystems.
This Repository is only meant for Deployment and integration of subsystems.
## Documentation

Click below to access the TMC documentation.

[![Documentation Status](https://readthedocs.org/projects/ska-telescope-ska-low-integration/badge/?version=latest)](https://developer.skao.int/projects/ska-low-integration/en/latest/)


### Deployment of Subsystem in Integration 
 #### Deployment of MCCS LMC Helm Chart
 * To deploy the MCCS LMC chart in integration, run the following command:
    ```bash
    make k8s-install-chart MCCS_SIMULATION_ENABLED=false
    ```
    All values required for deploying the MCCS LMC can be provided in the `charts/tmc_pairwise/tmc_mccs_values.yml` file.

    
    After running the above command, the MCCS LMC will get
    deployed in the provided Kubernetes Namespace (i.e., `KUBE_NAMESPACE`).


 * Uninstall the MCCS LMC chart:
    ```bash
    make k8s-uninstall-chart
 #### Deployment of SDP LMC Helm Chart
 * To deploy the SDP LMC chart in integration, run the following command:
    ```bash
    make k8s-install-chart SDP_SIMULATION_ENABLED=false
    ```
    All values required for deploying the SDP LMC can be provided in the `charts/tmc_pairwise/tmc_sdp_values.yml` file.

    
    After running the above command, the SDP LMC will get
    deployed in the provided Kubernetes Namespace (i.e., `KUBE_NAMESPACE`).


 * Uninstall the SDP LMC chart:
    ```bash
    make k8s-uninstall-chart

 #### Deployment of CSP LMC Helm Chart
 * To deploy the CSP LMC chart in integration, run the following command:
    ```bash
    make k8s-install-chart CSP_SIMULATION_ENABLED=false
    ```
    All values required for deploying the CSP LMC can be provided in the `charts/tmc_pairwise/tmc_csp_values.yml` file.

    
    After running the above command, the CSP LMC will get
    deployed in the provided Kubernetes Namespace (i.e., `KUBE_NAMESPACE`).


 * Uninstall the CSP LMC chart:
    ```bash
    make k8s-uninstall-chart

## Overview
The SKA Telescope system is divided into two telescopes:

1. **Low Telescope**
2. **Mid Telescope**

Each telescope involves two deployment phases:

1. **Pairwise Deployment**: Focuses on individual subsystems.
2. **System-Level Deployment**: Validates the overall functionality of the telescope.



### Mid Telescope Deployment Structure
#### Pairwise Deployments
- **tmc_csp**
- **tmc_sdp**
- **tmc_mccs**

#### System-Level Deployment
- **MARK**: `system_level_tests`

---

## Deployment Commands

### Pairwise Deployment
To run pairwise deployments for the Mid Telescope, use the following command:

```bash
make k8s-install-chart {Subsystem}_SIMULATION_ENABLED=false
```
Replace `{subsystem}` with one of the following:
- `MCCS`
- `SDP`
- `CSP`

For example, to deploy the **tmc_mccs** subsystem:

```bash
make k8s-install-chart MCCS_SIMULATION_ENABLED=false
```

### System-Level Deployment
To deploy system-level charts for the Mid Telescope:

```bash
make k8s-install-chart MCCS_SIMULATION_ENABLED=false SDP_SIMULATION_ENABLED=false CSP_SIMULATION_ENABLED=false
```


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
  - For System-Level Deployment: `system_level_tests`

---

## Contributing
We welcome contributions! Please feel free to open issues or submit merge requests for improvements.

For further assistance, refer to the [ska-low-integration](https://gitlab.com/ska-telescope/ska-low-integration) and [ska-mid-integration](https://gitlab.com/ska-telescope/ska-mid-integration) repositories.

---



