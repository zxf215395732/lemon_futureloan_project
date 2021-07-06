/*
Navicat MySQL Data Transfer

Source Server         : 本地mysql5.7
Source Server Version : 50728
Source Host           : localhost:3316
Source Database       : futureloan

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2021-05-20 17:53:29
*/
grant all on *.* to root@'%' identified by 'Lemon123456!' with grant option;

flush privileges; 

create database futureloan;

use futureloan;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `financelog`
-- ----------------------------
DROP TABLE IF EXISTS `financelog`;
CREATE TABLE `financelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '实际回款日期',
  `pay_member_id` varchar(32) NOT NULL DEFAULT '0' COMMENT '支付用户id',
  `income_member_id` varchar(32) NOT NULL DEFAULT '0' COMMENT '进账用户id',
  `amount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '交易金额',
  `income_member_money` decimal(18,2) DEFAULT NULL COMMENT '进账用户余额，进账后余额',
  `pay_member_money` decimal(18,2) DEFAULT NULL COMMENT '支付用户余额，支付后余额',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 状态：0-冻结、1-正常、2-作废',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金记录表';

-- ----------------------------
-- Records of financelog
-- ----------------------------

-- ----------------------------
-- Table structure for `invest`
-- ----------------------------
DROP TABLE IF EXISTS `invest`;
CREATE TABLE `invest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(32) NOT NULL COMMENT '用户id',
  `loan_id` varchar(32) NOT NULL COMMENT '标id',
  `amount` decimal(18,2) NOT NULL COMMENT '投资金额',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_valid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有效：0无效  1有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资记录表';

-- ----------------------------
-- Records of invest
-- ----------------------------

-- ----------------------------
-- Table structure for `loan`
-- ----------------------------
DROP TABLE IF EXISTS `loan`;
CREATE TABLE `loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(32) NOT NULL COMMENT '用户id',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `amount` decimal(18,2) NOT NULL COMMENT '借款金额',
  `loan_rate` decimal(3,1) NOT NULL COMMENT '年利率,如年化18.0%，存储为18.0',
  `loan_term` tinyint(1) NOT NULL COMMENT '借款期限 如6个月为6，30天为30',
  `loan_date_type` tinyint(1) NOT NULL COMMENT '借款期限类型,借款期限单位  1-按月 2-按天',
  `bidding_days` tinyint(1) NOT NULL DEFAULT '5' COMMENT '竞标天数',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `bidding_start_time` timestamp NULL DEFAULT NULL COMMENT '竞标开始时间',
  `full_time` timestamp NULL DEFAULT NULL COMMENT '满标时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '项目状态  1:审核中 2:竞标中 3:还款中 4:还款完成 5:审核不通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目表';

-- ----------------------------
-- Records of loan
-- ----------------------------

-- ----------------------------
-- Table structure for `member`
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reg_name` varchar(50) NOT NULL COMMENT '会员用户名',
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  `mobile_phone` varchar(20) NOT NULL COMMENT '手机号码',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1普通会员 2内部员工 5测试用户',
  `leave_amount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '可用余额',
  `reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id唯一索引` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of member
-- ----------------------------

-- ----------------------------
-- Table structure for `repayment`
-- ----------------------------
DROP TABLE IF EXISTS `repayment`;
CREATE TABLE `repayment` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL,
  `invest_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '投资id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `terms` tinyint(1) NOT NULL COMMENT '回款期次,如6表示第6期回款',
  `unfinished_principal` decimal(18,2) NOT NULL COMMENT '待还本金',
  `unfinished_interest` decimal(18,2) NOT NULL COMMENT '待还利息',
  `repayment_date` date DEFAULT NULL COMMENT '回款日期',
  `actual_repayment_date` date DEFAULT NULL COMMENT '实际回款日期',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '回款状态 还款状态:0-未还，1-部分已还，2-全额已还，3-作废',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of repayment
-- ----------------------------
