#!/usr/bin/env roseus

;; kobuki_msg::BumperEvent型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

(load "package://dxl_armed_turtlebot/euslisp/dxl-armed-turtlebot-interface.l")
(dxl-armed-turtlebot-init)

;; ros::initする
(ros::roseus "arm_and_sensor")

;; コールバック関数を定義する
(defun button-cb (msg)
  (cond ((= (send msg :button) 0)
	 (send *ri* :start-grasp))
	((= (send msg :button) 1)
	 (send *ri* :stop-grasp))
	(t
	 (setq np (send *dxl-armed-turtlebot* :angle-vector))
	 (setf (elt np 2) (+ (elt np 2) 10))
	 (send *dxl-armed-turtlebot* :angle-vector np)
	 (send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 2000)
	 (send *ri* :wait-interpolation))
	))
(ros::subscribe
 "/mobile_base/events/button" ;; subscribeしたいtopicの名前
 kobuki_msgs::ButtonEvent;; subscribeしたいtopicの型
 #'button-cb ;; コールバック関数
 )

(ros::rate 100)
(send *dxl-armed-turtlebot* :init-pose)
(send *irtviewer* :draw-objects)
(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 4000)
(send *ri* :wait-interpolation)
(send *dxl-armed-turtlebot* :gripper :arm :angle-vector #f(50))
(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 1000 :gipper-controller)
(send *ri* :wait-interpolation :gripper-controller)
(do-until-key
 (ros::spin-once)
 (ros::sleep)
 )
 

