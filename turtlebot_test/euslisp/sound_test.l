#!/usr/bin/env roseus

;; kobuki_msg::BumperEvent型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

;; ros::initする
(ros::roseus "sound_publisher")

;; publishするtopicのadvertise
(ros::advertise
 "/mobile_base/commands/sound" ;; publishしたいtopic名
 kobuki_msgs::Sound ;; publishしたいtopicの型
 1)

;; メインループ
(ros::rate 1)
(setq *sound-count* 0)
(while (ros::ok)
  ;; soundのtopicを
  (let ((msg (instance kobuki_msgs::Sound :init :value *sound-count*)))
    (ros::ros-info "kobuki sound [~A]" (send msg :value))
    (ros::publish "/mobile_base/commands/sound" msg)) ;; publishする
  (ros::sleep)
  (incf *sound-count*)
  (if (> *sound-count* 6) (setq *sound-count* 0))
  )
(exit)
