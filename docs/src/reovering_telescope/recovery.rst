.. _Recovering_Telescope_Low:

How to Recover Telescope Low When It Remains in a Given ObsState for an Extended Period
========================================================================================

The following sections outline the steps to recover **Telescope Low** when it becomes stuck in one of the intermediate **ObsStates** (e.g., **RESOURCING**, **CONFIGURING**, **FAULT**).

These steps include command-line instructions that can be executed from any Python runtime environment or script.

Using Abort() & Restart() Commands
----------------------------------

When **Telescope Low** is stuck in one of the **ObsStates** while running, you can use the **Subarray Node** to recover it.

.. list-table:: Steps to Recover Using Abort() & Restart() Commands
   :widths: 15 85
   :header-rows: 1

   * - **Scenario**
     - **Steps to Recover**
   * - Telescope Low Stuck in Intermediate ObsState
     - **Using Subarray Node:**
       
       1. **Create Device Proxy of Subarray Node**
          
          ```python
          subarray_node = tango.DeviceProxy("ska_low/tm_subarray_node/01")
          ```
       
       2. **Execute Commands to Recover Telescope Low:**
          
          To recover **Telescope Low** stuck in **RESOURCING**:
          
          ```python
          subarray_node.Abort()
          subarray_node.Restart()
          ```
       
       3. **Handle Specific ObsStates:**
          
          - **RESOURCING**
            - Execute `Abort()` followed by `Restart()`.
          
          - **CONFIGURING**
            - *No additional steps defined.*


