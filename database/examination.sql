/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : examination

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 05/03/2024 17:02:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '手机号（用作账号）',
  `password` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `role_id` int NOT NULL COMMENT '角色id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (3, '李佳晨', '13928483978', '123456', 1, '2024-01-12 18:12:30');
INSERT INTO `admin` VALUES (4, '赵云贵', '13749828594', '135246', 1, '2024-01-10 12:31:44');
INSERT INTO `admin` VALUES (5, '王丽', '17849820543', '123123', 1, '2024-01-11 13:48:34');
INSERT INTO `admin` VALUES (6, '孙思蕊', '16738749385', '142536', 1, '2024-01-11 13:48:34');
INSERT INTO `admin` VALUES (7, '王富贵', '17839842654', '346456', 1, '2024-01-18 15:05:02');
INSERT INTO `admin` VALUES (16, '王绥', '17836728473', '135246', 1, '2024-01-18 19:07:41');
INSERT INTO `admin` VALUES (58, '王德法', '17839826473', '135267', 1, '2024-01-18 19:32:19');
INSERT INTO `admin` VALUES (59, '武广', '17842626473', '135267', 1, '2024-01-18 19:33:29');
INSERT INTO `admin` VALUES (60, '崔荟', '17839824325', '111111', 1, '2024-01-18 01:35:05');
INSERT INTO `admin` VALUES (61, '李存', '17839827384', '123123', 1, '2024-01-18 01:35:44');
INSERT INTO `admin` VALUES (62, '吴语', '17893827342', '123123', 1, '2024-01-18 01:46:32');
INSERT INTO `admin` VALUES (64, '医生一', '16728736455', '111111', 1, '2024-01-18 02:28:40');
INSERT INTO `admin` VALUES (66, '河汉清', '16738728394', '123123', 19, '2024-01-18 02:45:43');
INSERT INTO `admin` VALUES (67, '王主任', '16738723412', '123123', 20, '2024-01-18 02:54:20');
INSERT INTO `admin` VALUES (68, '王波', '17839827394', '111111', 21, '2024-01-18 09:53:18');
INSERT INTO `admin` VALUES (69, '伍慕庭', '13472413472', '123456', 1, '2024-01-18 19:16:21');
INSERT INTO `admin` VALUES (72, '心血管内科一号机', '11111111111', '123456', 22, '2024-01-18 11:15:59');
INSERT INTO `admin` VALUES (73, '血液内科一号机', '11111111111', '123456', 24, '2024-01-18 18:10:05');
INSERT INTO `admin` VALUES (74, '测试姓名', '14532038606', '123456', 30, '2024-01-25 21:25:33');

-- ----------------------------
-- Table structure for assignment
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL COMMENT '项目分类id',
  `order_id` int NOT NULL COMMENT '订单id',
  `doctor_id` int NULL DEFAULT NULL COMMENT '医生id',
  `status` smallint NOT NULL COMMENT '0-待检查 1-已完成',
  `is_extra` tinyint(1) NOT NULL COMMENT '是否为增检项目',
  `create_time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `assignment_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `examination_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 282 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of assignment
-- ----------------------------
INSERT INTO `assignment` VALUES (206, 2, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (207, 7, 2, 3, 1, 0, NULL);
INSERT INTO `assignment` VALUES (208, 5, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (209, 4, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (210, 9, 2, 3, 1, 0, NULL);
INSERT INTO `assignment` VALUES (211, 12, 2, 3, 1, 0, NULL);
INSERT INTO `assignment` VALUES (212, 13, 2, 3, 1, 0, NULL);
INSERT INTO `assignment` VALUES (213, 14, 2, 3, 1, 0, NULL);
INSERT INTO `assignment` VALUES (214, 8, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (216, 11, 2, 3, 1, 0, NULL);
INSERT INTO `assignment` VALUES (217, 1, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (218, 3, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (219, 6, 2, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (220, 9, 1, NULL, 0, 1, NULL);
INSERT INTO `assignment` VALUES (221, 6, 1, NULL, 0, 1, NULL);
INSERT INTO `assignment` VALUES (223, 1, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (224, 2, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (225, 3, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (226, 4, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (227, 5, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (228, 6, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (229, 7, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (230, 8, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (231, 9, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (233, 11, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (234, 12, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (235, 13, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (236, 14, 9, NULL, 0, 0, NULL);
INSERT INTO `assignment` VALUES (237, 1, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (238, 2, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (239, 3, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (240, 4, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (241, 5, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (242, 6, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (243, 7, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (244, 8, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (245, 9, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (247, 11, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (248, 12, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (249, 13, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (250, 14, 25, 3, 1, 0, '2024-02-29 20:40:44.285');
INSERT INTO `assignment` VALUES (251, 2, 26, 3, 1, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (252, 3, 26, 3, 1, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (253, 4, 26, 3, 1, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (254, 5, 26, 3, 1, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (255, 7, 26, 3, 1, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (256, 9, 26, 3, 1, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (257, 10, 26, NULL, 0, 0, '2024-03-03 21:24:10.481');
INSERT INTO `assignment` VALUES (258, 2, 27, 3, 1, 0, '2024-03-04 15:56:22.478');
INSERT INTO `assignment` VALUES (259, 3, 27, 3, 1, 0, '2024-03-04 15:56:22.478');
INSERT INTO `assignment` VALUES (260, 4, 27, 3, 1, 0, '2024-03-04 15:56:22.478');
INSERT INTO `assignment` VALUES (261, 5, 27, 3, 1, 0, '2024-03-04 15:56:22.478');
INSERT INTO `assignment` VALUES (262, 7, 27, 3, 1, 0, '2024-03-04 15:56:22.478');
INSERT INTO `assignment` VALUES (263, 9, 27, 3, 1, 0, '2024-03-04 15:56:22.478');
INSERT INTO `assignment` VALUES (264, 1, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (265, 2, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (266, 3, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (267, 4, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (268, 5, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (269, 6, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (270, 8, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (271, 9, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (272, 11, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (273, 12, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (274, 13, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (275, 14, 28, 3, 1, 0, '2024-03-05 16:00:43.532');
INSERT INTO `assignment` VALUES (276, 2, 29, 3, 1, 0, '2024-03-05 16:58:33.466');
INSERT INTO `assignment` VALUES (277, 3, 29, 3, 1, 0, '2024-03-05 16:58:33.466');
INSERT INTO `assignment` VALUES (278, 4, 29, 3, 1, 0, '2024-03-05 16:58:33.466');
INSERT INTO `assignment` VALUES (279, 5, 29, 3, 1, 0, '2024-03-05 16:58:33.466');
INSERT INTO `assignment` VALUES (280, 7, 29, 3, 1, 0, '2024-03-05 16:58:33.466');
INSERT INTO `assignment` VALUES (281, 9, 29, 3, 1, 0, '2024-03-05 16:58:33.466');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '项目分类名称',
  `package_id` int NOT NULL COMMENT '套餐id',
  `average_duration` float NULL DEFAULT NULL COMMENT '该大项目平均检查时间',
  `price` smallint NULL DEFAULT NULL COMMENT '该大项目的价格',
  `department_id` int NOT NULL COMMENT '科室id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `package_id`(`package_id` ASC) USING BTREE,
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `category_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '一般检查', 1, 90, NULL, 25);
INSERT INTO `category` VALUES (2, '内科检查', 1, 90, NULL, 10);
INSERT INTO `category` VALUES (3, '外科检查', 1, 90, NULL, 19);
INSERT INTO `category` VALUES (4, '心电图', 1, 90, NULL, 9);
INSERT INTO `category` VALUES (5, '耳鼻喉检查', 1, 120, NULL, 17);
INSERT INTO `category` VALUES (6, '肝胆脾胰彩超', 1, 180, NULL, 24);
INSERT INTO `category` VALUES (7, '眼科检查', 1, 180, NULL, 16);
INSERT INTO `category` VALUES (8, '甲状腺超声', 1, 30, NULL, 24);
INSERT INTO `category` VALUES (9, '血常规', 1, 240, NULL, 14);
INSERT INTO `category` VALUES (10, '尿常规', 1, NULL, NULL, 21);
INSERT INTO `category` VALUES (11, '肾功能', 1, NULL, NULL, 14);
INSERT INTO `category` VALUES (12, '糖化血红蛋白', 1, NULL, NULL, 14);
INSERT INTO `category` VALUES (13, '空腹血糖', 1, NULL, NULL, 14);
INSERT INTO `category` VALUES (14, '肿瘤12项', 1, NULL, NULL, 14);
INSERT INTO `category` VALUES (15, '多喝热水', 1, NULL, NULL, 1);

-- ----------------------------
-- Table structure for center_package
-- ----------------------------
DROP TABLE IF EXISTS `center_package`;
CREATE TABLE `center_package`  (
  `id` int NOT NULL,
  `center_id` int NOT NULL COMMENT '体检机构id',
  `package_id` int NOT NULL COMMENT '套餐id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `center_package_ibfk1`(`center_id` ASC) USING BTREE,
  INDEX `center_package_ibfk2`(`package_id` ASC) USING BTREE,
  CONSTRAINT `center_package_ibfk1` FOREIGN KEY (`center_id`) REFERENCES `examination_center` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `center_package_ibfk2` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of center_package
-- ----------------------------
INSERT INTO `center_package` VALUES (1, 1, 1);
INSERT INTO `center_package` VALUES (2, 1, 4);
INSERT INTO `center_package` VALUES (3, 1, 5);
INSERT INTO `center_package` VALUES (4, 1, 6);
INSERT INTO `center_package` VALUES (5, 1, 7);
INSERT INTO `center_package` VALUES (6, 2, 1);
INSERT INTO `center_package` VALUES (7, 2, 4);
INSERT INTO `center_package` VALUES (8, 2, 5);
INSERT INTO `center_package` VALUES (9, 2, 6);
INSERT INTO `center_package` VALUES (10, 2, 7);
INSERT INTO `center_package` VALUES (11, 3, 6);
INSERT INTO `center_package` VALUES (12, 4, 5);
INSERT INTO `center_package` VALUES (13, 5, 6);
INSERT INTO `center_package` VALUES (14, 6, 6);
INSERT INTO `center_package` VALUES (15, 7, 1);
INSERT INTO `center_package` VALUES (16, 8, 5);
INSERT INTO `center_package` VALUES (17, 9, 5);

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '科室名称',
  `parent_id` int NOT NULL COMMENT '父级科室id',
  `level` smallint NOT NULL COMMENT '科室等级',
  `is_full` tinyint(1) NULL DEFAULT NULL COMMENT '是否已满',
  `queue_length` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '医院', 0, 0, NULL, 0);
INSERT INTO `department` VALUES (2, '内科学', 1, 1, NULL, 0);
INSERT INTO `department` VALUES (3, '外科学', 1, 1, NULL, 0);
INSERT INTO `department` VALUES (4, '医学影像学', 1, 1, NULL, 0);
INSERT INTO `department` VALUES (5, '其它科室', 1, 1, NULL, 0);
INSERT INTO `department` VALUES (6, '呼吸内科', 2, 2, NULL, 0);
INSERT INTO `department` VALUES (7, '消化内科', 2, 2, NULL, 0);
INSERT INTO `department` VALUES (8, '儿科', 2, 2, NULL, 0);
INSERT INTO `department` VALUES (9, '心血管内科', 2, 2, NULL, -240);
INSERT INTO `department` VALUES (10, '神经内科', 2, 2, NULL, -90);
INSERT INTO `department` VALUES (11, '内分泌科', 2, 2, NULL, 0);
INSERT INTO `department` VALUES (12, '肿瘤科', 2, 2, NULL, 0);
INSERT INTO `department` VALUES (13, '肾脏内科', 2, 2, NULL, 0);
INSERT INTO `department` VALUES (14, '血液内科', 2, 2, NULL, 360);
INSERT INTO `department` VALUES (15, '口腔科', 3, 2, NULL, 0);
INSERT INTO `department` VALUES (16, '眼科', 3, 2, NULL, -810);
INSERT INTO `department` VALUES (17, '耳鼻喉科', 3, 2, NULL, -120);
INSERT INTO `department` VALUES (18, '妇科', 3, 2, NULL, 0);
INSERT INTO `department` VALUES (19, '普外科', 3, 2, NULL, -120);
INSERT INTO `department` VALUES (20, '骨科', 3, 2, NULL, 0);
INSERT INTO `department` VALUES (21, '泌尿外科', 3, 2, NULL, 0);
INSERT INTO `department` VALUES (22, '乳腺外科', 3, 2, NULL, 0);
INSERT INTO `department` VALUES (23, '放射科', 4, 2, NULL, 0);
INSERT INTO `department` VALUES (24, '超声科', 4, 2, NULL, -60);
INSERT INTO `department` VALUES (25, '体检科', 5, 2, NULL, -60);

-- ----------------------------
-- Table structure for department_doctor
-- ----------------------------
DROP TABLE IF EXISTS `department_doctor`;
CREATE TABLE `department_doctor`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL COMMENT '科室id',
  `administer_id` int NOT NULL COMMENT '医生的用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `administer_id`(`administer_id` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  CONSTRAINT `department_doctor_ibfk_1` FOREIGN KEY (`administer_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `department_doctor_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department_doctor
-- ----------------------------
INSERT INTO `department_doctor` VALUES (1, 6, 64);

-- ----------------------------
-- Table structure for district
-- ----------------------------
DROP TABLE IF EXISTS `district`;
CREATE TABLE `district`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '区县名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of district
-- ----------------------------
INSERT INTO `district` VALUES (1, '南开区');
INSERT INTO `district` VALUES (2, '河西区');
INSERT INTO `district` VALUES (3, '河东区');
INSERT INTO `district` VALUES (4, '和平区');
INSERT INTO `district` VALUES (5, '河北区');
INSERT INTO `district` VALUES (6, '北辰区');
INSERT INTO `district` VALUES (7, '西青区');
INSERT INTO `district` VALUES (8, '红桥区');
INSERT INTO `district` VALUES (9, '武清区');
INSERT INTO `district` VALUES (10, '东丽区');
INSERT INTO `district` VALUES (11, '津南区');
INSERT INTO `district` VALUES (12, '滨海新区');
INSERT INTO `district` VALUES (13, '宝坻区');
INSERT INTO `district` VALUES (14, '蓟州区');

-- ----------------------------
-- Table structure for doctor_status
-- ----------------------------
DROP TABLE IF EXISTS `doctor_status`;
CREATE TABLE `doctor_status`  (
  `id` int NOT NULL,
  `doctor_id` int NOT NULL COMMENT '等同于admin_id',
  `is_busy` tinyint(1) NOT NULL COMMENT '是否忙碌（正在检查）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  CONSTRAINT `doctor_status_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_status
-- ----------------------------
INSERT INTO `doctor_status` VALUES (1, 64, 1);

-- ----------------------------
-- Table structure for examination_center
-- ----------------------------
DROP TABLE IF EXISTS `examination_center`;
CREATE TABLE `examination_center`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(26) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '体检机构名称',
  `address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '地址',
  `nearby` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '最近的交通站点',
  `telephone` char(13) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '联系电话',
  `announcement` varchar(70) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '公告',
  `img_src` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '医院图片',
  `response_time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '响应时间\r\n响应时间',
  `consult_num` float NOT NULL COMMENT '咨询人数',
  `morning_limit` smallint NULL DEFAULT NULL COMMENT '上午体检人数限制',
  `afternoon_limit` smallint NULL DEFAULT NULL COMMENT '下午体检人数限制',
  `district_id` int NOT NULL COMMENT '区县id',
  `is_hot` int NOT NULL DEFAULT 1 COMMENT '是否热门 1热门 ',
  `price` decimal(10, 2) NOT NULL DEFAULT 666.00 COMMENT '价格',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `district_id`(`district_id` ASC) USING BTREE,
  CONSTRAINT `examination_center_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examination_center
-- ----------------------------
INSERT INTO `examination_center` VALUES (1, '天津市南开医院体检中心', '长江道6号', '地铁11号线', '62543212', '提前一天预约', 'NanKai.jpg', '2分56秒', 123, 24, 13, 1, 1, 333.00);
INSERT INTO `examination_center` VALUES (2, '天津市黄河医院体检中心', '黄河道42号', '地铁6号线', '12345678', '当天8:30前预约', 'HuangHe.png', '5分56秒', 123, 24, 13, 1, 1, 626.00);
INSERT INTO `examination_center` VALUES (3, '天津华苑民众体检中心', '榕苑路2号', '地铁3号线', '12345678', '当天8:30前预约', 'MinZhong.png', '10分56秒', 123, 24, 13, 1, 0, 686.00);
INSERT INTO `examination_center` VALUES (4, '天津二七二医院体检中心', '多伦道182号', '地铁1号线', '12345678', '当天7:30前预约', 'ErQiEr.jpg', '6分56秒', 123, 24, 13, 4, 1, 888.00);
INSERT INTO `examination_center` VALUES (5, '天津九华体检中心', '津湾广场6号', '地铁5号线', '12345678', '提前1天预约', 'JiuHua.jpg', '2分56秒', 123, 24, 13, 4, 0, 236.00);
INSERT INTO `examination_center` VALUES (6, '天津美年大健康体检中心', '曲阜道38号', '地铁4号线', '12345678', '提前3天预约', 'MeiNian.jpg', '9分56秒', 123, 24, 13, 4, 0, 645.00);
INSERT INTO `examination_center` VALUES (7, '天津市第四中心医院体检中心', '中山路3号', '地铁5号线', '12345678', '当天8:00前预约', 'DiSi.jpg', '2分59秒', 123, 24, 13, 5, 0, 555.00);
INSERT INTO `examination_center` VALUES (8, '天津市第二医院体检中心', '正义道10号', '地铁7号线', '12345678', '当天7:00前预约', 'DiEr.jpg', '2分33秒', 123, 24, 13, 5, 0, 777.00);
INSERT INTO `examination_center` VALUES (9, '天津市第一医院体检中心', '南口路186号', '地铁6号线', '12345678', '当天7:00前预约', 'DiYi.jpg', '2分56秒', 123, 24, 13, 5, 0, 666.00);

-- ----------------------------
-- Table structure for examination_order
-- ----------------------------
DROP TABLE IF EXISTS `examination_order`;
CREATE TABLE `examination_order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `examinee_id` int NOT NULL COMMENT '体检人id',
  `package_id` int NOT NULL COMMENT '套餐id',
  `status` smallint NOT NULL COMMENT '0-未体检 1-体检中 2-暂停中 3用餐中 4-已完成 5-已终止',
  `type` smallint NOT NULL COMMENT '0-团检 1-个人体检',
  `examine_date` date NOT NULL COMMENT '预约日期',
  `period` smallint NOT NULL COMMENT '0-上午 1-下午',
  `group_information_id` int NULL DEFAULT NULL COMMENT '关联团检信息表id',
  `center_id` int NOT NULL COMMENT '所选体检中心id',
  `phone` char(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `breakfast` smallint NULL DEFAULT 0 COMMENT '吃饭状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `center_id`(`center_id` ASC) USING BTREE,
  INDEX `examinee_id`(`examinee_id` ASC) USING BTREE,
  INDEX `group_information_id`(`group_information_id` ASC) USING BTREE,
  INDEX `package_id`(`package_id` ASC) USING BTREE,
  CONSTRAINT `examination_order_ibfk_1` FOREIGN KEY (`center_id`) REFERENCES `examination_center` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_order_ibfk_2` FOREIGN KEY (`examinee_id`) REFERENCES `examinee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_order_ibfk_3` FOREIGN KEY (`group_information_id`) REFERENCES `group_information` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_order_ibfk_4` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examination_order
-- ----------------------------
INSERT INTO `examination_order` VALUES (1, 1, 3, 3, 1, '2024-02-11', 0, NULL, 1, '18317035553', 0);
INSERT INTO `examination_order` VALUES (2, 2, 1, 5, 1, '2024-02-11', 0, NULL, 1, '13829223132', 0);
INSERT INTO `examination_order` VALUES (9, 1, 1, 1, 1, '2024-02-28', 0, NULL, 1, '13829223132', 0);
INSERT INTO `examination_order` VALUES (25, 2, 1, 5, 1, '2024-02-29', 0, NULL, 1, '13829223132', 0);
INSERT INTO `examination_order` VALUES (26, 1, 6, 1, 1, '2024-03-03', 0, NULL, 1, '18937829582', 0);
INSERT INTO `examination_order` VALUES (27, 2, 6, 5, 1, '2024-03-04', 0, NULL, 1, '13829223132', 0);
INSERT INTO `examination_order` VALUES (28, 7, 7, 5, 1, '2024-03-05', 0, NULL, 1, '13291625628', 0);
INSERT INTO `examination_order` VALUES (29, 8, 6, 5, 1, '2024-03-05', 0, NULL, 5, '13720999653', 0);

-- ----------------------------
-- Table structure for examination_result
-- ----------------------------
DROP TABLE IF EXISTS `examination_result`;
CREATE TABLE `examination_result`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `result_value` float NULL DEFAULT NULL COMMENT '数值型结果',
  `text_option_id` int NULL DEFAULT NULL COMMENT '文本型结果',
  `assignment_id` int NOT NULL COMMENT '委托id',
  `item_id` int NOT NULL COMMENT '体检项目id',
  `create_time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `assignment_id`(`assignment_id` ASC) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE,
  INDEX `text_option_id`(`text_option_id` ASC) USING BTREE,
  CONSTRAINT `examination_result_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_result_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_result_ibfk_3` FOREIGN KEY (`text_option_id`) REFERENCES `result_text_option` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 397 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examination_result
-- ----------------------------
INSERT INTO `examination_result` VALUES (1, 5.5, 2, 206, 10, NULL);
INSERT INTO `examination_result` VALUES (2, NULL, 2, 207, 11, NULL);
INSERT INTO `examination_result` VALUES (3, 0.362042, NULL, 210, 46, NULL);
INSERT INTO `examination_result` VALUES (4, 0.560208, NULL, 210, 47, NULL);
INSERT INTO `examination_result` VALUES (5, 0.800163, NULL, 210, 48, NULL);
INSERT INTO `examination_result` VALUES (6, 0.94074, NULL, 210, 49, NULL);
INSERT INTO `examination_result` VALUES (7, 0.683253, NULL, 210, 50, NULL);
INSERT INTO `examination_result` VALUES (8, 0.1277, NULL, 210, 51, NULL);
INSERT INTO `examination_result` VALUES (9, 0.708434, NULL, 210, 52, NULL);
INSERT INTO `examination_result` VALUES (10, 0.154371, NULL, 210, 53, NULL);
INSERT INTO `examination_result` VALUES (11, 0.827237, NULL, 210, 54, NULL);
INSERT INTO `examination_result` VALUES (12, 0.570998, NULL, 210, 55, NULL);
INSERT INTO `examination_result` VALUES (13, 0.484247, NULL, 210, 56, NULL);
INSERT INTO `examination_result` VALUES (14, 0.573186, NULL, 210, 57, NULL);
INSERT INTO `examination_result` VALUES (15, 0.240981, NULL, 210, 58, NULL);
INSERT INTO `examination_result` VALUES (16, 0.93789, NULL, 210, 59, NULL);
INSERT INTO `examination_result` VALUES (17, 0.0728485, NULL, 210, 60, NULL);
INSERT INTO `examination_result` VALUES (18, 0.55819, NULL, 210, 61, NULL);
INSERT INTO `examination_result` VALUES (19, 0.499972, NULL, 210, 62, NULL);
INSERT INTO `examination_result` VALUES (20, 0.399657, NULL, 210, 46, NULL);
INSERT INTO `examination_result` VALUES (21, 0.887822, NULL, 210, 47, NULL);
INSERT INTO `examination_result` VALUES (22, 0.717858, NULL, 210, 48, NULL);
INSERT INTO `examination_result` VALUES (23, 0.62393, NULL, 210, 49, NULL);
INSERT INTO `examination_result` VALUES (24, 0.109194, NULL, 210, 50, NULL);
INSERT INTO `examination_result` VALUES (25, 0.0974508, NULL, 210, 51, NULL);
INSERT INTO `examination_result` VALUES (26, 0.729188, NULL, 210, 52, NULL);
INSERT INTO `examination_result` VALUES (27, 0.797693, NULL, 210, 53, NULL);
INSERT INTO `examination_result` VALUES (28, 0.775213, NULL, 210, 54, NULL);
INSERT INTO `examination_result` VALUES (29, 0.465284, NULL, 210, 55, NULL);
INSERT INTO `examination_result` VALUES (30, 0.176948, NULL, 210, 56, NULL);
INSERT INTO `examination_result` VALUES (31, 0.545902, NULL, 210, 57, NULL);
INSERT INTO `examination_result` VALUES (32, 0.0734282, NULL, 210, 58, NULL);
INSERT INTO `examination_result` VALUES (33, 0.376831, NULL, 210, 59, NULL);
INSERT INTO `examination_result` VALUES (34, 0.149222, NULL, 210, 60, NULL);
INSERT INTO `examination_result` VALUES (35, 0.330495, NULL, 210, 61, NULL);
INSERT INTO `examination_result` VALUES (36, 0.0889997, NULL, 210, 62, NULL);
INSERT INTO `examination_result` VALUES (37, 0.139056, NULL, 212, 82, NULL);
INSERT INTO `examination_result` VALUES (38, 0.45067, NULL, 210, 46, NULL);
INSERT INTO `examination_result` VALUES (39, 0.159177, NULL, 210, 47, NULL);
INSERT INTO `examination_result` VALUES (40, 0.238505, NULL, 210, 48, NULL);
INSERT INTO `examination_result` VALUES (41, 0.690357, NULL, 210, 49, NULL);
INSERT INTO `examination_result` VALUES (42, 0.15269, NULL, 210, 50, NULL);
INSERT INTO `examination_result` VALUES (43, 0.373391, NULL, 210, 51, NULL);
INSERT INTO `examination_result` VALUES (44, 0.512685, NULL, 210, 52, NULL);
INSERT INTO `examination_result` VALUES (45, 0.450082, NULL, 210, 53, NULL);
INSERT INTO `examination_result` VALUES (46, 0.510906, NULL, 210, 54, NULL);
INSERT INTO `examination_result` VALUES (47, 0.0191328, NULL, 210, 55, NULL);
INSERT INTO `examination_result` VALUES (48, 0.975633, NULL, 210, 56, NULL);
INSERT INTO `examination_result` VALUES (49, 0.379343, NULL, 210, 57, NULL);
INSERT INTO `examination_result` VALUES (50, 0.0110458, NULL, 210, 58, NULL);
INSERT INTO `examination_result` VALUES (51, 0.669174, NULL, 210, 59, NULL);
INSERT INTO `examination_result` VALUES (52, 0.863612, NULL, 210, 60, NULL);
INSERT INTO `examination_result` VALUES (53, 0.762777, NULL, 210, 61, NULL);
INSERT INTO `examination_result` VALUES (54, 0.648272, NULL, 210, 62, NULL);
INSERT INTO `examination_result` VALUES (55, 0.222949, NULL, 207, 38, NULL);
INSERT INTO `examination_result` VALUES (56, 0.655243, NULL, 207, 39, NULL);
INSERT INTO `examination_result` VALUES (57, NULL, 12, 207, 2, NULL);
INSERT INTO `examination_result` VALUES (58, NULL, 12, 207, 3, NULL);
INSERT INTO `examination_result` VALUES (59, NULL, 12, 207, 4, NULL);
INSERT INTO `examination_result` VALUES (60, NULL, 12, 207, 5, NULL);
INSERT INTO `examination_result` VALUES (61, NULL, 12, 207, 6, NULL);
INSERT INTO `examination_result` VALUES (62, 0.901262, NULL, 211, 81, NULL);
INSERT INTO `examination_result` VALUES (63, 0.207591, NULL, 216, 78, NULL);
INSERT INTO `examination_result` VALUES (64, 0.316518, NULL, 216, 79, NULL);
INSERT INTO `examination_result` VALUES (65, 0.695284, NULL, 216, 80, NULL);
INSERT INTO `examination_result` VALUES (66, 0.787833, NULL, 213, 83, NULL);
INSERT INTO `examination_result` VALUES (67, 0.988637, NULL, 213, 84, NULL);
INSERT INTO `examination_result` VALUES (68, 0.992415, NULL, 213, 85, NULL);
INSERT INTO `examination_result` VALUES (69, 0.790477, NULL, 213, 86, NULL);
INSERT INTO `examination_result` VALUES (70, 0.392347, NULL, 213, 87, NULL);
INSERT INTO `examination_result` VALUES (71, 0.732787, NULL, 213, 88, NULL);
INSERT INTO `examination_result` VALUES (72, 0.953918, NULL, 213, 89, NULL);
INSERT INTO `examination_result` VALUES (73, 0.818204, NULL, 213, 90, NULL);
INSERT INTO `examination_result` VALUES (74, 0.341388, NULL, 213, 91, NULL);
INSERT INTO `examination_result` VALUES (75, 0.991448, NULL, 213, 92, NULL);
INSERT INTO `examination_result` VALUES (76, 0.20172, NULL, 213, 93, NULL);
INSERT INTO `examination_result` VALUES (77, 0.21405, NULL, 213, 94, NULL);
INSERT INTO `examination_result` VALUES (78, 0.388251, NULL, 210, 46, NULL);
INSERT INTO `examination_result` VALUES (79, 0.854824, NULL, 210, 47, NULL);
INSERT INTO `examination_result` VALUES (80, 0.390501, NULL, 210, 48, NULL);
INSERT INTO `examination_result` VALUES (81, 0.399157, NULL, 210, 49, NULL);
INSERT INTO `examination_result` VALUES (82, 0.824502, NULL, 210, 50, NULL);
INSERT INTO `examination_result` VALUES (83, 0.418726, NULL, 210, 51, NULL);
INSERT INTO `examination_result` VALUES (84, 0.318352, NULL, 210, 52, NULL);
INSERT INTO `examination_result` VALUES (85, 0.450714, NULL, 210, 53, NULL);
INSERT INTO `examination_result` VALUES (86, 0.501075, NULL, 210, 54, NULL);
INSERT INTO `examination_result` VALUES (87, 0.971424, NULL, 210, 55, NULL);
INSERT INTO `examination_result` VALUES (88, 0.62663, NULL, 210, 56, NULL);
INSERT INTO `examination_result` VALUES (89, 0.772, NULL, 210, 57, NULL);
INSERT INTO `examination_result` VALUES (90, 0.125362, NULL, 210, 58, NULL);
INSERT INTO `examination_result` VALUES (91, 0.702358, NULL, 210, 59, NULL);
INSERT INTO `examination_result` VALUES (92, 0.455153, NULL, 210, 60, NULL);
INSERT INTO `examination_result` VALUES (93, 0.481519, NULL, 210, 61, NULL);
INSERT INTO `examination_result` VALUES (94, 0.709247, NULL, 210, 62, NULL);
INSERT INTO `examination_result` VALUES (95, 0.203892, NULL, 212, 82, NULL);
INSERT INTO `examination_result` VALUES (96, 0.461376, NULL, 240, 24, '2024-02-29 21:36:29.568');
INSERT INTO `examination_result` VALUES (97, NULL, 2, 240, 25, '2024-02-29 21:36:29.570');
INSERT INTO `examination_result` VALUES (98, NULL, 2, 240, 26, '2024-02-29 21:36:29.571');
INSERT INTO `examination_result` VALUES (99, 0.327323, NULL, 253, 24, '2024-03-03 22:47:18.042');
INSERT INTO `examination_result` VALUES (100, NULL, 2, 253, 25, '2024-03-03 22:47:18.044');
INSERT INTO `examination_result` VALUES (101, NULL, 2, 253, 26, '2024-03-03 22:47:18.045');
INSERT INTO `examination_result` VALUES (102, 0.594408, NULL, 238, 5, '2024-03-04 08:42:54.962');
INSERT INTO `examination_result` VALUES (103, NULL, 2, 238, 6, '2024-03-04 08:42:54.964');
INSERT INTO `examination_result` VALUES (104, NULL, 2, 238, 7, '2024-03-04 08:42:54.965');
INSERT INTO `examination_result` VALUES (105, NULL, 2, 238, 8, '2024-03-04 08:42:54.965');
INSERT INTO `examination_result` VALUES (106, NULL, 2, 238, 9, '2024-03-04 08:42:54.966');
INSERT INTO `examination_result` VALUES (107, 0.66589, NULL, 238, 10, '2024-03-04 08:42:54.966');
INSERT INTO `examination_result` VALUES (108, NULL, 2, 238, 11, '2024-03-04 08:42:54.966');
INSERT INTO `examination_result` VALUES (109, NULL, 2, 238, 12, '2024-03-04 08:42:54.967');
INSERT INTO `examination_result` VALUES (110, NULL, 2, 238, 13, '2024-03-04 08:42:54.967');
INSERT INTO `examination_result` VALUES (111, NULL, 2, 238, 14, '2024-03-04 08:42:54.968');
INSERT INTO `examination_result` VALUES (112, 0.0398548, NULL, 245, 46, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (113, 0.489023, NULL, 245, 47, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (114, 0.414569, NULL, 245, 48, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (115, 0.404361, NULL, 245, 49, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (116, 0.64244, NULL, 245, 50, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (117, 0.330247, NULL, 245, 51, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (118, 0.54207, NULL, 245, 52, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (119, 0.540487, NULL, 245, 53, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (120, 0.649336, NULL, 245, 54, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (121, 0.516118, NULL, 245, 55, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (122, 0.334309, NULL, 245, 56, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (123, 0.963967, NULL, 245, 57, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (124, 0.860555, NULL, 245, 58, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (125, 0.604679, NULL, 245, 59, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (126, 0.923196, NULL, 245, 60, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (127, 0.544436, NULL, 245, 61, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (128, 0.00347083, NULL, 245, 62, '2024-03-04 08:45:22.405');
INSERT INTO `examination_result` VALUES (129, 0.327594, NULL, 249, 82, '2024-03-04 08:48:12.786');
INSERT INTO `examination_result` VALUES (130, 0.157491, NULL, 248, 81, '2024-03-04 08:48:15.811');
INSERT INTO `examination_result` VALUES (131, 0.741102, NULL, 247, 78, '2024-03-04 08:48:18.145');
INSERT INTO `examination_result` VALUES (132, 0.939326, NULL, 247, 79, '2024-03-04 08:48:18.145');
INSERT INTO `examination_result` VALUES (133, 0.00495724, NULL, 247, 80, '2024-03-04 08:48:18.145');
INSERT INTO `examination_result` VALUES (134, 0.604292, NULL, 250, 83, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (135, 0.466235, NULL, 250, 84, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (136, 0.780037, NULL, 250, 85, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (137, 0.903248, NULL, 250, 86, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (138, 0.264951, NULL, 250, 87, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (139, 0.780678, NULL, 250, 88, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (140, 0.475491, NULL, 250, 89, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (141, 0.838279, NULL, 250, 90, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (142, 0.169905, NULL, 250, 91, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (143, 0.189279, NULL, 250, 92, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (144, 0.14482, NULL, 250, 93, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (145, 0.746324, NULL, 250, 94, '2024-03-04 08:48:19.538');
INSERT INTO `examination_result` VALUES (146, 0.88794, NULL, 243, 38, '2024-03-04 08:53:12.620');
INSERT INTO `examination_result` VALUES (147, 0.825028, NULL, 243, 39, '2024-03-04 08:53:12.620');
INSERT INTO `examination_result` VALUES (148, NULL, 2, 243, 40, '2024-03-04 08:53:12.621');
INSERT INTO `examination_result` VALUES (149, NULL, 2, 243, 41, '2024-03-04 08:53:12.621');
INSERT INTO `examination_result` VALUES (150, NULL, 2, 243, 42, '2024-03-04 08:53:12.622');
INSERT INTO `examination_result` VALUES (151, NULL, 2, 243, 43, '2024-03-04 08:53:12.622');
INSERT INTO `examination_result` VALUES (152, NULL, 2, 243, 44, '2024-03-04 08:53:12.622');
INSERT INTO `examination_result` VALUES (153, 0.464003, NULL, 241, 27, '2024-03-04 09:02:59.141');
INSERT INTO `examination_result` VALUES (154, NULL, 2, 241, 28, '2024-03-04 09:02:59.142');
INSERT INTO `examination_result` VALUES (155, NULL, 2, 241, 29, '2024-03-04 09:02:59.143');
INSERT INTO `examination_result` VALUES (156, NULL, 2, 241, 30, '2024-03-04 09:02:59.143');
INSERT INTO `examination_result` VALUES (157, NULL, 2, 241, 31, '2024-03-04 09:02:59.144');
INSERT INTO `examination_result` VALUES (158, 0.147627, NULL, 239, 15, '2024-03-04 09:08:36.082');
INSERT INTO `examination_result` VALUES (159, NULL, 2, 239, 16, '2024-03-04 09:08:36.083');
INSERT INTO `examination_result` VALUES (160, NULL, 2, 239, 17, '2024-03-04 09:08:36.083');
INSERT INTO `examination_result` VALUES (161, NULL, 2, 239, 18, '2024-03-04 09:08:36.084');
INSERT INTO `examination_result` VALUES (162, NULL, 2, 239, 19, '2024-03-04 09:08:36.084');
INSERT INTO `examination_result` VALUES (163, NULL, 2, 239, 20, '2024-03-04 09:08:36.085');
INSERT INTO `examination_result` VALUES (164, NULL, 2, 239, 21, '2024-03-04 09:08:36.085');
INSERT INTO `examination_result` VALUES (165, NULL, 2, 239, 22, '2024-03-04 09:08:36.085');
INSERT INTO `examination_result` VALUES (166, NULL, 2, 239, 23, '2024-03-04 09:08:36.086');
INSERT INTO `examination_result` VALUES (167, 0.278776, NULL, 242, 32, '2024-03-04 09:10:33.514');
INSERT INTO `examination_result` VALUES (168, NULL, 2, 242, 33, '2024-03-04 09:10:33.516');
INSERT INTO `examination_result` VALUES (169, NULL, 2, 242, 34, '2024-03-04 09:10:33.516');
INSERT INTO `examination_result` VALUES (170, NULL, 2, 242, 35, '2024-03-04 09:10:33.517');
INSERT INTO `examination_result` VALUES (171, NULL, 2, 242, 36, '2024-03-04 09:10:33.517');
INSERT INTO `examination_result` VALUES (172, NULL, 2, 242, 37, '2024-03-04 09:10:33.518');
INSERT INTO `examination_result` VALUES (173, 0.404217, NULL, 244, 45, '2024-03-04 09:10:36.465');
INSERT INTO `examination_result` VALUES (174, 0.711672, NULL, 237, 1, '2024-03-04 09:10:59.630');
INSERT INTO `examination_result` VALUES (175, 0.161149, NULL, 237, 2, '2024-03-04 09:10:59.630');
INSERT INTO `examination_result` VALUES (176, 0.708688, NULL, 237, 3, '2024-03-04 09:10:59.630');
INSERT INTO `examination_result` VALUES (177, 0.974307, NULL, 237, 4, '2024-03-04 09:10:59.630');
INSERT INTO `examination_result` VALUES (178, 0.793647, NULL, 251, 5, '2024-03-04 14:56:16.111');
INSERT INTO `examination_result` VALUES (179, NULL, 2, 251, 6, '2024-03-04 14:56:16.111');
INSERT INTO `examination_result` VALUES (180, NULL, 2, 251, 7, '2024-03-04 14:56:16.112');
INSERT INTO `examination_result` VALUES (181, NULL, 2, 251, 8, '2024-03-04 14:56:16.113');
INSERT INTO `examination_result` VALUES (182, NULL, 2, 251, 9, '2024-03-04 14:56:16.113');
INSERT INTO `examination_result` VALUES (183, 0.648759, NULL, 251, 10, '2024-03-04 14:56:16.113');
INSERT INTO `examination_result` VALUES (184, NULL, 2, 251, 11, '2024-03-04 14:56:16.114');
INSERT INTO `examination_result` VALUES (185, NULL, 2, 251, 12, '2024-03-04 14:56:16.114');
INSERT INTO `examination_result` VALUES (186, NULL, 2, 251, 13, '2024-03-04 14:56:16.115');
INSERT INTO `examination_result` VALUES (187, NULL, 2, 251, 14, '2024-03-04 14:56:16.115');
INSERT INTO `examination_result` VALUES (188, 0.22473, NULL, 255, 38, '2024-03-04 15:41:16.982');
INSERT INTO `examination_result` VALUES (189, 0.162745, NULL, 255, 39, '2024-03-04 15:41:16.982');
INSERT INTO `examination_result` VALUES (190, NULL, 12, 255, 40, '2024-03-04 15:41:16.983');
INSERT INTO `examination_result` VALUES (191, NULL, 12, 255, 41, '2024-03-04 15:41:16.983');
INSERT INTO `examination_result` VALUES (192, NULL, 12, 255, 42, '2024-03-04 15:41:16.984');
INSERT INTO `examination_result` VALUES (193, NULL, 12, 255, 43, '2024-03-04 15:41:16.984');
INSERT INTO `examination_result` VALUES (194, NULL, 12, 255, 44, '2024-03-04 15:41:16.985');
INSERT INTO `examination_result` VALUES (195, 0.981964, NULL, 254, 27, '2024-03-04 15:41:19.641');
INSERT INTO `examination_result` VALUES (196, NULL, 12, 254, 28, '2024-03-04 15:41:19.641');
INSERT INTO `examination_result` VALUES (197, NULL, 12, 254, 29, '2024-03-04 15:41:19.641');
INSERT INTO `examination_result` VALUES (198, NULL, 12, 254, 30, '2024-03-04 15:41:19.642');
INSERT INTO `examination_result` VALUES (199, NULL, 12, 254, 31, '2024-03-04 15:41:19.642');
INSERT INTO `examination_result` VALUES (200, 0.608974, NULL, 252, 15, '2024-03-04 15:41:22.027');
INSERT INTO `examination_result` VALUES (201, NULL, 12, 252, 16, '2024-03-04 15:41:22.028');
INSERT INTO `examination_result` VALUES (202, NULL, 12, 252, 17, '2024-03-04 15:41:22.028');
INSERT INTO `examination_result` VALUES (203, NULL, 12, 252, 18, '2024-03-04 15:41:22.028');
INSERT INTO `examination_result` VALUES (204, NULL, 12, 252, 19, '2024-03-04 15:41:22.029');
INSERT INTO `examination_result` VALUES (205, NULL, 12, 252, 20, '2024-03-04 15:41:22.029');
INSERT INTO `examination_result` VALUES (206, NULL, 12, 252, 21, '2024-03-04 15:41:22.030');
INSERT INTO `examination_result` VALUES (207, NULL, 12, 252, 22, '2024-03-04 15:41:22.030');
INSERT INTO `examination_result` VALUES (208, NULL, 12, 252, 23, '2024-03-04 15:41:22.030');
INSERT INTO `examination_result` VALUES (209, 0.658693, NULL, 256, 46, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (210, 0.0636746, NULL, 256, 47, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (211, 0.464184, NULL, 256, 48, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (212, 0.08377, NULL, 256, 49, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (213, 0.452304, NULL, 256, 50, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (214, 0.717203, NULL, 256, 51, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (215, 0.461962, NULL, 256, 52, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (216, 0.174121, NULL, 256, 53, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (217, 0.874083, NULL, 256, 54, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (218, 0.732162, NULL, 256, 55, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (219, 0.35315, NULL, 256, 56, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (220, 0.124174, NULL, 256, 57, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (221, 0.112883, NULL, 256, 58, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (222, 0.445798, NULL, 256, 59, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (223, 0.721123, NULL, 256, 60, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (224, 0.763668, NULL, 256, 61, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (225, 0.534537, NULL, 256, 62, '2024-03-04 15:43:52.315');
INSERT INTO `examination_result` VALUES (226, 0.271829, NULL, 258, 5, '2024-03-04 15:57:16.128');
INSERT INTO `examination_result` VALUES (227, NULL, 2, 258, 6, '2024-03-04 15:57:16.129');
INSERT INTO `examination_result` VALUES (228, NULL, 2, 258, 7, '2024-03-04 15:57:16.129');
INSERT INTO `examination_result` VALUES (229, NULL, 2, 258, 8, '2024-03-04 15:57:16.130');
INSERT INTO `examination_result` VALUES (230, NULL, 2, 258, 9, '2024-03-04 15:57:16.130');
INSERT INTO `examination_result` VALUES (231, 0.125666, NULL, 258, 10, '2024-03-04 15:57:16.130');
INSERT INTO `examination_result` VALUES (232, NULL, 2, 258, 11, '2024-03-04 15:57:16.130');
INSERT INTO `examination_result` VALUES (233, NULL, 2, 258, 12, '2024-03-04 15:57:16.131');
INSERT INTO `examination_result` VALUES (234, NULL, 2, 258, 13, '2024-03-04 15:57:16.131');
INSERT INTO `examination_result` VALUES (235, NULL, 2, 258, 14, '2024-03-04 15:57:16.131');
INSERT INTO `examination_result` VALUES (236, 0.992902, NULL, 263, 46, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (237, 0.159915, NULL, 263, 47, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (238, 0.550889, NULL, 263, 48, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (239, 0.89553, NULL, 263, 49, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (240, 0.424726, NULL, 263, 50, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (241, 0.706367, NULL, 263, 51, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (242, 0.159589, NULL, 263, 52, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (243, 0.788746, NULL, 263, 53, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (244, 0.766129, NULL, 263, 54, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (245, 0.87858, NULL, 263, 55, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (246, 0.300813, NULL, 263, 56, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (247, 0.327974, NULL, 263, 57, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (248, 0.679596, NULL, 263, 58, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (249, 0.390731, NULL, 263, 59, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (250, 0.48045, NULL, 263, 60, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (251, 0.787249, NULL, 263, 61, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (252, 0.761974, NULL, 263, 62, '2024-03-04 15:57:28.518');
INSERT INTO `examination_result` VALUES (253, 0.0185433, NULL, 262, 38, '2024-03-04 15:57:38.698');
INSERT INTO `examination_result` VALUES (254, 0.254492, NULL, 262, 39, '2024-03-04 15:57:38.698');
INSERT INTO `examination_result` VALUES (255, NULL, 2, 262, 40, '2024-03-04 15:57:38.698');
INSERT INTO `examination_result` VALUES (256, NULL, 2, 262, 41, '2024-03-04 15:57:38.699');
INSERT INTO `examination_result` VALUES (257, NULL, 2, 262, 42, '2024-03-04 15:57:38.699');
INSERT INTO `examination_result` VALUES (258, NULL, 2, 262, 43, '2024-03-04 15:57:38.700');
INSERT INTO `examination_result` VALUES (259, NULL, 2, 262, 44, '2024-03-04 15:57:38.700');
INSERT INTO `examination_result` VALUES (260, 0.745012, NULL, 261, 27, '2024-03-04 15:57:50.507');
INSERT INTO `examination_result` VALUES (261, NULL, 2, 261, 28, '2024-03-04 15:57:50.508');
INSERT INTO `examination_result` VALUES (262, NULL, 2, 261, 29, '2024-03-04 15:57:50.509');
INSERT INTO `examination_result` VALUES (263, NULL, 2, 261, 30, '2024-03-04 15:57:50.509');
INSERT INTO `examination_result` VALUES (264, NULL, 2, 261, 31, '2024-03-04 15:57:50.509');
INSERT INTO `examination_result` VALUES (265, 0.624131, NULL, 259, 15, '2024-03-04 15:58:00.583');
INSERT INTO `examination_result` VALUES (266, NULL, 2, 259, 16, '2024-03-04 15:58:00.584');
INSERT INTO `examination_result` VALUES (267, NULL, 2, 259, 17, '2024-03-04 15:58:00.584');
INSERT INTO `examination_result` VALUES (268, NULL, 2, 259, 18, '2024-03-04 15:58:00.584');
INSERT INTO `examination_result` VALUES (269, NULL, 2, 259, 19, '2024-03-04 15:58:00.584');
INSERT INTO `examination_result` VALUES (270, NULL, 2, 259, 20, '2024-03-04 15:58:00.584');
INSERT INTO `examination_result` VALUES (271, NULL, 2, 259, 21, '2024-03-04 15:58:00.585');
INSERT INTO `examination_result` VALUES (272, NULL, 2, 259, 22, '2024-03-04 15:58:00.585');
INSERT INTO `examination_result` VALUES (273, NULL, 2, 259, 23, '2024-03-04 15:58:00.585');
INSERT INTO `examination_result` VALUES (274, 0.0824779, NULL, 267, 24, '2024-03-05 16:01:31.423');
INSERT INTO `examination_result` VALUES (275, NULL, 2, 267, 25, '2024-03-05 16:01:31.424');
INSERT INTO `examination_result` VALUES (276, NULL, 2, 267, 26, '2024-03-05 16:01:31.424');
INSERT INTO `examination_result` VALUES (277, 0.68671, NULL, 265, 5, '2024-03-05 16:03:38.701');
INSERT INTO `examination_result` VALUES (278, NULL, 2, 265, 6, '2024-03-05 16:03:38.704');
INSERT INTO `examination_result` VALUES (279, NULL, 2, 265, 7, '2024-03-05 16:03:38.705');
INSERT INTO `examination_result` VALUES (280, NULL, 2, 265, 8, '2024-03-05 16:03:38.705');
INSERT INTO `examination_result` VALUES (281, NULL, 2, 265, 9, '2024-03-05 16:03:38.706');
INSERT INTO `examination_result` VALUES (282, 0.189104, NULL, 265, 10, '2024-03-05 16:03:38.706');
INSERT INTO `examination_result` VALUES (283, NULL, 2, 265, 11, '2024-03-05 16:03:38.707');
INSERT INTO `examination_result` VALUES (284, NULL, 2, 265, 12, '2024-03-05 16:03:38.708');
INSERT INTO `examination_result` VALUES (285, NULL, 2, 265, 13, '2024-03-05 16:03:38.709');
INSERT INTO `examination_result` VALUES (286, NULL, 2, 265, 14, '2024-03-05 16:03:38.710');
INSERT INTO `examination_result` VALUES (287, 0.813691, NULL, 271, 46, '2024-03-05 16:03:56.594');
INSERT INTO `examination_result` VALUES (288, 0.327118, NULL, 271, 47, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (289, 0.802487, NULL, 271, 48, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (290, 0.165428, NULL, 271, 49, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (291, 0.356398, NULL, 271, 50, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (292, 0.523305, NULL, 271, 51, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (293, 0.738061, NULL, 271, 52, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (294, 0.572946, NULL, 271, 53, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (295, 0.954184, NULL, 271, 54, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (296, 0.28047, NULL, 271, 55, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (297, 0.532114, NULL, 271, 56, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (298, 0.895883, NULL, 271, 57, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (299, 0.52311, NULL, 271, 58, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (300, 0.52631, NULL, 271, 59, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (301, 0.431972, NULL, 271, 60, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (302, 0.810705, NULL, 271, 61, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (303, 0.138952, NULL, 271, 62, '2024-03-05 16:03:56.595');
INSERT INTO `examination_result` VALUES (304, 0.924688, NULL, 274, 82, '2024-03-05 16:04:06.735');
INSERT INTO `examination_result` VALUES (305, 0.746191, NULL, 273, 81, '2024-03-05 16:04:10.152');
INSERT INTO `examination_result` VALUES (306, 0.531041, NULL, 272, 78, '2024-03-05 16:04:13.682');
INSERT INTO `examination_result` VALUES (307, 0.0876225, NULL, 272, 79, '2024-03-05 16:04:13.682');
INSERT INTO `examination_result` VALUES (308, 0.418085, NULL, 272, 80, '2024-03-05 16:04:13.682');
INSERT INTO `examination_result` VALUES (309, 0.324684, NULL, 275, 83, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (310, 0.891379, NULL, 275, 84, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (311, 0.851448, NULL, 275, 85, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (312, 0.200673, NULL, 275, 86, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (313, 0.759374, NULL, 275, 87, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (314, 0.988386, NULL, 275, 88, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (315, 0.22302, NULL, 275, 89, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (316, 0.0422219, NULL, 275, 90, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (317, 0.788885, NULL, 275, 91, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (318, 0.616643, NULL, 275, 92, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (319, 0.272652, NULL, 275, 93, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (320, 0.924295, NULL, 275, 94, '2024-03-05 16:04:16.863');
INSERT INTO `examination_result` VALUES (321, 0.182779, NULL, 268, 27, '2024-03-05 16:05:02.340');
INSERT INTO `examination_result` VALUES (322, NULL, 2, 268, 28, '2024-03-05 16:05:02.341');
INSERT INTO `examination_result` VALUES (323, NULL, 2, 268, 29, '2024-03-05 16:05:02.341');
INSERT INTO `examination_result` VALUES (324, NULL, 2, 268, 30, '2024-03-05 16:05:02.342');
INSERT INTO `examination_result` VALUES (325, NULL, 2, 268, 31, '2024-03-05 16:05:02.342');
INSERT INTO `examination_result` VALUES (326, 0.91719, NULL, 266, 15, '2024-03-05 16:05:25.522');
INSERT INTO `examination_result` VALUES (327, NULL, 2, 266, 16, '2024-03-05 16:05:25.523');
INSERT INTO `examination_result` VALUES (328, NULL, 2, 266, 17, '2024-03-05 16:05:25.523');
INSERT INTO `examination_result` VALUES (329, NULL, 2, 266, 18, '2024-03-05 16:05:25.523');
INSERT INTO `examination_result` VALUES (330, NULL, 2, 266, 19, '2024-03-05 16:05:25.523');
INSERT INTO `examination_result` VALUES (331, NULL, 2, 266, 20, '2024-03-05 16:05:25.524');
INSERT INTO `examination_result` VALUES (332, NULL, 2, 266, 21, '2024-03-05 16:05:25.524');
INSERT INTO `examination_result` VALUES (333, NULL, 2, 266, 22, '2024-03-05 16:05:25.524');
INSERT INTO `examination_result` VALUES (334, NULL, 2, 266, 23, '2024-03-05 16:05:25.524');
INSERT INTO `examination_result` VALUES (335, 0.176142, NULL, 269, 32, '2024-03-05 16:05:41.111');
INSERT INTO `examination_result` VALUES (336, NULL, 2, 269, 33, '2024-03-05 16:05:41.112');
INSERT INTO `examination_result` VALUES (337, NULL, 2, 269, 34, '2024-03-05 16:05:41.113');
INSERT INTO `examination_result` VALUES (338, NULL, 2, 269, 35, '2024-03-05 16:05:41.114');
INSERT INTO `examination_result` VALUES (339, NULL, 2, 269, 36, '2024-03-05 16:05:41.114');
INSERT INTO `examination_result` VALUES (340, NULL, 2, 269, 37, '2024-03-05 16:05:41.115');
INSERT INTO `examination_result` VALUES (341, 0.590774, NULL, 270, 45, '2024-03-05 16:05:43.112');
INSERT INTO `examination_result` VALUES (342, 0.561503, NULL, 264, 1, '2024-03-05 16:05:51.400');
INSERT INTO `examination_result` VALUES (343, 0.928514, NULL, 264, 2, '2024-03-05 16:05:51.400');
INSERT INTO `examination_result` VALUES (344, 0.296244, NULL, 264, 3, '2024-03-05 16:05:51.400');
INSERT INTO `examination_result` VALUES (345, 0.76458, NULL, 264, 4, '2024-03-05 16:05:51.400');
INSERT INTO `examination_result` VALUES (346, 0.530062, NULL, 278, 24, '2024-03-05 16:59:34.409');
INSERT INTO `examination_result` VALUES (347, NULL, 2, 278, 25, '2024-03-05 16:59:34.414');
INSERT INTO `examination_result` VALUES (348, NULL, 2, 278, 26, '2024-03-05 16:59:34.416');
INSERT INTO `examination_result` VALUES (349, 0.927446, NULL, 276, 5, '2024-03-05 16:59:45.225');
INSERT INTO `examination_result` VALUES (350, NULL, 2, 276, 6, '2024-03-05 16:59:45.226');
INSERT INTO `examination_result` VALUES (351, NULL, 2, 276, 7, '2024-03-05 16:59:45.227');
INSERT INTO `examination_result` VALUES (352, NULL, 2, 276, 8, '2024-03-05 16:59:45.228');
INSERT INTO `examination_result` VALUES (353, NULL, 2, 276, 9, '2024-03-05 16:59:45.228');
INSERT INTO `examination_result` VALUES (354, 0.210165, NULL, 276, 10, '2024-03-05 16:59:45.228');
INSERT INTO `examination_result` VALUES (355, NULL, 2, 276, 11, '2024-03-05 16:59:45.229');
INSERT INTO `examination_result` VALUES (356, NULL, 2, 276, 12, '2024-03-05 16:59:45.229');
INSERT INTO `examination_result` VALUES (357, NULL, 2, 276, 13, '2024-03-05 16:59:45.230');
INSERT INTO `examination_result` VALUES (358, NULL, 2, 276, 14, '2024-03-05 16:59:45.232');
INSERT INTO `examination_result` VALUES (359, 0.263571, NULL, 281, 46, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (360, 0.185101, NULL, 281, 47, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (361, 0.0760271, NULL, 281, 48, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (362, 0.195691, NULL, 281, 49, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (363, 0.0343708, NULL, 281, 50, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (364, 0.77755, NULL, 281, 51, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (365, 0.210858, NULL, 281, 52, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (366, 0.86422, NULL, 281, 53, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (367, 0.379652, NULL, 281, 54, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (368, 0.580503, NULL, 281, 55, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (369, 0.711367, NULL, 281, 56, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (370, 0.669025, NULL, 281, 57, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (371, 0.107442, NULL, 281, 58, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (372, 0.410094, NULL, 281, 59, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (373, 0.970783, NULL, 281, 60, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (374, 0.0505679, NULL, 281, 61, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (375, 0.167469, NULL, 281, 62, '2024-03-05 16:59:51.377');
INSERT INTO `examination_result` VALUES (376, 0.0855084, NULL, 280, 38, '2024-03-05 17:00:00.926');
INSERT INTO `examination_result` VALUES (377, 0.0194923, NULL, 280, 39, '2024-03-05 17:00:00.926');
INSERT INTO `examination_result` VALUES (378, NULL, 2, 280, 40, '2024-03-05 17:00:00.927');
INSERT INTO `examination_result` VALUES (379, NULL, 2, 280, 41, '2024-03-05 17:00:00.927');
INSERT INTO `examination_result` VALUES (380, NULL, 2, 280, 42, '2024-03-05 17:00:00.928');
INSERT INTO `examination_result` VALUES (381, NULL, 2, 280, 43, '2024-03-05 17:00:00.928');
INSERT INTO `examination_result` VALUES (382, NULL, 2, 280, 44, '2024-03-05 17:00:00.928');
INSERT INTO `examination_result` VALUES (383, 0.608513, NULL, 279, 27, '2024-03-05 17:00:07.893');
INSERT INTO `examination_result` VALUES (384, NULL, 2, 279, 28, '2024-03-05 17:00:07.894');
INSERT INTO `examination_result` VALUES (385, NULL, 2, 279, 29, '2024-03-05 17:00:07.894');
INSERT INTO `examination_result` VALUES (386, NULL, 2, 279, 30, '2024-03-05 17:00:07.894');
INSERT INTO `examination_result` VALUES (387, NULL, 2, 279, 31, '2024-03-05 17:00:07.894');
INSERT INTO `examination_result` VALUES (388, 0.505593, NULL, 277, 15, '2024-03-05 17:00:16.500');
INSERT INTO `examination_result` VALUES (389, NULL, 2, 277, 16, '2024-03-05 17:00:16.501');
INSERT INTO `examination_result` VALUES (390, NULL, 2, 277, 17, '2024-03-05 17:00:16.502');
INSERT INTO `examination_result` VALUES (391, NULL, 2, 277, 18, '2024-03-05 17:00:16.503');
INSERT INTO `examination_result` VALUES (392, NULL, 2, 277, 19, '2024-03-05 17:00:16.506');
INSERT INTO `examination_result` VALUES (393, NULL, 2, 277, 20, '2024-03-05 17:00:16.508');
INSERT INTO `examination_result` VALUES (394, NULL, 2, 277, 21, '2024-03-05 17:00:16.509');
INSERT INTO `examination_result` VALUES (395, NULL, 2, 277, 22, '2024-03-05 17:00:16.510');
INSERT INTO `examination_result` VALUES (396, NULL, 2, 277, 23, '2024-03-05 17:00:16.510');

-- ----------------------------
-- Table structure for examinee
-- ----------------------------
DROP TABLE IF EXISTS `examinee`;
CREATE TABLE `examinee`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '体检人姓名',
  `identification_number` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  `birthday` date NOT NULL COMMENT '出生日期',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号码',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `user_id` int NOT NULL COMMENT '所在账户的用户id',
  `relationship_id` int NOT NULL COMMENT '关系id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `relationship_id`(`relationship_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `examinee_ibfk_1` FOREIGN KEY (`relationship_id`) REFERENCES `relationship` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examinee_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examinee
-- ----------------------------
INSERT INTO `examinee` VALUES (1, '张雨绮', '230293847123112312', '女', '2011-02-11', '18937829582', '2023-04-12 19:35:28', 11, 1);
INSERT INTO `examinee` VALUES (2, '王思博', '310112462738193721', '男', '2011-02-12', '13829223132', '2023-04-23 12:06:12', 22, 1);
INSERT INTO `examinee` VALUES (7, '丁欣欣', '310201197902044427', '男', '1989-01-01', '13291625628', '2024-03-05 16:00:44', 23, 1);
INSERT INTO `examinee` VALUES (8, '张涛', '620101200211211021', '男', '2007-01-01', '13720999653', '2024-03-05 16:58:33', 24, 1);

-- ----------------------------
-- Table structure for group_information
-- ----------------------------
DROP TABLE IF EXISTS `group_information`;
CREATE TABLE `group_information`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(26) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公司名称',
  `create_time` timestamp(6) NOT NULL COMMENT '订单创建时间',
  `start_time` timestamp(6) NULL DEFAULT NULL COMMENT '团检开始时间',
  `end_time` timestamp(6) NULL DEFAULT NULL COMMENT '团检结束时间',
  `number` smallint NOT NULL COMMENT '团检人数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_information
-- ----------------------------
INSERT INTO `group_information` VALUES (1, '无', '2023-04-12 20:28:30.000000', '2023-04-12 20:28:32.000000', '2023-04-12 20:28:34.000000', 0);

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `unit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单位',
  `normal_range_id` int NULL DEFAULT NULL COMMENT '正常结果范围id',
  `normal_option_id` int NULL DEFAULT NULL COMMENT '正常结果文本值id',
  `average_duration` float NOT NULL COMMENT '平均进行时长（分钟）',
  `value_type` smallint NOT NULL COMMENT '0-数值型 1-文字型',
  `category_id` int NOT NULL COMMENT '项目分类id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `normal_option_id`(`normal_option_id` ASC) USING BTREE,
  INDEX `normal_range_id`(`normal_range_id` ASC) USING BTREE,
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`normal_option_id`) REFERENCES `result_text_option` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `item_ibfk_3` FOREIGN KEY (`normal_range_id`) REFERENCES `normal_range` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (1, '收缩压', 'mmHG', 1, 2, 1, 0, 1);
INSERT INTO `item` VALUES (2, '舒张压', 'mmHG', 2, 2, 1, 0, 1);
INSERT INTO `item` VALUES (3, '身高', 'cm', NULL, 2, 1, 0, 1);
INSERT INTO `item` VALUES (4, '体重', 'Kg', NULL, 2, 1, 0, 1);
INSERT INTO `item` VALUES (5, '胸廓', 'text', NULL, 4, 0.5, 1, 2);
INSERT INTO `item` VALUES (6, '肺部', 'text', NULL, 2, 0.5, 1, 2);
INSERT INTO `item` VALUES (7, '心界', 'text', NULL, 2, 0.5, 1, 2);
INSERT INTO `item` VALUES (8, '心音', 'text', NULL, 1, 0.5, 1, 2);
INSERT INTO `item` VALUES (9, '心律', 'text', NULL, 5, 0.5, 1, 2);
INSERT INTO `item` VALUES (10, '心率', '次/分', 3, 2, 0.5, 0, 2);
INSERT INTO `item` VALUES (11, '心脏杂音', 'text', 2, 3, 0.5, 1, 2);
INSERT INTO `item` VALUES (12, '腹部外形', 'text', 2, 2, 0.5, 1, 2);
INSERT INTO `item` VALUES (13, '腹部压痛', 'text', 2, 3, 0.5, 1, 2);
INSERT INTO `item` VALUES (14, '内科其它', 'text', 2, 3, 0.5, 1, 2);
INSERT INTO `item` VALUES (15, '皮肤', 'text', NULL, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (16, '颈部', 'text', NULL, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (17, '脊柱', 'text', NULL, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (18, '四肢', 'text', NULL, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (19, '肛门、直肠', 'text', NULL, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (20, '疝气', 'text', NULL, 3, 0.5, 1, 3);
INSERT INTO `item` VALUES (21, '泌尿生殖器', 'text', NULL, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (22, '甲状腺', 'text', 1, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (23, '浅表淋巴结', 'text', 1, 2, 0.5, 1, 3);
INSERT INTO `item` VALUES (24, '心率', '次/分', 3, 1, 0.5, 0, 4);
INSERT INTO `item` VALUES (25, '心律', 'text', 1, 5, 0.5, 1, 4);
INSERT INTO `item` VALUES (26, '心电图检查', 'text', 1, 6, 0.5, 1, 4);
INSERT INTO `item` VALUES (27, '耳部', 'text', 1, 2, 0.5, 1, 5);
INSERT INTO `item` VALUES (28, '鼻部', 'text', 1, 1, 0.5, 1, 5);
INSERT INTO `item` VALUES (29, '咽部', 'text', 1, 1, 0.5, 1, 5);
INSERT INTO `item` VALUES (30, '喉部', 'text', 1, 1, 0.5, 1, 5);
INSERT INTO `item` VALUES (31, '耳鼻喉科其它', 'text', 1, 2, 0.5, 1, 5);
INSERT INTO `item` VALUES (32, '肝', 'text', 1, 2, 0.5, 1, 6);
INSERT INTO `item` VALUES (33, '胆', 'text', 1, 2, 0.5, 1, 6);
INSERT INTO `item` VALUES (34, '胰', 'text', 1, 2, 0.5, 1, 6);
INSERT INTO `item` VALUES (35, '脾', 'text', 1, 2, 0.5, 1, 6);
INSERT INTO `item` VALUES (36, '左肾', 'text', 1, 2, 0.5, 1, 6);
INSERT INTO `item` VALUES (37, '右肾', 'text', 1, 2, 0.5, 1, 6);
INSERT INTO `item` VALUES (38, '视力右', '度', 1, 1, 0.5, 0, 7);
INSERT INTO `item` VALUES (39, '视力左', '度', 1, 1, 0.5, 0, 7);
INSERT INTO `item` VALUES (40, '眼睑', 'text', 1, 1, 0.5, 1, 7);
INSERT INTO `item` VALUES (41, '眼球', 'text', 1, 1, 0.5, 1, 7);
INSERT INTO `item` VALUES (42, '结膜', 'text', 1, 1, 0.5, 1, 7);
INSERT INTO `item` VALUES (43, '巩膜', 'text', 1, 1, 0.5, 1, 7);
INSERT INTO `item` VALUES (44, '眼底', 'text', 1, 1, 0.5, 1, 7);
INSERT INTO `item` VALUES (45, '甲状腺超声', 'text', 1, 2, 0.5, 1, 8);
INSERT INTO `item` VALUES (46, 'MCV', 'fl', 4, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (47, '红细胞比积', '%', 5, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (48, '血小板', '10^9/L', 6, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (49, '嗜酸性粒细胞', '%', 7, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (50, '单核细胞', '%', 8, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (51, '白细胞', '10^9/L', 9, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (52, 'MCH', 'pg', 10, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (53, '红细胞', '10^12/L', 11, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (54, '嗜喊性粒细胞', '%', 12, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (55, '中性粒细胞', '10^9/L', 13, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (56, '单核细胞', '10^9/L', 14, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (57, '淋巴细胞', '10^9/L', 15, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (58, 'MCHC', 'g/L', 16, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (59, '林巴细胞', '%', 17, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (60, '嗜酸性粒细胞', '10^9/L', 18, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (61, '血红蛋白', 'g/L', 19, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (62, '中性粒细胞', '%', 20, 1, 0.5, 0, 9);
INSERT INTO `item` VALUES (63, '白细胞脂酶', 'text', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (64, '蛋白', 'g/L', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (65, '胆红素', 'umol/l', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (66, '亚硝酸盐', 'text', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (67, '透明度', 'text', 1, 8, 0.5, 1, 10);
INSERT INTO `item` VALUES (68, '葡萄糖', 'mmol/l', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (69, '红细胞（镜检）', '/HPF', 21, 1, 0.5, 0, 10);
INSERT INTO `item` VALUES (70, '尿隐血', '/ul', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (71, '尿胆原', 'text', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (72, '管型（镜检）', '/LPF', 1, 9, 0.5, 1, 10);
INSERT INTO `item` VALUES (73, '酸碱度', 'pH', 22, 1, 0.5, 0, 10);
INSERT INTO `item` VALUES (74, '酮体', 'mmol/l', 1, 7, 0.5, 1, 10);
INSERT INTO `item` VALUES (75, '颜色', 'text', 1, 10, 0.5, 1, 10);
INSERT INTO `item` VALUES (76, '白细胞（镜检）', '/HPF', 1, 1, 0.5, 1, 10);
INSERT INTO `item` VALUES (77, '上皮细胞（镜检）', '/HPF', 1, 1, 0.5, 1, 10);
INSERT INTO `item` VALUES (78, '尿素', 'mmol/l', 23, 1, 0.5, 0, 11);
INSERT INTO `item` VALUES (79, '肌酐', 'umol/l', 24, 1, 0.5, 0, 11);
INSERT INTO `item` VALUES (80, '尿酸', 'umol/l', 25, 1, 0.5, 0, 11);
INSERT INTO `item` VALUES (81, '糖化血红蛋白', '%', 26, 1, 0.5, 0, 12);
INSERT INTO `item` VALUES (82, '空腹血糖', 'mmol/l', 27, 1, 0.5, 0, 13);
INSERT INTO `item` VALUES (83, '血清β人绒毛膜促性腺激素', 'ng/ml', 28, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (84, '癌胚抗原测定定量', 'ng/ml', 29, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (85, '甲胎蛋白测定定量', 'ng/ml', 30, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (86, '神经元特异烯醇化酶测定', 'ng/ml', 31, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (87, '细胞角蛋白19片段', 'ng/ml', 32, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (88, '糖链抗原50测定', 'u/ml', 33, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (89, '糖链抗原125测定', 'u/ml', 34, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (90, '糖链抗原19-9测定', 'u/ml', 35, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (91, '糖链抗原242测定', 'u/ml', 36, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (92, '糖链抗原15-3测定', 'u/ml', 37, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (93, '糖链抗原72-4测定', 'u/ml', 38, 1, 0.5, 0, 14);
INSERT INTO `item` VALUES (94, '特异生长因子测定', 'u/ml', 39, 1, 0.5, 0, 14);

-- ----------------------------
-- Table structure for item_option
-- ----------------------------
DROP TABLE IF EXISTS `item_option`;
CREATE TABLE `item_option`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `option_id` int NOT NULL COMMENT '文本选项id',
  `item_id` int NOT NULL COMMENT '项目id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE,
  INDEX `option_id`(`option_id` ASC) USING BTREE,
  CONSTRAINT `item_option_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `item_option_ibfk_2` FOREIGN KEY (`option_id`) REFERENCES `result_text_option` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_option
-- ----------------------------
INSERT INTO `item_option` VALUES (1, 1, 10);
INSERT INTO `item_option` VALUES (2, 2, 20);

-- ----------------------------
-- Table structure for normal_range
-- ----------------------------
DROP TABLE IF EXISTS `normal_range`;
CREATE TABLE `normal_range`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `start` float NOT NULL COMMENT '正常范围开始值',
  `end` float NOT NULL COMMENT '正常范围终止值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of normal_range
-- ----------------------------
INSERT INTO `normal_range` VALUES (1, 0, 0);
INSERT INTO `normal_range` VALUES (2, 90, 140);
INSERT INTO `normal_range` VALUES (3, 60, 90);
INSERT INTO `normal_range` VALUES (4, 59, 101);
INSERT INTO `normal_range` VALUES (5, 40, 50);
INSERT INTO `normal_range` VALUES (6, 125, 350);
INSERT INTO `normal_range` VALUES (7, 0.4, 8);
INSERT INTO `normal_range` VALUES (8, 3, 10);
INSERT INTO `normal_range` VALUES (9, 3.5, 9.5);
INSERT INTO `normal_range` VALUES (10, 27, 34);
INSERT INTO `normal_range` VALUES (11, 4.3, 5.8);
INSERT INTO `normal_range` VALUES (12, 0, 1);
INSERT INTO `normal_range` VALUES (13, 1.8, 6.3);
INSERT INTO `normal_range` VALUES (14, 0.1, 0.6);
INSERT INTO `normal_range` VALUES (15, 1.1, 3.2);
INSERT INTO `normal_range` VALUES (16, 316, 354);
INSERT INTO `normal_range` VALUES (17, 20, 50);
INSERT INTO `normal_range` VALUES (18, 0.02, 0.52);
INSERT INTO `normal_range` VALUES (19, 130, 175);
INSERT INTO `normal_range` VALUES (20, 40, 75);
INSERT INTO `normal_range` VALUES (21, 0, 3);
INSERT INTO `normal_range` VALUES (22, 5.4, 8.4);
INSERT INTO `normal_range` VALUES (23, 2.8, 7.2);
INSERT INTO `normal_range` VALUES (24, 59, 104);
INSERT INTO `normal_range` VALUES (25, 208, 428);
INSERT INTO `normal_range` VALUES (26, 4.27, 6.07);
INSERT INTO `normal_range` VALUES (27, 3.9, 6.1);
INSERT INTO `normal_range` VALUES (28, 0, 5);
INSERT INTO `normal_range` VALUES (29, 0, 5);
INSERT INTO `normal_range` VALUES (30, 0, 10);
INSERT INTO `normal_range` VALUES (31, 0, 15);
INSERT INTO `normal_range` VALUES (32, 0, 3.3);
INSERT INTO `normal_range` VALUES (33, 0, 20);
INSERT INTO `normal_range` VALUES (34, 0, 35);
INSERT INTO `normal_range` VALUES (35, 0, 37);
INSERT INTO `normal_range` VALUES (36, 0, 20);
INSERT INTO `normal_range` VALUES (37, 0, 28);
INSERT INTO `normal_range` VALUES (38, 0, 10);
INSERT INTO `normal_range` VALUES (39, 0, 64);

-- ----------------------------
-- Table structure for package
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '套餐名称',
  `price` smallint NOT NULL COMMENT '套餐价格',
  `applicable_group` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '适用人群',
  `img_src` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES (1, '全身体检', 1000, '一般人', 'QuanShen.jpg');
INSERT INTO `package` VALUES (2, '无', 0, '人', NULL);
INSERT INTO `package` VALUES (3, '基础一', 917, '所有人', NULL);
INSERT INTO `package` VALUES (4, '常规体检', 666, '所有人', 'ChangGui.jpg');
INSERT INTO `package` VALUES (5, '老年体检', 555, '老年人', 'LaoNian.jpg');
INSERT INTO `package` VALUES (6, '入职体检', 288, '职场人', 'RuZhi.jpg');
INSERT INTO `package` VALUES (7, '父母体检', 888, '中年人', 'FuMu.jpg');

-- ----------------------------
-- Table structure for package_category
-- ----------------------------
DROP TABLE IF EXISTS `package_category`;
CREATE TABLE `package_category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `package_id` int NOT NULL COMMENT '套餐id',
  `category_id` int NOT NULL COMMENT '分类id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `package_id`(`package_id` ASC) USING BTREE,
  CONSTRAINT `package_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `package_category_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `package` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of package_category
-- ----------------------------
INSERT INTO `package_category` VALUES (1, 1, 1);
INSERT INTO `package_category` VALUES (2, 1, 2);
INSERT INTO `package_category` VALUES (3, 1, 3);
INSERT INTO `package_category` VALUES (4, 1, 4);
INSERT INTO `package_category` VALUES (5, 1, 5);
INSERT INTO `package_category` VALUES (6, 1, 6);
INSERT INTO `package_category` VALUES (7, 1, 7);
INSERT INTO `package_category` VALUES (8, 1, 8);
INSERT INTO `package_category` VALUES (10, 1, 9);
INSERT INTO `package_category` VALUES (11, 1, 11);
INSERT INTO `package_category` VALUES (12, 1, 12);
INSERT INTO `package_category` VALUES (13, 1, 13);
INSERT INTO `package_category` VALUES (14, 1, 14);
INSERT INTO `package_category` VALUES (15, 2, 15);
INSERT INTO `package_category` VALUES (16, 3, 2);
INSERT INTO `package_category` VALUES (17, 3, 3);
INSERT INTO `package_category` VALUES (19, 3, 1);
INSERT INTO `package_category` VALUES (20, 3, 3);
INSERT INTO `package_category` VALUES (21, 3, 5);
INSERT INTO `package_category` VALUES (22, 3, 7);
INSERT INTO `package_category` VALUES (24, 5, 2);
INSERT INTO `package_category` VALUES (25, 5, 4);
INSERT INTO `package_category` VALUES (26, 5, 6);
INSERT INTO `package_category` VALUES (27, 5, 7);
INSERT INTO `package_category` VALUES (28, 5, 8);
INSERT INTO `package_category` VALUES (30, 5, 9);
INSERT INTO `package_category` VALUES (31, 5, 12);
INSERT INTO `package_category` VALUES (32, 5, 13);
INSERT INTO `package_category` VALUES (33, 5, 14);
INSERT INTO `package_category` VALUES (34, 6, 2);
INSERT INTO `package_category` VALUES (35, 6, 3);
INSERT INTO `package_category` VALUES (36, 6, 4);
INSERT INTO `package_category` VALUES (37, 6, 5);
INSERT INTO `package_category` VALUES (38, 6, 7);
INSERT INTO `package_category` VALUES (40, 6, 9);
INSERT INTO `package_category` VALUES (41, 7, 1);
INSERT INTO `package_category` VALUES (42, 7, 2);
INSERT INTO `package_category` VALUES (43, 7, 3);
INSERT INTO `package_category` VALUES (44, 7, 4);
INSERT INTO `package_category` VALUES (45, 7, 5);
INSERT INTO `package_category` VALUES (46, 7, 6);
INSERT INTO `package_category` VALUES (47, 7, 8);
INSERT INTO `package_category` VALUES (49, 7, 9);
INSERT INTO `package_category` VALUES (50, 7, 11);
INSERT INTO `package_category` VALUES (51, 7, 12);
INSERT INTO `package_category` VALUES (52, 7, 13);
INSERT INTO `package_category` VALUES (53, 7, 14);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
  `parent_id` int NOT NULL COMMENT '父级权限id',
  `level` smallint NOT NULL COMMENT '权限层级',
  `path` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '对应的前端路由名称',
  `component` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对应的前端组件名称',
  `icon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对应的图标名称',
  `index` smallint NULL DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '目录', -1, 0, '/examination', 'Layout', NULL, 1);
INSERT INTO `permission` VALUES (2, '用户管理', 1, 1, '/user', '', 'User', 2);
INSERT INTO `permission` VALUES (3, '套餐管理', 1, 1, '/package', '', 'Package', 3);
INSERT INTO `permission` VALUES (4, '订单管理', 1, 1, '/order', '', 'Order', 4);
INSERT INTO `permission` VALUES (5, '体检机构管理', 1, 1, '/center', 'Center', 'Center', 5);
INSERT INTO `permission` VALUES (6, '科室管理', 1, 1, '/department', '', 'Department', 6);
INSERT INTO `permission` VALUES (7, '前台用户', 2, 2, '/user', 'User', NULL, 1);
INSERT INTO `permission` VALUES (8, '后台用户', 2, 2, '/admin', 'Admin', NULL, 2);
INSERT INTO `permission` VALUES (9, '权限列表', 24, 2, '/permission', 'Permission', '', 2);
INSERT INTO `permission` VALUES (10, '角色列表', 24, 2, '/role', 'Role', '', 1);
INSERT INTO `permission` VALUES (11, '套餐管理', 3, 2, '/package', 'Package', NULL, 1);
INSERT INTO `permission` VALUES (12, '分类列表', 3, 2, '/category', 'Category', NULL, 2);
INSERT INTO `permission` VALUES (13, '个人订单', 4, 2, '/order', 'Order', NULL, 1);
INSERT INTO `permission` VALUES (14, '团检订单', 4, 2, '/groupOrder', 'GroupOrder', NULL, 2);
INSERT INTO `permission` VALUES (15, '医生详情', 6, 2, '/department', 'Department', '', 1);
INSERT INTO `permission` VALUES (16, '心血管内科', 6, 2, '/department9', 'Department9', NULL, 2);
INSERT INTO `permission` VALUES (17, '神经内科', 6, 2, '/department10', 'Department10', NULL, 3);
INSERT INTO `permission` VALUES (18, '血液内科', 6, 2, '/department14', 'Department14', NULL, 4);
INSERT INTO `permission` VALUES (19, '眼科', 6, 2, '/department16', 'Department16', NULL, 5);
INSERT INTO `permission` VALUES (20, '耳鼻喉科', 6, 2, '/department17', 'Department17', NULL, 6);
INSERT INTO `permission` VALUES (21, '普外科', 6, 2, '/department19', 'Department19', NULL, 7);
INSERT INTO `permission` VALUES (22, '超声科', 6, 2, '/department24', 'Department24', NULL, 8);
INSERT INTO `permission` VALUES (23, '体检科', 6, 2, '/department25', 'Department25', NULL, 9);
INSERT INTO `permission` VALUES (24, '权限管理', 1, 1, '/permission', '', 'Permission', 1);

-- ----------------------------
-- Table structure for queue
-- ----------------------------
DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL COMMENT '科室id',
  `serial_number` smallint NOT NULL COMMENT '序号(表明排队顺序)',
  `order_id` int NOT NULL COMMENT '订单id',
  `time` int NULL DEFAULT NULL COMMENT '排队时长',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  CONSTRAINT `queue_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `queue_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `examination_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of queue
-- ----------------------------
INSERT INTO `queue` VALUES (170, 9, 30, 29, 30);
INSERT INTO `queue` VALUES (171, 10, 31, 29, 30);
INSERT INTO `queue` VALUES (172, 14, 32, 29, 30);
INSERT INTO `queue` VALUES (173, 19, 35, 29, 30);
INSERT INTO `queue` VALUES (174, 16, 33, 29, 30);
INSERT INTO `queue` VALUES (175, 17, 34, 29, 30);

-- ----------------------------
-- Table structure for relationship
-- ----------------------------
DROP TABLE IF EXISTS `relationship`;
CREATE TABLE `relationship`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关系名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of relationship
-- ----------------------------
INSERT INTO `relationship` VALUES (1, '本人');
INSERT INTO `relationship` VALUES (2, '父亲');
INSERT INTO `relationship` VALUES (3, '母亲');

-- ----------------------------
-- Table structure for result_text_option
-- ----------------------------
DROP TABLE IF EXISTS `result_text_option`;
CREATE TABLE `result_text_option`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '结果选项内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of result_text_option
-- ----------------------------
INSERT INTO `result_text_option` VALUES (1, '——');
INSERT INTO `result_text_option` VALUES (2, '正常');
INSERT INTO `result_text_option` VALUES (3, '未见异常');
INSERT INTO `result_text_option` VALUES (4, '无');
INSERT INTO `result_text_option` VALUES (5, '无畸形');
INSERT INTO `result_text_option` VALUES (6, '规则');
INSERT INTO `result_text_option` VALUES (7, '正常心电图');
INSERT INTO `result_text_option` VALUES (8, 'neg');
INSERT INTO `result_text_option` VALUES (9, '透明');
INSERT INTO `result_text_option` VALUES (10, '未查见');
INSERT INTO `result_text_option` VALUES (11, '黄色');
INSERT INTO `result_text_option` VALUES (12, '请输入');
INSERT INTO `result_text_option` VALUES (13, '80');
INSERT INTO `result_text_option` VALUES (14, '9999');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `description` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '获得所有权限');
INSERT INTO `role` VALUES (19, '前台', '医院前台');
INSERT INTO `role` VALUES (20, '科室主任', '管理科室的医生');
INSERT INTO `role` VALUES (21, '业务员', '管理订单');
INSERT INTO `role` VALUES (22, '心血管内科医生', '做心电图');
INSERT INTO `role` VALUES (23, '神经内科医生', '内科检查');
INSERT INTO `role` VALUES (24, '血液内科医生', '抽血');
INSERT INTO `role` VALUES (25, '眼科医生', '测视力');
INSERT INTO `role` VALUES (26, '耳鼻喉科医生', '检查');
INSERT INTO `role` VALUES (27, '普外科医生', '外科检查');
INSERT INTO `role` VALUES (28, '超声科医生', '做超声');
INSERT INTO `role` VALUES (29, '体检科医生', '其它');
INSERT INTO `role` VALUES (34, '测试角色', '测试');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_id` int NOT NULL COMMENT '权限id',
  `role_id` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `permission_id`(`permission_id` ASC) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 1, 1);
INSERT INTO `role_permission` VALUES (2, 24, 1);
INSERT INTO `role_permission` VALUES (3, 2, 1);
INSERT INTO `role_permission` VALUES (4, 3, 1);
INSERT INTO `role_permission` VALUES (5, 4, 1);
INSERT INTO `role_permission` VALUES (6, 5, 1);
INSERT INTO `role_permission` VALUES (7, 6, 1);
INSERT INTO `role_permission` VALUES (8, 7, 1);
INSERT INTO `role_permission` VALUES (9, 8, 1);
INSERT INTO `role_permission` VALUES (10, 9, 1);
INSERT INTO `role_permission` VALUES (11, 10, 1);
INSERT INTO `role_permission` VALUES (12, 11, 1);
INSERT INTO `role_permission` VALUES (13, 12, 1);
INSERT INTO `role_permission` VALUES (14, 13, 1);
INSERT INTO `role_permission` VALUES (15, 14, 1);
INSERT INTO `role_permission` VALUES (20, 1, 19);
INSERT INTO `role_permission` VALUES (21, 2, 19);
INSERT INTO `role_permission` VALUES (22, 7, 19);
INSERT INTO `role_permission` VALUES (23, 1, 20);
INSERT INTO `role_permission` VALUES (24, 6, 20);
INSERT INTO `role_permission` VALUES (25, 1, 21);
INSERT INTO `role_permission` VALUES (26, 4, 21);
INSERT INTO `role_permission` VALUES (27, 13, 21);
INSERT INTO `role_permission` VALUES (28, 15, 1);
INSERT INTO `role_permission` VALUES (29, 16, 1);
INSERT INTO `role_permission` VALUES (30, 17, 1);
INSERT INTO `role_permission` VALUES (31, 18, 1);
INSERT INTO `role_permission` VALUES (32, 19, 1);
INSERT INTO `role_permission` VALUES (33, 20, 1);
INSERT INTO `role_permission` VALUES (34, 21, 1);
INSERT INTO `role_permission` VALUES (35, 22, 1);
INSERT INTO `role_permission` VALUES (36, 23, 1);
INSERT INTO `role_permission` VALUES (37, 16, 22);
INSERT INTO `role_permission` VALUES (38, 17, 23);
INSERT INTO `role_permission` VALUES (39, 18, 24);
INSERT INTO `role_permission` VALUES (40, 19, 25);
INSERT INTO `role_permission` VALUES (41, 20, 26);
INSERT INTO `role_permission` VALUES (42, 21, 27);
INSERT INTO `role_permission` VALUES (43, 22, 28);
INSERT INTO `role_permission` VALUES (44, 23, 29);
INSERT INTO `role_permission` VALUES (45, 15, 20);
INSERT INTO `role_permission` VALUES (46, 1, 22);
INSERT INTO `role_permission` VALUES (47, 6, 22);
INSERT INTO `role_permission` VALUES (48, 1, 23);
INSERT INTO `role_permission` VALUES (49, 6, 23);
INSERT INTO `role_permission` VALUES (50, 1, 24);
INSERT INTO `role_permission` VALUES (51, 6, 24);
INSERT INTO `role_permission` VALUES (52, 1, 25);
INSERT INTO `role_permission` VALUES (53, 6, 25);
INSERT INTO `role_permission` VALUES (54, 1, 26);
INSERT INTO `role_permission` VALUES (55, 6, 26);
INSERT INTO `role_permission` VALUES (56, 1, 27);
INSERT INTO `role_permission` VALUES (57, 6, 27);
INSERT INTO `role_permission` VALUES (58, 1, 28);
INSERT INTO `role_permission` VALUES (59, 6, 28);
INSERT INTO `role_permission` VALUES (60, 1, 29);
INSERT INTO `role_permission` VALUES (61, 6, 29);
INSERT INTO `role_permission` VALUES (66, 6, 34);
INSERT INTO `role_permission` VALUES (67, 15, 34);
INSERT INTO `role_permission` VALUES (68, 16, 34);
INSERT INTO `role_permission` VALUES (69, 17, 34);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户姓名',
  `identification_number` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号码',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (11, '张雨绮', '230293847123112312', '女', '2011-02-12', '18937829582', '2024-01-19 11:46:29');
INSERT INTO `user` VALUES (21, '洛南', '310112200106087213', '女', '2011-02-12', '18773703523', '2024-01-21 23:58:50');
INSERT INTO `user` VALUES (22, '王思博', '310112462738193721', '男', '2011-02-12', '13829223132', '2024-01-21 23:58:50');
INSERT INTO `user` VALUES (23, '丁欣欣', '310201197902044427', '男', '1989-01-01', '13291625628', '2024-03-05 11:32:10');
INSERT INTO `user` VALUES (24, '张涛', '620101200211211021', '男', '2007-01-01', '13720999653', '2024-03-05 16:49:38');

SET FOREIGN_KEY_CHECKS = 1;
