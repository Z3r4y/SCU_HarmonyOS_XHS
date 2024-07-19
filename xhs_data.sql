-- 使用数据库
USE xhs;

-- 删除现有的表（如果存在）
DROP TABLE IF EXISTS history;
DROP TABLE IF EXISTS suggestions;
DROP TABLE IF EXISTS hottopics;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS posts;

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

-- 创建 users 表
CREATE TABLE IF NOT EXISTS users (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(80) NOT NULL,
    user_number VARCHAR(20),
    description VARCHAR(255),
    following INT DEFAULT 0,
    followers INT DEFAULT 0,
    likes INT DEFAULT 0,
    userphone VARCHAR(20) NOT NULL,
    password VARCHAR(80) NOT NULL,
    token VARCHAR(255)
);

-- 插入初始数据到 users 表
INSERT INTO users (username, user_number, description, following, followers, likes, userphone, password, token) VALUES
('Z3r4y', '26346998143', '很酷的黑客', 2, 1, 0, '13851069604', '123456', 'dG9rZW4tMQ=='),
('admin', '26346998144', '管理员账号', 0, 0, 0, '15950231992', 'admin', 'dG9rZW4tMg==');


-- 创建 posts 表
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);


-- 插入数据到 posts 表
INSERT INTO posts (title, author, image_url) VALUES
('上了川大才知道，出去看世界如此简单', '小红书用户', 'http://124.222.136.33:1338/image/img1.jpg'),
('Windows为什么有两个命令行', '技术宅', 'http://124.222.136.33:1338/image/img2.jpg'),
('当狸花猫遇到橘猫', '猫奴小二', 'http://124.222.136.33:1338/image/img3.jpg'),
('江安河边有多美', '摄影师阿良', 'http://124.222.136.33:1338/image/img4.jpg'),
('成都已经进化到这种程度了吗。。。', '干饭人Yuki', 'http://124.222.136.33:1338/image/img5.jpg'),
('虎扑》男生发型锐评点赞加关注', '飞阳-济南男士发型师', 'http://124.222.136.33:1338/image/img6.jpg'),
('什么时候我看见计算机这些梗图才能不笑', '西元前', 'http://124.222.136.33:1338/image/img7.jpg'),
('最后几个小时了再看看椅子', '雷军', 'http://124.222.136.33:1338/image/img8.jpg'),
('结婚前vs结婚后的区别', '废柴士豆丝', 'http://124.222.136.33:1338/image/img9.jpg'),
('女生不好意思说但想让男朋友知道的事', '小可爱', 'http://124.222.136.33:1338/image/img10.jpg'),
('来摸小宠物', '喝点牛奶', 'http://124.222.136.33:1338/image/img11.jpg'),
('SCU/想知道宿舍的同学在干嘛', 'Kendo', 'http://124.222.136.33:1338/image/img12.jpg'),
('宝宝，你是一辆情绪稳定的拖车小猫', 'lucky酱', 'http://124.222.136.33:1338/image/img13.jpg'),
('情侣升温满满爱', 'T飞飞', 'http://124.222.136.33:1338/image/img14.jpg'),
('出发巴黎！二十天出差我的行李都装了什么', '王冰冰', 'http://124.222.136.33:1338/image/img15.jpg'),
('情侣互动升温游戏-情侣随机转盘', 'T飞飞', 'http://124.222.136.33:1338/image/img16.jpg'),
('小猪猪今日分享', '万岁今日挨打', 'http://124.222.136.33:1338/image/img17.jpg'),
('草 这就是我这辈子该做的事', '李乐一哈', 'http://124.222.136.33:1338/image/img18.jpg'),
('川大 | 我补药一身班味啊', '娜小A', 'http://124.222.136.33:1338/image/img19.jpg'),
('天秤座', '小小天秤座', 'http://124.222.136.33:1338/image/img20.jpg'),
('No.49 哄对象睡觉的睡前故事', 'Kendo', 'http://124.222.136.33:1338/image/img21.jpg'),
('全国高校保研率排行！川大排多少？', '大红门情报站', 'http://124.222.136.33:1338/image/img22.jpg'),
('little bunny', 'fal', 'http://124.222.136.33:1338/image/img23.jpg'),
('我最爱我女朋友辣', '粉粉小狗', 'http://124.222.136.33:1338/image/img24.jpg');
