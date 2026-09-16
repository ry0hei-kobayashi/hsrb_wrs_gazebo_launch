# Copyright (c) 2019, Toyota Motor Corporation
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of Toyota Motor Corporation nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
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
"""WRS2020 practice field #1 (seed=2, full number of objects).

Thin wrapper around tmc_wrs_gazebo_launch/launch/include/wrs_common.launch.py.
Any other argument of wrs_common.launch.py (fast_physics, highrtf, with_handle,
rviz, use_navigation, use_joy_node, ...) can be passed through on the command line.
"""

import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration


def generate_launch_description():
    wrs_common_path = os.path.join(
        get_package_share_directory("tmc_wrs_gazebo_launch"),
        "launch", "include", "wrs_common.launch.py",
    )

    declared_arguments = [
        DeclareLaunchArgument("seed", default_value="2"),
        DeclareLaunchArgument("per_category", default_value="6"),
        DeclareLaunchArgument("obstacles", default_value="4"),
        DeclareLaunchArgument("per_row", default_value="6"),
    ]

    return LaunchDescription(declared_arguments + [
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(wrs_common_path),
            launch_arguments={
                "seed": LaunchConfiguration("seed"),
                "per_category": LaunchConfiguration("per_category"),
                "obstacles": LaunchConfiguration("obstacles"),
                "per_row": LaunchConfiguration("per_row"),
            }.items(),
        ),
    ])
