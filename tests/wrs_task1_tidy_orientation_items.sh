#!/bin/sh
# Copyright (c) 2019 TOYOTA MOTOR CORPORATION
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

#  * Redistributions of source code must retain the above copyright notice,
#  this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#  notice, this list of conditions and the following disclaimer in the
#  documentation and/or other materials provided with the distribution.
#  * Neither the name of Toyota Motor Corporation nor the names of its
#  contributors may be used to endorse or promote products derived from
#  this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# ROS 2 / Gazebo Sim version. Requires the /spawn_entity and /delete_entity
# service bridges started by tmc_wrs_gazebo_launch/launch/include/wrs_common.launch.py.

# respawn <entity_name> <model_uri_name> <qx> <qy> <qz> <qw>
# The object is placed 0.2 m above the origin of wrc_container_a with the given orientation.
respawn() {
  ros2 service call /delete_entity ros_gz_interfaces/srv/DeleteEntity \
    "{entity: {name: '$1', type: 2}}"
  ros2 service call /spawn_entity ros_gz_interfaces/srv/SpawnEntity \
    "{entity_factory: {name: '$1', allow_renaming: false, relative_to: 'wrc_container_a', \
      sdf: '<sdf version=\"1.7\"><model name=\"$1\"><include><uri>model://$2</uri><name>$2</name></include></model></sdf>', \
      pose: {position: {x: 0.0, y: 0.0, z: 0.2}, orientation: {x: $3, y: $4, z: $5, w: $6}}}}"
}

# roll -1.57  -> quaternion (-0.7068, 0, 0, 0.7074)
# pitch -1.57 -> quaternion (0, -0.7068, 0, 0.7074)
respawn task1_tool_ycb_040_large_marker_1 ycb_040_large_marker -0.7068 0.0 0.0 0.7074
respawn task1_kitchenitem_ycb_030_fork_1  ycb_030_fork          0.0 -0.7068 0.0 0.7074
respawn task1_kitchenitem_ycb_031_spoon_1 ycb_031_spoon        -0.7068 0.0 0.0 0.7074
