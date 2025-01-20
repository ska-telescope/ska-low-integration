Low Telescope Deployment
========================

Components
----------

Low Telescope deployment includes the following components:

1. **TMC**  
2. **SDP-LMC**  
3. **CSP-LMC**  
4. **MCCS-LMC**  

Configurable Options
--------------------

Instances and Subarray Count
============================

Instances
---------

Users can provide an array of device server deployment instances required for a component.

+-------------+-----------------+
| **Component** | **Default**   |
+=============+=================+
| TMC         | ["01"]          |
+-------------+-----------------+
| SDP-LMC     | ["01"]          |
+-------------+-----------------+
| CSP-LMC     | ["01"]          |
+-------------+-----------------+
| MCCS-LMC    | ["01"]          |
+-------------+-----------------+

Subarray Count
--------------

Users can set the subarray count based on the number of required device server deployment instances.

+----------------------+----------------------------+
| **Property**         | **Value**                  |
+======================+============================+
| Default Value        | 2                          |
+----------------------+----------------------------+
| Applicable Components| TMC, SDP-LMC, CSP-LMC,     |
|                      | MCCS-LMC                   |
+----------------------+----------------------------+


3. **Configuration File:**  
   Users can provide a custom device server configuration file.  
   `Configuration files <https://gitlab.com/ska-telescope/ska-mid-integration/-/tree/main/charts/ska-mid-integration/tmc_pairwise/>`_  

4. **Enabled:**  
   Allows users to enable or disable simulated components.  
   Default is `True` for all components.  
   `Makefile <https://gitlab.com/ska-telescope/ska-mid-integration/-/blob/main/Makefile/>`_

5. **Global FQDN Prefixes:**  

+----------------------------------------+----------------------------------------------------------------+
| **Setting**                            | **Description**                                                |
+========================================+================================================================+
| **tmc_subarray_prefix**                | FQDN prefix of TMC Subarray                                    |
+----------------------------------------+----------------------------------------------------------------+
| **csp_subarray_ln_prefix**             | FQDN prefix of CSP-LMC Subarray Leaf Node                      |
+----------------------------------------+----------------------------------------------------------------+
| **sdp_subarray_ln_prefix**             | FQDN prefix of SDP-LMC Subarray Leaf Node                      |
+----------------------------------------+----------------------------------------------------------------+
| **csp_master_ln_prefix**               | FQDN prefix of CSP-LMC Master Leaf Node                        |
+----------------------------------------+----------------------------------------------------------------+
| **sdp_master_ln_prefix**               | FQDN prefix of SDP-LMC Master Leaf Node                        |
+----------------------------------------+----------------------------------------------------------------+
| **csp_subarray_prefix**                | FQDN prefix of CSP Subarray                                    |
+----------------------------------------+----------------------------------------------------------------+
| **sdp_subarray_prefix**                | FQDN prefix of SDP Subarray                                    |
+----------------------------------------+----------------------------------------------------------------+
| **csp_master**                         | FQDN of CSP-LMC Master                                         |
+----------------------------------------+----------------------------------------------------------------+
| **sdp_master**                         | FQDN of SDP-LMC Master                                         |
+----------------------------------------+----------------------------------------------------------------+
| **mccs_master**                        | FQDN of MCCS-LMC Master                                        |
+----------------------------------------+----------------------------------------------------------------+
| **mccs_master_ln_prefix**              | FQDN prefix of MCCS-LMC Master Leaf Node                       |
+----------------------------------------+----------------------------------------------------------------+
| **mccs_subarray_prefix**               | FQDN prefix of MCCS Subarray                                   |
+----------------------------------------+----------------------------------------------------------------+
| **mccs_subarray_ln_prefix**            | FQDN prefix of MCCS Subarray Leaf Node                         |
+----------------------------------------+----------------------------------------------------------------+

Delay Settings
--------------

+---------------------------------------+--------------------------------------+
| **Setting**                           | **Description**                      |
+=======================================+======================================+
| **Delay Cadence**                     | Time difference (in seconds) between |
|                                       | each publication of delay values to  |
|                                       | the `delayModel` attribute on the    |
|                                       | CSP-LMC Subarray.                    |
+---------------------------------------+--------------------------------------+
| **Delay Validity Period**             | Duration (in seconds) for which      |
|                                       | delay values remain valid after      |
|                                       | being published.                     |
+---------------------------------------+--------------------------------------+
| **Delay Model Time In Advance**       | Time (in seconds) by which delay     |
|                                       | values need to be available in       |
|                                       | advance.                             |
+---------------------------------------+--------------------------------------+


Interface URLs
--------------

+--------------------------------------------+---------------------------------------------------------+
| **Interface**                              | **URL**                                                 |
+============================================+=========================================================+
| **CSP Assign Resources Interface URL**     | https://schema.skao.int/ska-low-csp-assignresources/3.0 |
+--------------------------------------------+---------------------------------------------------------+
| **CSP Scan Interface URL**                 | https://schema.skao.int/ska-low-csp-scan/2.0            |
+--------------------------------------------+---------------------------------------------------------+
| **SDP Scan Interface URL**                 | https://schema.skao.int/ska-sdp-scan/0.4                |
+--------------------------------------------+---------------------------------------------------------+
| **MCCS Configure Interface URL**           | https://schema.skao.int/ska-low-mccs-configure/1.0      |
+--------------------------------------------+---------------------------------------------------------+
| **MCCS Scan Interface URL**                | https://schema.skao.int/ska-low-mccs-scan/3.0           |
+--------------------------------------------+---------------------------------------------------------+

Low Telescope Sub-system FQDNs
------------------------------

Below are the FQDNs of the Low Telescope components. For the latest FQDNs, refer to `values.yaml` in the Low Telescope charts.

+-----------------------------+---------------------------------------------+
| **Low Telescope Component** | **FQDN**                                    |
+=============================+=============================================+
| TMC                         | ska_low/tm_central/central_node             |
+-----------------------------+---------------------------------------------+
| SDP-LMC                     | ska_low/sdp_lmc/{id}                        |
+-----------------------------+---------------------------------------------+
| CSP-LMC                     | ska_low/csp_lmc/{id}                        |
+-----------------------------+---------------------------------------------+
| MCCS-LMC                    | ska_low/mccs_lmc/{id}                       |
+-----------------------------+---------------------------------------------+

**Note:** `{id}` represents the deployed subarray identifier.  

Examples:
--------

**Subarray Configuration**


+---------------+--------------------------------------------+  
| **Component** | **Subarray 1**                             |  
+===============+============================================+  
| TMC Subarray  | `ska_low/tm_central/central_node/01`       |  
+---------------+--------------------------------------------+  
| SDP-LMC       | `ska_low/sdp_lmc/01`                       |  
+---------------+--------------------------------------------+  
| CSP-LMC       | `ska_low/csp_lmc/01`                       |  
+---------------+--------------------------------------------+  
| MCCS-LMC      | `ska_low/mccs_lmc/01`                      |  
+---------------+--------------------------------------------+  

+---------------+--------------------------------------------+  
| **Component** | **Subarray 2**                             |  
+===============+============================================+  
| TMC Subarray  | `ska_low/tm_central/central_node/02`       |  
+---------------+--------------------------------------------+  
| SDP-LMC       | `ska_low/sdp_lmc/02`                       |  
+---------------+--------------------------------------------+  
| CSP-LMC       | `ska_low/csp_lmc/02`                       |  
+---------------+--------------------------------------------+  
| MCCS-LMC      | `ska_low/mccs_lmc/02`                      |  
+---------------+--------------------------------------------+ 