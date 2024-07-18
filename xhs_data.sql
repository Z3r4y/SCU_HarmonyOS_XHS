-- 使用数据库
USE xhs;

-- 删除现有的表（如果存在）
DROP TABLE IF EXISTS history;
DROP TABLE IF EXISTS suggestions;
DROP TABLE IF EXISTS hottopics;
DROP TABLE IF EXISTS items;

-- 创建 history 表
CREATE TABLE IF NOT EXISTS history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(255) NOT NULL
);

-- 插入数据到 history 表
INSERT INTO history (content) VALUES
('川大'),
('川大网安'),
('Z3r4y'),
('恋爱');

-- 创建 suggestions 表
CREATE TABLE IF NOT EXISTS suggestions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    suggestion VARCHAR(255) NOT NULL
);

-- 插入数据到 suggestions 表
INSERT INTO suggestions (suggestion) VALUES
('川大军训'),
('卡地亚TRINITY'),
('川大录取通知书'),
('情侣升温情话'),
('情侣见面小花束'),
('茉莉花的花语');

-- 创建 hottopics 表
CREATE TABLE IF NOT EXISTS hottopics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `rank` INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    views VARCHAR(255) NOT NULL,
    isHot BOOLEAN
);

-- 插入数据到 hottopics 表
INSERT INTO hottopics (`rank`, title, views, isHot) VALUES
(1, '27岁硕导迎来26岁开门弟子', '1100.0w', TRUE),
(2, '她自律得不像是大学生', '856.4w', FALSE),
(3, '现实版海绵宝宝上班', '803.3w', TRUE),
(4, '蓝盈莹的精神内核好强大', '774.6w', FALSE),
(5, '狗皮膏药还得狗狗来撕', '769.4w', FALSE),
(6, '成熟的打戏已经进化到绿幕直出了', '652.3w', FALSE),
(7, '长相思的特效有点太抽象了', '621.7w', TRUE),
(8, '最近流行去吐鲁番法湿气', '557.5w', TRUE),
(9, '电影抓娃娃真人版点读机上线', '555.1w', FALSE);

-- 创建 items 表
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item VARCHAR(255) NOT NULL
);

-- 插入数据到 items 表
INSERT INTO items (item) VALUES
('川大军训'),
('卡地亚TRINITY'),
('川大录取通知书'),
('情侣升温情话'),
('情侣见面小花束'),
('茉莉花的花语'),
('川大网安');
