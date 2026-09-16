# hsrb_wrs_gazebo_launch

Launch files for the WRS2020 HSR simulator (ROS 2 Jazzy / Gazebo Harmonic).

But, there is **no guarantee** that this simulator totally complies with WRS rule book.

Branches:

- `jazzy`: ROS 2 Jazzy + Gazebo Harmonic. Requires `tmc_wrs_gazebo` (branch `jazzy`) and the HSR jazzy packages (`hsrb_gazebo_launch` etc.)
- `master`: ROS 1 (uses TMC proprietary stacks and `tmc_gazebo_task_evaluators`)

## how to use

The easiest way is https://github.com/ry0hei-kobayashi/hsr-jazzy-docker , which mounts this repository and
`tmc_wrs_gazebo` into `/hsr_ros2_ws/src/additional_pkg/` and builds them at container startup.

```bash
docker compose up -d                  # in hsr-jazzy-docker
docker exec -it hsrb_jazzy bash
source /hsr_ros2_ws/install/setup.bash
ros2 launch hsrb_wrs_gazebo_launch wrs_practice0_tmc.launch.py
```

Without docker, put `hsrb_wrs_gazebo_launch` and `tmc_wrs_gazebo` in a workspace that already contains the HSR jazzy
packages, then `rosdep install --from-paths src -y --ignore-src && colcon build`.

Gazebo simulator with WRS2020 world will appear.

![wrs_world](img/wrs_world.png)

## task variations

Simulator with reduced number of object will be launched by using `wrs_practice0_easy_tmc.launch.py` and can be used for early development:

```bash
ros2 launch hsrb_wrs_gazebo_launch wrs_practice0_easy_tmc.launch.py
```

Each simulator has different numbered launch files (`wrs_practice{0,1,2}_easy_tmc.launch.py` and `wrs_practice{0,1,2}_tmc.launch.py`)
which allocate objects to slightly different positions (seed 1, 2, 3). `wrs_empty.launch.py` launches the field without task objects.

You can use these variations to evaluate robustness of your algorithm.

## launch arguments

All launch files are thin wrappers around `tmc_wrs_gazebo_launch/launch/include/wrs_common.launch.py`, so every
argument of that file can be given on the command line:

- `seed`: random number seed to determine object placement
- `per_category`, `obstacles`, `per_row`: number of objects (task 1 per category / task 2a obstacles / task 2 per row)
- `fast_physics`: `true` launches the simulator in fast physics mode (faster, less precise)
- `highrtf`: `true` runs the simulator faster than real time
- `with_handle`: `true` (default) uses the trofast drawers with knobs
- `rviz`, `use_navigation`, `use_manipulation`, `use_teleop`, `use_joy_node`, ...: standard HSR simulator arguments

```bash
ros2 launch hsrb_wrs_gazebo_launch wrs_practice0_easy_tmc.launch.py seed:=10 fast_physics:=true highrtf:=true
```

## differences from the ROS 1 version

- The task evaluators (`tmc_gazebo_task_evaluators`: `object_in_box_detector`, `undesired_contact_detector`, `wrs_score_counter`,
  `wrs_camera_controller`) have no ROS 2 / Gazebo Sim port, so no score is computed.
- `use_oss_stacks` no longer exists: navigation / manipulation / teleop come from `hsrb_gazebo_common.launch.py` of the HSR jazzy packages.
- `tests/wrs_task1_tidy_orientation_items.sh` uses the `/spawn_entity` and `/delete_entity` service bridges.

# LICENSE

This software is released under the BSD 3-Clause Clear License, see LICENSE.txt.
