#!/usr/bin/env roseus

;; kobuki_msg::BumperEvent型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

;; ros::initする
(ros::roseus "button_subscriber")

;; コールバック関数を定義する
(defun button-cb (msg) (format t ";; button ~A is pressed!!~%" (send msg :button)))
(ros::subscribe
 "/mobile_base/events/button" ;; subscribeしたいtopicの名前
 kobuki_msgs::ButtonEvent;; subscribeしたいtopicの型
 #'button-cb ;; コールバック関数
 )

;; メインループ
(ros::rate 100) ;; 100[Hz]
(do-until-key
 (ros::spin-once)
 (ros::sleep)
 )
