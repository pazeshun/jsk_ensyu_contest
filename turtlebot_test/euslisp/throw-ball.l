#!/usr/bin/env roseus

;; kobuki_msg::BumperEvent型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

(load "package://dxl_armed_turtlebot/euslisp/dxl-armed-turtlebot-interface.l")
(dxl-armed-turtlebot-init)

;; ros::initする
(ros::roseus "make-action")

(setq motor_id 0)
(setq start_motion 0)
;; コールバック関数を定義する
(defun button-cb (msg)
  (cond ((= (send msg :button) 0)
	 (send *ri* :start-grasp))
	((= (send msg :button) 1)
	 (setq start_motion 1))
	(t)
	))
(ros::subscribe
 "/mobile_base/events/button" ;; subscribeしたいtopicの名前
 kobuki_msgs::ButtonEvent;; subscribeしたいtopicの型
 #'button-cb ;; コールバック関数
 )

(ros::rate 5)
(send *dxl-armed-turtlebot* :init-pose)
(send *irtviewer* :draw-objects)
(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 4000)
(send *ri* :wait-interpolation)
(send *dxl-armed-turtlebot* :gripper :arm :angle-vector #f(50))
(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 1000 :gipper-controller)
(send *ri* :wait-interpolation :gripper-controller)
(do-until-key
 (ros::spin-once)
 (if (= start_motion 1)
     (progn
	(setq np (send *dxl-armed-turtlebot* :angle-vector))
	(setf (elt np 2) -55.0)
	(setf (elt np 4) -65.0)
	(setf (elt np 5) 90.0)
	(send *dxl-armed-turtlebot* :angle-vector np)
	(print (send *dxl-armed-turtlebot* :angle-vector))
	(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 2000)
	(send *ri* :wait-interpolation)
	(setq np (send *dxl-armed-turtlebot* :angle-vector))
	(setf (elt np 4) 40.0)
	(send *dxl-armed-turtlebot* :angle-vector np)
	(print (send *dxl-armed-turtlebot* :angle-vector))
	(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 200)
	(ros::sleep)
	(send *ri* :stop-grasp)
	(send *ri* :wait-interpolation)
	))

 (ros::sleep)
 )
 

