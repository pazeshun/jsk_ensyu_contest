#!/usr/bin/env roseus

;; kobuki_msg::BumperEvent型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

(load "package://dxl_armed_turtlebot/euslisp/dxl-armed-turtlebot-interface.l")
(dxl-armed-turtlebot-init)

;; ros::initする
(ros::roseus "make-action")

(setq motor_id 0)
;; コールバック関数を定義する
(defun button-cb (msg)
  (cond ((= (send msg :button) 0)
	 (setq motor_id (+ motor_id 1))
	 (if (> motor_id 5)
	     (setq motor_id 0))
	 (print motor_id))
	((= (send msg :button) 1)
	 (setq np (send *dxl-armed-turtlebot* :angle-vector))
	 (setf (elt np motor_id) (- (elt np motor_id) 5))
	 (send *dxl-armed-turtlebot* :angle-vector np)
	 (print (send *dxl-armed-turtlebot* :angle-vector))
	 (send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 500)
	 (send *ri* :wait-interpolation))
	(t
	 (setq np (send *dxl-armed-turtlebot* :angle-vector))
	 (setf (elt np motor_id) (+ (elt np motor_id) 5))
	 (send *dxl-armed-turtlebot* :angle-vector np)
	 (print (send *dxl-armed-turtlebot* :angle-vector))
	 (send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 500)
	 (send *ri* :wait-interpolation))
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
 (ros::sleep)
 )
 

