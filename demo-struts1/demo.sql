CREATE TABLE IF NOT EXISTS task (
	id BIGINT NOT NULL AUTO_INCREMENT,
	task_title VARCHAR(100) NOT NULL,
	assignee VARCHAR(50) NOT NULL,
	category VARCHAR(50) NOT NULL,
	priority INT NOT NULL,
	status VARCHAR(20) NOT NULL,
	 PRIMARY KEY ( id )
);

INSERT INTO `task` (`task_title`,`assignee`,`category`,`priority`,`status`) VALUES
('プロジェクト提案書を作成','田中','仕事',85,'進行中'),
('週次レポートを提出','佐藤','仕事',70,'未着手'),
('クライアントミーティング準備','鈴木','仕事',90,'進行中'),
('新機能の設計書レビュー','山田','仕事',75,'完了'),
('英語の勉強','田中','勉強',50,'未着手'),
('ジムに行く','佐藤','個人',40,'未着手'),
('食材を買う','鈴木','買い物',60,'未着手'),
('部屋の掃除','山田','家事',45,'進行中'),
('確定申告の準備','田中','個人',95,'未着手'),
('友人の誕生日プレゼント購入','佐藤','買い物',55,'完了'),
('車の点検予約','鈴木','個人',65,'未着手'),
('読書（ビジネス書）','山田','勉強',35,'進行中'),
('洗濯','田中','家事',30,'完了'),
('データベース最適化','佐藤','仕事',80,'進行中'),
('チームビルディングイベント企画','鈴木','仕事',50,'未着手');

CREATE TABLE IF NOT EXISTS `user` (
  `id` varchar(100) NOT NULL,
  `email` varchar(300) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `full_name` varchar(250) DEFAULT NULL,
  `is_enable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_un_email` (`email`),
  UNIQUE KEY `User_un_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `user`
(id,email, username, password, full_name, is_enable,created)
VALUES('9afb2853-7e37-498f-a7f5-08199e3964f6','test1@gmail.com', 'demo_test1', '$2a$10$/DlV8jJGrPXqDeoFNi.IDOwpLGkHh1QicjhIvwpInCJMWv.SpfrRy', 'Demo Test1', 1, NOW());