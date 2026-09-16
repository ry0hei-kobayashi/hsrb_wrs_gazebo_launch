# This package has no tests
cmake_minimum_required(VERSION 3.8)
project(hsrb_wrs_gazebo_launch)

find_package(ament_cmake REQUIRED)

install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
