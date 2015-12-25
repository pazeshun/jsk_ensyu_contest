# jsk_ensyu_contest

## Usage
このリポジトリの中にあるturtlebot_testパッケージを~/catkin_ws/srcの下に移し、
```
$ roslaunch dxl_armed_turtlebot dxl_armed_turtlebot_bringup.launch
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
