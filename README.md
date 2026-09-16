# hsrb_wrs_gazebo_launch

Launch files for the WRS2020 HSR simulator (ROS 2 Jazzy / Gazebo Harmonic).
Requires `tmc_wrs_gazebo` (branch `jazzy`) and the HSR jazzy packages.

But, there is **no guarantee** that this simulator totally complies with WRS rule book.

## how to use

```bash
$ mkdir -p ros2_ws/src
$ cd ros2_ws/src
$ git clone -b jazzy https://github.com/hsr-project/hsrb_wrs_gazebo_launch.git
$ git clone -b jazzy https://github.com/hsr-project/tmc_wrs_gazebo.git
$ cd ..
$ colcon build --symlink-install
$ source install/setup.bash
$ ros2 launch hsrb_wrs_gazebo_launch wrs_practice0_tmc.launch.py
```

Docker environment: https://github.com/ry0hei-kobayashi/hsr-jazzy-docker

Gazebo simulator with WRS2020 world will appear.

![wrs_world](img/wrs_world.png)

## task variations

Simulator with reduced number of object will be launched by using "wrs_practice0_easy_tmc.launch.py":

```bash
$ ros2 launch hsrb_wrs_gazebo_launch wrs_practice0_easy_tmc.launch.py
```

Each numbered launch file (`wrs_practice{0,1,2}_easy_tmc.launch.py`, `wrs_practice{0,1,2}_tmc.launch.py`) allocates objects to slightly different positions.
`wrs_empty.launch.py` launches the field without objects.

## launch arguments

- `seed`: random number seed to determine object placement
- `fast_physics`: `true` launches the simulator in fast physics mode (faster, less precise)
- `highrtf`: `true` runs the simulator faster than real time

```bash
$ ros2 launch hsrb_wrs_gazebo_launch wrs_practice0_easy_tmc.launch.py seed:=10 fast_physics:=true highrtf:=true
```

# LICENSE

This software is released under the BSD 3-Clause Clear License, see LICENSE.txt.
