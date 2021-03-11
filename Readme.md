# [PANTHER: Perception-Aware Trajectory Planner in Dynamic Environments](https://github.com/mit-acl/panther) #

Main repo is [this one](https://github.com/mit-acl/panther) 

This repo simply contains files that are needed either on the base station (for takeoff/land high-level commands) and on the SnapDragon. 

This repo should be cloned as a submodule of [PANTHER](https://github.com/mit-acl/panther) on the Intel NUC, and as a standalone repo on the base station and SnapDragon


## Notes to run HW experiments:
The param used in these files

```
	predictor.yaml
	panther.yaml
	panther/matlab/casadi_generated_files/params_casadi_prediction.yaml  [To change the parameters of this file, you must change it in predictor.m, and run that file again]
	panther/matlab/casadi_generated_files/params_casadi.yaml  [To change the parameters of this file, you must change it in main.m, and run that file again]
```

are available in tag `RAL_hw` (commit [`922e2c1d5bcb693ae` of PANTHER](https://github.com/mit-acl/panther/tree/922e2c1d5bcb693aed26097fbc00e9772aa5d390)).

To install sympy in the SnapDragon or Sykorsky:

```
sudo apt-get install python-sympy --no-install-recommends
```

## Other
```
In Sykorsky: roslaunch behavior_selector gui.launch
```

The file `generate_traj_params.py` will generate the `.yaml` files that specify the trajectories of the obstacles. These files are then used by `obstacle.launch`, which creates the corresponding parameters needed in `obstacles.py`.

---------

> **Approval for release**: This code was approved for release by The Boeing Company in March 2021. 
