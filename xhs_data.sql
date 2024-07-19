-- 使用数据库
USE xhs;

-- 删除现有的表（如果存在）
DROP TABLE IF EXISTS history;
DROP TABLE IF EXISTS suggestions;
DROP TABLE IF EXISTS hottopics;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS focus;
DROP TABLE IF EXISTS around;

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
INSERT INTO users (username, password, userphone, user_number, description, following, followers, likes, token) VALUES
('Z3r4y', '123456', '13851069604', '26346998143', '点击这里，填写简介', 2, 1, 0, 'token1'),
('admin', 'admin', '15950231992', '26346998144', '管理员账户', 0, 0, 0, 'token2');

-- 创建 posts 表
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(80) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);

-- 插入数据到 posts 表
INSERT INTO posts (title, author, image_url) VALUES
('上了川大才知道，出去看世界如此简单', '小红书用户', 'http://124.222.136.33:1338/image/post/img1.jpg'),
('Windows为什么有两个命令行', '技术宅', 'http://124.222.136.33:1338/image/post/img2.jpg'),
('当狸花猫遇到橘猫', '猫奴小二', 'http://124.222.136.33:1338/image/post/img3.jpg'),
('江安河边有多美', '摄影师阿良', 'http://124.222.136.33:1338/image/post/img4.jpg'),
('成都已经进化到这种程度了吗。。。', '干饭人Yuki', 'http://124.222.136.33:1338/image/post/img5.jpg'),
('虎扑》男生发型锐评点赞加关注', '飞阳-济南男士发型师', 'http://124.222.136.33:1338/image/post/img6.jpg'),
('什么时候我看见计算机这些梗图才能不笑', '西元前', 'http://124.222.136.33:1338/image/post/img7.jpg'),
('最后几个小时了再看看椅子', '雷军', 'http://124.222.136.33:1338/image/post/img8.jpg'),
('结婚前vs结婚后的区别', '废柴士豆丝', 'http://124.222.136.33:1338/image/post/img9.jpg'),
('女生不好意思说但想让男朋友知道的事', '小可爱', 'http://124.222.136.33:1338/image/post/img10.jpg'),
('来摸小宠物', '喝点牛奶', 'http://124.222.136.33:1338/image/post/img11.jpg'),
('SCU/想知道宿舍的同学在干嘛', 'Kendo', 'http://124.222.136.33:1338/image/post/img12.jpg'),
('宝宝，你是一辆情绪稳定的拖车小猫', 'lucky酱', 'http://124.222.136.33:1338/image/post/img13.jpg'),
('情侣升温满满爱', 'T飞飞', 'http://124.222.136.33:1338/image/post/img14.jpg'),
('出发巴黎！二十天出差我的行李都装了什么', '王冰冰', 'http://124.222.136.33:1338/image/post/img15.jpg'),
('情侣互动升温游戏-情侣随机转盘', 'T飞飞', 'http://124.222.136.33:1338/image/post/img16.jpg'),
('小猪猪今日分享', '万岁今日挨打', 'http://124.222.136.33:1338/image/post/img17.jpg'),
('草 这就是我这辈子该做的事', '李乐一哈', 'http://124.222.136.33:1338/image/post/img18.jpg'),
('川大 | 我补药一身班味啊', '娜小A', 'http://124.222.136.33:1338/image/post/img19.jpg'),
('天秤座', '小小天秤座', 'http://124.222.136.33:1338/image/post/img20.jpg'),
('No.49 哄对象睡觉的睡前故事', 'Kendo', 'http://124.222.136.33:1338/image/post/img21.jpg'),
('全国高校保研率排行！川大排多少？', '大红门情报站', 'http://124.222.136.33:1338/image/post/img22.jpg'),
('little bunny', 'fal', 'http://124.222.136.33:1338/image/post/img23.jpg'),
('我最爱我女朋友辣', '粉粉小狗', 'http://124.222.136.33:1338/image/post/img24.jpg');

-- 创建 focus 表
CREATE TABLE IF NOT EXISTS focus (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(80) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);

-- 插入数据到 focus 表
INSERT INTO focus (title, author, image_url) VALUES
('存一些28岁日常打工瞬间', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img1.jpg'),
('拉回到毕业那年', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img2.jpg'),
('邪恶美短小虎斑', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img3.jpg'),
('成都代官山去了', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img4.jpg'),
('职场瞬间 | 外企人的出差日常', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img5.jpg'),
('这个夏天还是翻出这条长裙', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img6.jpg'),
('Define和打工也很配', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img7.jpg'),
('成都周末出发 开花洼羊之子雪山', '酒酿Chuchu', 'http://124.222.136.33:1338/image/focus/img8.jpg'),
('年年胜意，岁岁欢喜', 'lxy', 'http://124.222.136.33:1338/image/focus/img9.jpg'),
('烤得滋滋冒油太香了！', 'lxy', 'http://124.222.136.33:1338/image/focus/img10.jpg'),
('SCU今天也有打球！', 'lxy', 'http://124.222.136.33:1338/image/focus/img11.jpg'),
('五一没有出去变', 'lxy', 'http://124.222.136.33:1338/image/focus/img12.jpg'),
('成都win！第一场羽球大赛事-汤尤杯', 'lxy', 'http://124.222.136.33:1338/image/focus/img13.jpg');

-- 创建 around 表
CREATE TABLE IF NOT EXISTS around (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(80) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);

-- 插入数据到 around 表
INSERT INTO around (title, author, image_url) VALUES
('小狗不想一个人在成都', 'Brd_xxx', 'http://124.222.136.33:1338/image/around/img1.jpg'),
('川大江安抹茶河', '越南河内美食家', 'http://124.222.136.33:1338/image/around/img2.jpg'),
('吃吃喝喝 求成都搭子 dd', 'mofayyyy', 'http://124.222.136.33:1338/image/around/img3.jpg'),
('成都', '小红书用户', 'http://124.222.136.33:1338/image/around/img4.jpg'),
('成都有没有180+的专一小帅跟我谈恋爱', '小佳佳', 'http://124.222.136.33:1338/image/around/img5.jpg'),
('190在四川太高了', '贝壳依旧', 'http://124.222.136.33:1338/image/around/img6.jpg'),
('成都适合一个人闲逛的100个地方(99/100)', '白杨', 'http://124.222.136.33:1338/image/around/img7.jpg'),
('成都三元地铁站！向日葵花海已开爆！', '沉 珍_', 'http://124.222.136.33:1338/image/around/img8.jpg'),
('成都健身房暑假工 底薪3200提成另算', '嗯呢', 'http://124.222.136.33:1338/image/around/img9.jpg'),
('成都双流区找各种搭子', '川大美食小哥哥', 'http://124.222.136.33:1338/image/around/img10.jpg'),
('推荐一下我考研经常去的图书馆', '小秋', 'http://124.222.136.33:1338/image/around/img11.jpg'),
('你们川大学姐终于把酒吧开到校门口了', 'Bar SOS', 'http://124.222.136.33:1338/image/around/img12.jpg'),
('很脏！生理上的反映永远是最真实的...', '莫奇', 'http://124.222.136.33:1338/image/around/img13.jpg'),
('成都双。。。三子塔！', 'ttaipov', 'http://124.222.136.33:1338/image/around/img14.jpg'),
('老婆说我拍的不如路人偷拍', 'Mr.Tang', 'http://124.222.136.33:1338/image/around/img15.jpg'),
('川大江安炒菜馆合集', '高贵的豌豆', 'http://124.222.136.33:1338/image/around/img16.jpg');
