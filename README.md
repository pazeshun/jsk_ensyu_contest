# jsk_ensyu_contest

## Usage
このリポジトリの中にあるturtlebot_testパッケージを~/catkin_ws/srcの下に移し、
```
$ roslaunch dxl_armed_turtlebot dxl_armed_turtlebot_bringup.launch
$ roslaunch roseus_tutorials checkerboard-detector.launch rect0_size_x:=0.025 rect0_size_y:=0.025 grid0_size_x:=5 grid0_size_y:=4 translation0:="0 0 0" image:=image_rect_mono group:=/camera/rgb frame_id:=camera_rgb_frame
$ roslaunch jsk_pcl_ros hsi_color_filter.launch DEFAULT_NAMESPACE:=/camera/depth_registered INPUT:=points h_min:=-108 h_max:=-92
```
のあと、
```
$ rosrun turtlebot_test turtlebot_bowling.l
```
または、
```
$ cd ~/catkin_ws/src/turtlebot_bowling/euslisp
$ roseus turtlebot_bowling.l
```
・・・で使えた気がする。
