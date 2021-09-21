/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : rapidwms

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 19/09/2021 17:01:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for avatar
-- ----------------------------
DROP TABLE IF EXISTS `avatar`;
CREATE TABLE `avatar`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '上传日期',
  `delete_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除的URL',
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `height` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片高度',
  `size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片大小',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `width` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片宽度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of avatar
-- ----------------------------

-- ----------------------------
-- Table structure for email_config
-- ----------------------------
DROP TABLE IF EXISTS `email_config`;
CREATE TABLE `email_config`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人',
  `host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件服务器SMTP地址',
  `pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发件者用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of email_config
-- ----------------------------

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `exception_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `log_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `request_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `time` bigint(0) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1779 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (1780, '2021-09-19 16:18:25', '用户登录', NULL, 'INFO', 'org.mstudio.modules.security.rest.AuthenticationController.login()', '{ authorizationUser: {username=admin, password= ******} }', '127.0.0.1', 426, 'admin');
INSERT INTO `log` VALUES (1781, '2021-09-19 16:18:57', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, coefficient=null, roles=null, customers=null, num=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 41, 'admin');
INSERT INTO `log` VALUES (1782, '2021-09-19 16:21:34', '物流统计', NULL, 'INFO', 'org.mstudio.modules.wms.Logistics.rest.LogisticsDetailController.statistics()', '{ startDate: null endDate: null search: null pageable: Page request [number: 0, size 10, sort: UNSORTED] }', '127.0.0.1', 11, 'admin');
INSERT INTO `log` VALUES (1783, '2021-09-19 16:25:21', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, coefficient=null, roles=null, customers=null, num=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 23, 'admin');
INSERT INTO `log` VALUES (1784, '2021-09-19 16:26:06', '物流统计', NULL, 'INFO', 'org.mstudio.modules.wms.Logistics.rest.LogisticsDetailController.statistics()', '{ startDate: null endDate: null search: null pageable: Page request [number: 0, size 10, sort: UNSORTED] }', '127.0.0.1', 9, 'admin');
INSERT INTO `log` VALUES (1785, '2021-09-19 16:26:35', '查询菜单', NULL, 'INFO', 'org.mstudio.modules.system.rest.MenuController.getMenus()', '{ name: null }', '127.0.0.1', 11, 'admin');
INSERT INTO `log` VALUES (1786, '2021-09-19 16:39:24', '查询权限', NULL, 'INFO', 'org.mstudio.modules.system.rest.PermissionController.getPermissions()', '{ name: null }', '127.0.0.1', 24, 'admin');
INSERT INTO `log` VALUES (1787, '2021-09-19 16:39:30', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 43, 'admin');
INSERT INTO `log` VALUES (1788, '2021-09-19 16:39:52', '更新角色菜单', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.updateMenu()', '{ resources: Role{id=1, name=\'null\', remark=\'null\', createDateTime=null} }', '127.0.0.1', 18, 'admin');
INSERT INTO `log` VALUES (1789, '2021-09-19 16:39:52', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 24, 'admin');
INSERT INTO `log` VALUES (1790, '2021-09-19 16:39:58', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 2, 'admin');
INSERT INTO `log` VALUES (1791, '2021-09-19 16:43:14', '物流统计', NULL, 'INFO', 'org.mstudio.modules.wms.Logistics.rest.LogisticsDetailController.statistics()', '{ startDate: null endDate: null search: null pageable: Page request [number: 0, size 10, sort: UNSORTED] }', '127.0.0.1', 6, 'admin');
INSERT INTO `log` VALUES (1792, '2021-09-19 16:55:00', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, coefficient=null, roles=null, customers=null, num=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 19, 'admin');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `i_frame` bit(1) NULL DEFAULT NULL COMMENT '是否外链',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `pid` bigint(0) NOT NULL COMMENT '上级菜单ID',
  `sort` bigint(0) NOT NULL COMMENT '排序',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '2018-12-18 15:11:29', b'0', '系统管理', NULL, 0, 20, 'setting', 'system');
INSERT INTO `menu` VALUES (2, '2018-12-18 15:14:44', b'0', '用户管理', 'system/user/index', 1, 2, 'user', '/system/user');
INSERT INTO `menu` VALUES (3, '2018-12-18 15:16:07', b'0', '角色管理', 'system/role/index', 1, 3, 'team', '/system/role');
INSERT INTO `menu` VALUES (4, '2018-12-18 15:16:45', b'0', '权限管理', 'system/permission/index', 1, 4, 'solution', '/system/permission');
INSERT INTO `menu` VALUES (5, '2018-12-18 15:17:28', b'0', '菜单管理', 'system/menu/index', 1, 5, 'bars', '/system/menu');
INSERT INTO `menu` VALUES (6, '2018-12-18 15:17:48', b'0', '系统监控', NULL, 0, 10, 'monitor', 'monitor');
INSERT INTO `menu` VALUES (7, '2018-12-18 15:18:26', b'0', '操作日志', 'monitor/log/index', 6, 11, 'profile', '/monitor/log');
INSERT INTO `menu` VALUES (8, '2018-12-18 15:19:01', b'0', '系统缓存', 'monitor/redis/index', 6, 14, 'shop', '/monitor/redis');
INSERT INTO `menu` VALUES (9, '2018-12-18 15:19:34', b'1', 'SQL监控', NULL, 6, 15, 'branches', 'http://localhost:8000/druid');
INSERT INTO `menu` VALUES (12, '2018-12-24 20:37:35', b'0', '服务器控制台', 'monitor/log/msg', 6, 16, 'table', '/monitor/console');
INSERT INTO `menu` VALUES (28, '2019-01-07 20:34:40', b'0', '定时任务', 'system/job/index', 1, 6, 'check-circle', '/system/job');
INSERT INTO `menu` VALUES (30, '2019-01-11 15:45:55', b'0', '个人中心', 'system/profile', 1, 8, 'audit', '/system/profile');
INSERT INTO `menu` VALUES (32, '2019-01-13 13:49:03', b'0', '异常日志', 'monitor/error/index', 6, 12, 'thunderbolt', '/monitor/error');
INSERT INTO `menu` VALUES (33, '2019-04-03 11:59:12', b'0', '任务日志', 'monitor/jobLog', 6, 13, 'line-chart', '/monitor/jobLog');
INSERT INTO `menu` VALUES (34, '2019-04-04 16:41:54', b'0', '基础设置', NULL, 0, 3, 'shop', 'Infrastructure');
INSERT INTO `menu` VALUES (35, '2019-04-04 16:46:58', b'0', '客户管理', '/goods/customer', 62, 2, 'solution', '/goods/customer');
INSERT INTO `menu` VALUES (36, '2019-04-04 16:47:42', b'0', '客户商品管理', '/goods/goods', 62, 1, 'gift', '/goods/goods');
INSERT INTO `menu` VALUES (37, '2019-04-08 02:12:35', b'0', '商品种类管理', '/infrastructure/goodsType', 34, 7, 'branches', '/infrastructure/goodsType');
INSERT INTO `menu` VALUES (39, '2019-04-09 00:04:42', b'0', '分区管理', '/Stock/Stock', 41, 2, 'gold', '/warehouse/wareZone');
INSERT INTO `menu` VALUES (40, '2019-04-09 00:06:00', b'0', '库位管理', '/warehouse/warePosition', 41, 2, 'reconciliation', '/warehouse/warePosition');
INSERT INTO `menu` VALUES (41, '2019-04-09 09:40:23', b'0', '仓库管理', NULL, 0, 2, 'inbox', 'warehouse');
INSERT INTO `menu` VALUES (42, '2019-04-09 09:41:32', b'0', '实时库存管理', '/inventory/stock', 65, 1, 'exception', '/inventory/stock');
INSERT INTO `menu` VALUES (43, '2019-04-09 14:58:56', b'0', '销售订单管理', '', 0, 7, 'dollar', 'order');
INSERT INTO `menu` VALUES (44, '2019-04-09 15:00:16', b'0', '订单管理', '/order/order', 43, 1, 'schedule', '/order/order');
INSERT INTO `menu` VALUES (45, '2019-04-09 15:04:21', b'0', '入库管理', '/aog/receiveGoods', 66, 1, 'appstore', '/aog/receiveGoods');
INSERT INTO `menu` VALUES (47, '2019-04-09 15:06:48', b'0', '库存流水管理', '/inventory/stockFlow', 65, 2, 'read', '/inventory/stockFlow');
INSERT INTO `menu` VALUES (48, '2019-04-09 15:11:17', b'0', '出库管理', NULL, 0, 8, 'select', 'transit');
INSERT INTO `menu` VALUES (49, '2019-04-09 15:13:48', b'0', '打包管理', '/transit/pack', 48, 2, 'medicine-box', '/transit/pack');
INSERT INTO `menu` VALUES (50, '2019-04-09 15:19:19', b'0', '新增打包', '/transit/addPack', 48, 3, 'build', '/transit/addPack');
INSERT INTO `menu` VALUES (52, '2019-04-29 23:44:12', b'0', '新增订单', '/order/addOrder', 43, 3, 'exception', '/order/addOrder');
INSERT INTO `menu` VALUES (53, '2019-04-29 23:45:43', b'0', '导入订单', '/order/importOrder', 43, 4, 'cloud-upload', '/order/importOrder');
INSERT INTO `menu` VALUES (54, '2019-04-29 23:47:41', b'0', '配送门店管理', '/logistics/address', 68, 4, 'car', '/logistics/address');
INSERT INTO `menu` VALUES (55, '2019-05-07 15:38:57', b'0', '订单出库流水查询', '/order/stockFlow', 43, 5, 'cluster', '/order/stockFlow');
INSERT INTO `menu` VALUES (56, '2019-05-15 15:06:03', b'0', '拣货确认', '/transit/confirmOrder', 48, 1, 'schedule', '/transit/confirmOrder');
INSERT INTO `menu` VALUES (57, '2019-05-16 11:44:01', b'0', '数据表盘', NULL, 0, 21, 'dashboard', 'dashboard');
INSERT INTO `menu` VALUES (58, '2019-05-16 11:44:41', b'0', '今日看板', '/dashboard/analysis', 57, 1, 'alert', '/dashboard/analysis');
INSERT INTO `menu` VALUES (59, '2019-07-08 10:36:01', b'0', '已完成订单报表', '/order/completeOrder', 43, 2, 'check-circle', '/order/completeOrder');
INSERT INTO `menu` VALUES (60, '2019-07-09 10:45:11', b'0', '门店类别管理', '/logistics/addressType', 68, 5, 'layout', '/logistics/addressType');
INSERT INTO `menu` VALUES (61, '2019-09-28 19:01:10', b'0', '订单客户名称管理', '/infrastructure/store', 34, 8, 'usergroup-add', '/infrastructure/store');
INSERT INTO `menu` VALUES (62, '2020-11-30 10:44:54', b'0', '商品管理', NULL, 0, 1, 'shopping', 'goods');
INSERT INTO `menu` VALUES (65, '2020-11-30 11:05:58', b'0', '库存管理', NULL, 0, 4, 'deployment-unit', 'inventory');
INSERT INTO `menu` VALUES (66, '2020-11-30 11:10:25', b'0', '到货管理', NULL, 0, 6, 'shopping-cart', 'aog');
INSERT INTO `menu` VALUES (68, '2020-11-30 11:18:57', b'0', '物流管理', NULL, 0, 9, 'shopping-cart', 'logistics');
INSERT INTO `menu` VALUES (69, '2020-12-05 15:30:13', b'0', '计件管理', '', 0, 15, 'calculator', 'piece');
INSERT INTO `menu` VALUES (70, '2020-12-05 15:31:24', b'0', '拣配复核系数', '/piece/pickMatch', 69, 1, 'file', '/piece/pickMatch');
INSERT INTO `menu` VALUES (71, '2020-12-07 02:01:25', b'0', '拣配复核统计', '/piece/pickMatchStatistics', 69, 2, 'project', '/piece/pickMatchStatistics');
INSERT INTO `menu` VALUES (72, '2020-12-08 23:27:43', b'0', '配送计件系数', '/piece/dispatch', 69, 3, 'file', '/piece/dispatch');
INSERT INTO `menu` VALUES (73, '2020-12-08 23:28:16', b'0', '配送计件统计', '/piece/dispatchStatistics', 69, 5, 'project', '/piece/dispatchStatistics');
INSERT INTO `menu` VALUES (74, '2020-12-09 00:17:34', b'0', '配送系统系数', '/piece/dispatchSys', 69, 4, 'file', '/piece/dispatchSys');
INSERT INTO `menu` VALUES (75, '2020-12-15 01:43:09', b'0', '收货管理', '/aog/unloadReceiveGoods', 66, 3, 'tool', '/aog/unloadReceiveGoods');
INSERT INTO `menu` VALUES (76, '2020-12-15 14:58:38', b'0', '入库计件系数', '/piece/receiveGoodsPiece', 69, 6, 'folder', '/piece/receiveGoodsPiece');
INSERT INTO `menu` VALUES (77, '2020-12-15 16:07:41', b'0', '入库计件统计', '/piece/receiveGoodsPieceStatistics', 69, 7, 'project', '/piece/receiveGoodsPieceStatistics');
INSERT INTO `menu` VALUES (78, '2020-12-17 23:49:22', b'0', '固定资产管理', '', 0, 11, 'safety', 'fixedEstate');
INSERT INTO `menu` VALUES (79, '2020-12-17 23:52:41', b'0', '固定资产', '/fixedEstate/fixedEstate', 78, 1, 'safety', '/fixedEstate/fixedEstate');
INSERT INTO `menu` VALUES (80, '2020-12-19 01:49:40', b'0', '车辆管理', NULL, 0, 12, 'car', 'car');
INSERT INTO `menu` VALUES (81, '2020-12-19 01:50:34', b'0', '车辆信息管理', '/carBasic/carBasic', 80, 1, 'file-text', '/carBasic/carBasic');
INSERT INTO `menu` VALUES (82, '2020-12-19 01:51:13', b'0', '车辆费用管理', '/carBasic/carCost', 80, 2, 'dollar', '/carBasic/carCost');
INSERT INTO `menu` VALUES (83, '2021-01-09 04:51:37', b'0', '物流结算', NULL, 0, 20, 'dollar', 'logisticses');
INSERT INTO `menu` VALUES (84, '2021-01-09 04:53:02', b'0', '模板管理', '/logisticses/logisticsTemplate', 83, 1, 'trademark', '/logisticses/logisticsTemplate');
INSERT INTO `menu` VALUES (85, '2021-01-09 04:54:35', b'0', '结算管理', '/logisticses/logisticsDetail', 83, 1, 'dollar', '/logisticses/logisticsDetail');
INSERT INTO `menu` VALUES (86, '2021-03-03 02:51:55', b'0', '物流统计', '/logisticses/logisticsStatistics', 83, 3, 'pay-circle', '/logisticses/logisticsStatistics');
INSERT INTO `menu` VALUES (87, '2021-03-30 07:46:20', b'0', '单品库存统计', '/inventory/singleStock', 65, 3, 'project', '/inventory/singleStock');
INSERT INTO `menu` VALUES (88, '2021-03-30 07:49:21', b'0', '盘点表', '/inventory/countStock', 65, 4, 'file-search', '/inventory/countStock');
INSERT INTO `menu` VALUES (89, '2021-04-04 14:58:03', b'0', '计件统计', '/piece/dispatchStatisticsAll', 69, 1, 'project', '/piece/dispatchStatisticsAll');
INSERT INTO `menu` VALUES (90, '2021-05-04 00:13:54', b'0', '地区管理', '/logistics/addressArea', 68, 3, 'environment', '/logistics/addressArea');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '别名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `pid` int(0) NOT NULL COMMENT '上级权限',
  `sort` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '超级管理员', '2018-12-03 12:27:48', 'ADMIN', 0, 1);
INSERT INTO `permission` VALUES (40, '数据看板所有权限', '2019-04-07 22:18:01', 'KPI_ALL', 0, 1);
INSERT INTO `permission` VALUES (41, '销售管理所有权限', '2019-05-15 13:11:09', 'ORDER_ALL', 0, 1);
INSERT INTO `permission` VALUES (42, '仓储管理所有权限', '2019-05-15 13:11:30', 'WARE_HOUSE_ALL', 0, 1);
INSERT INTO `permission` VALUES (43, '物流管理所有权限', '2019-05-15 13:11:46', 'TRANSIT_ALL', 0, 1);
INSERT INTO `permission` VALUES (44, '基础设置所有权限', '2019-05-15 13:12:52', 'SETTING_ALL', 0, 1);
INSERT INTO `permission` VALUES (45, '订单列表', '2019-05-15 13:31:51', 'O_ORDER_LIST', 41, 1);
INSERT INTO `permission` VALUES (46, '订单增改', '2019-05-15 13:32:28', 'O_ORDER_EDIT', 41, 2);
INSERT INTO `permission` VALUES (47, '订单删除', '2019-05-15 13:33:00', 'O_ORDER_DELETE', 41, 3);
INSERT INTO `permission` VALUES (48, '库存列表', '2019-05-15 13:33:46', 'W_STOCK_LIST', 42, 1);
INSERT INTO `permission` VALUES (49, '库存增改', '2019-05-15 13:34:34', 'W_STOCK_EDIT', 42, 2);
INSERT INTO `permission` VALUES (52, '订单分拣商品', '2019-05-15 13:35:53', 'T_ORDER_GATHER', 43, 1);
INSERT INTO `permission` VALUES (53, '订单分拣复核', '2019-05-15 13:36:16', 'T_ORDER_CONFIRM', 43, 3);
INSERT INTO `permission` VALUES (55, '浏览打包，打印标签', '2019-05-15 14:36:26', 'T_PACK_LIST', 43, 2);
INSERT INTO `permission` VALUES (56, '打包增改', '2019-05-15 15:56:52', 'T_PACK_EDIT', 43, 4);
INSERT INTO `permission` VALUES (57, '入库列表', '2019-05-16 09:45:24', 'W_RECEIVE_LIST', 42, 3);
INSERT INTO `permission` VALUES (58, '今日看板', '2019-07-03 11:57:48', 'K_TODAY', 40, 1);
INSERT INTO `permission` VALUES (59, '客户商品管理', '2019-07-03 12:01:30', 'S_GOODS', 44, 1);
INSERT INTO `permission` VALUES (60, '商品种类管理', '2019-07-03 12:02:38', 'S_GOODS_TYPE', 44, 2);
INSERT INTO `permission` VALUES (61, '入库增改删', '2019-07-03 12:07:15', 'W_RECEIVE_CRUD', 42, 4);
INSERT INTO `permission` VALUES (62, '入库审核', '2019-07-03 12:08:52', 'W_RECEIVE_AUDIT', 42, 5);
INSERT INTO `permission` VALUES (63, '查看库存流水', '2019-07-04 09:09:17', 'W_STOCK_FLOW_LIST', 42, 6);
INSERT INTO `permission` VALUES (64, '打包删除', '2019-07-04 09:14:24', 'T_PACK_DELETE', 43, 5);
INSERT INTO `permission` VALUES (65, '地址浏览', '2019-07-04 09:15:20', 'S_ADDRESS_LIST', 44, 3);
INSERT INTO `permission` VALUES (66, '地址增改删', '2019-07-04 09:16:00', 'S_ADDRESS_CRUD', 44, 4);
INSERT INTO `permission` VALUES (68, '客户浏览', '2019-07-04 09:18:56', 'S_CUSTOMER_LIST', 44, 6);
INSERT INTO `permission` VALUES (69, '客户增改删', '2019-07-04 09:19:47', 'S_CUSTOMER_CRUD', 44, 7);
INSERT INTO `permission` VALUES (70, '库区浏览', '2019-07-04 09:20:08', 'S_WARE_ZONE_LIST', 44, 8);
INSERT INTO `permission` VALUES (71, '库区增改删', '2019-07-04 09:22:16', 'S_WARE_ZONE_CRUD', 44, 9);
INSERT INTO `permission` VALUES (72, '库位浏览', '2019-07-04 09:22:47', 'S_WARE_POSITION_LIST', 44, 10);
INSERT INTO `permission` VALUES (73, '库位增改删', '2019-07-04 09:23:13', 'S_WARE_POSITION_CRUD', 44, 11);
INSERT INTO `permission` VALUES (74, '订单确认回执', '2019-07-04 11:11:21', 'O_ORDER_COMPLETE', 41, 4);
INSERT INTO `permission` VALUES (75, '订单出库详情浏览', '2019-07-04 11:28:02', 'O_ORDER_STOCK_FLOW', 41, 5);
INSERT INTO `permission` VALUES (76, '指派别人派送的权限', '2019-07-05 12:51:09', 'T_PACK_ASSIGN', 43, 6);
INSERT INTO `permission` VALUES (77, '所有已完成订单报表', '2019-07-08 14:39:33', 'O_ORDER_COMPLETE_LIST', 41, 6);
INSERT INTO `permission` VALUES (78, '地址类别管理', '2019-07-09 10:32:12', 'S_ADDRESS_TYPE', 44, 5);
INSERT INTO `permission` VALUES (79, '订单客户名称列表', '2019-09-28 19:02:19', 'S_STORE_LIST', 44, 12);
INSERT INTO `permission` VALUES (80, '订单客户名称增改删', '2019-09-28 19:03:07', 'S_STORE_CRUD', 44, 13);
INSERT INTO `permission` VALUES (81, '计件管理', '2020-12-07 00:26:35', 'PIECE_ALL', 0, 1);
INSERT INTO `permission` VALUES (82, '固定资产', '2020-12-17 23:50:28', 'FIXED_ALL', 0, 10);
INSERT INTO `permission` VALUES (83, '物流结算模板', '2021-01-09 04:55:54', 'LOGISTICSTEMPLATE_ALL', 0, 1);
INSERT INTO `permission` VALUES (84, '物流结算', '2021-01-09 04:56:33', 'LOGISTICSDETAIL_ALL', 0, 11);

-- ----------------------------
-- Table structure for quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `quartz_job`;
CREATE TABLE `quartz_job`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bean_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Spring Bean名称',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron 表达式',
  `is_pause` bit(1) NULL DEFAULT NULL COMMENT '状态：1暂停、0启用',
  `job_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名称',
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '创建或更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of quartz_job
-- ----------------------------
INSERT INTO `quartz_job` VALUES (1, 'visitsTask', '0 0 0 * * ?', b'0', '更新访客记录', 'run', NULL, '每日0点创建新的访客记录', '2019-01-08 14:53:31');
INSERT INTO `quartz_job` VALUES (2, 'stockQuantityGuaranteeTask', '0 0 3 * * ? *', b'0', '质保实数更新', 'run', '', '每日凌晨3时更新', '2021-01-17 14:58:59');
INSERT INTO `quartz_job` VALUES (3, 'testTask', '0/10 * * * * ? *', b'1', 'TestTask', 'run', NULL, 'q', '2021-01-17 14:26:31');

-- ----------------------------
-- Table structure for quartz_log
-- ----------------------------
DROP TABLE IF EXISTS `quartz_log`;
CREATE TABLE `quartz_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `baen_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `exception_detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_success` bit(1) NULL DEFAULT NULL,
  `job_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 431 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of quartz_log
-- ----------------------------
INSERT INTO `quartz_log` VALUES (383, 'visitsTask', '2020-08-02 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 31);
INSERT INTO `quartz_log` VALUES (384, 'visitsTask', '2020-12-04 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 17);
INSERT INTO `quartz_log` VALUES (385, 'visitsTask', '2020-12-06 19:53:08', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 83);
INSERT INTO `quartz_log` VALUES (386, 'visitsTask', '2020-12-07 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 17);
INSERT INTO `quartz_log` VALUES (387, 'visitsTask', '2020-12-08 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 13);
INSERT INTO `quartz_log` VALUES (388, 'visitsTask', '2020-12-09 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 20);
INSERT INTO `quartz_log` VALUES (389, 'visitsTask', '2020-12-10 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 39);
INSERT INTO `quartz_log` VALUES (390, 'visitsTask', '2020-12-11 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 258);
INSERT INTO `quartz_log` VALUES (391, 'visitsTask', '2020-12-12 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 26);
INSERT INTO `quartz_log` VALUES (392, 'visitsTask', '2020-12-13 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 37);
INSERT INTO `quartz_log` VALUES (393, 'visitsTask', '2020-12-15 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 43);
INSERT INTO `quartz_log` VALUES (394, 'visitsTask', '2020-12-16 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 24);
INSERT INTO `quartz_log` VALUES (395, 'visitsTask', '2020-12-18 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 19);
INSERT INTO `quartz_log` VALUES (396, 'visitsTask', '2021-01-03 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 13);
INSERT INTO `quartz_log` VALUES (397, 'visitsTask', '2021-01-05 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 14);
INSERT INTO `quartz_log` VALUES (398, 'visitsTask', '2021-01-07 00:34:13', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 13);
INSERT INTO `quartz_log` VALUES (399, 'visitsTask', '2021-01-08 05:51:48', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 15);
INSERT INTO `quartz_log` VALUES (400, 'visitsTask', '2021-01-12 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 35);
INSERT INTO `quartz_log` VALUES (401, 'visitsTask', '2021-01-13 01:30:05', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 54);
INSERT INTO `quartz_log` VALUES (402, 'stockQuantityGuaranteeTask', '2021-01-17 14:12:00', '0 10 13 * * ? ', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'stockQuantityGuaranteeTask\' available\r\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:775)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1221)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:294)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199)\r\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1105)\r\n	at org.mstudio.utils.SpringContextHolder.getBean(SpringContextHolder.java:31)\r\n	at org.mstudio.modules.quartz.utils.QuartzRunnable.<init>(QuartzRunnable.java:22)\r\n	at org.mstudio.modules.quartz.utils.ExecutionJob.executeInternal(ExecutionJob.java:55)\r\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\n', b'0', '质保实数更新', 'run', '', 9);
INSERT INTO `quartz_log` VALUES (403, 'stockQuantityGuaranteeTask', '2021-01-17 14:14:00', '0 10 13 * * ? ', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'stockQuantityGuaranteeTask\' available\r\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:775)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1221)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:294)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199)\r\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1105)\r\n	at org.mstudio.utils.SpringContextHolder.getBean(SpringContextHolder.java:31)\r\n	at org.mstudio.modules.quartz.utils.QuartzRunnable.<init>(QuartzRunnable.java:22)\r\n	at org.mstudio.modules.quartz.utils.ExecutionJob.executeInternal(ExecutionJob.java:55)\r\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\n', b'0', '质保实数更新', 'run', '', 2);
INSERT INTO `quartz_log` VALUES (404, 'TestTask', '2021-01-17 14:14:10', '0/10 * * * * ? *', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'TestTask\' available\r\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:775)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1221)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:294)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199)\r\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1105)\r\n	at org.mstudio.utils.SpringContextHolder.getBean(SpringContextHolder.java:31)\r\n	at org.mstudio.modules.quartz.utils.QuartzRunnable.<init>(QuartzRunnable.java:22)\r\n	at org.mstudio.modules.quartz.utils.ExecutionJob.executeInternal(ExecutionJob.java:55)\r\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\n', b'0', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (405, 'TestTask', '2021-01-17 14:18:20', '0/10 * * * * ? *', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'TestTask\' available\r\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:775)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1221)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:294)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199)\r\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1105)\r\n	at org.mstudio.utils.SpringContextHolder.getBean(SpringContextHolder.java:31)\r\n	at org.mstudio.modules.quartz.utils.QuartzRunnable.<init>(QuartzRunnable.java:22)\r\n	at org.mstudio.modules.quartz.utils.ExecutionJob.executeInternal(ExecutionJob.java:55)\r\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\n', b'0', 'TestTask', 'run', NULL, 3);
INSERT INTO `quartz_log` VALUES (406, 'TestTask', '2021-01-17 14:18:50', '0/10 * * * * ? *', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'TestTask\' available\r\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:775)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1221)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:294)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199)\r\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1105)\r\n	at org.mstudio.utils.SpringContextHolder.getBean(SpringContextHolder.java:31)\r\n	at org.mstudio.modules.quartz.utils.QuartzRunnable.<init>(QuartzRunnable.java:22)\r\n	at org.mstudio.modules.quartz.utils.ExecutionJob.executeInternal(ExecutionJob.java:55)\r\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\n', b'0', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (407, 'TestTask', '2021-01-17 14:19:00', '0/10 * * * * ? *', 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'TestTask\' available\r\n	at org.springframework.beans.factory.support.DefaultListableBeanFactory.getBeanDefinition(DefaultListableBeanFactory.java:775)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getMergedLocalBeanDefinition(AbstractBeanFactory.java:1221)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:294)\r\n	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199)\r\n	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1105)\r\n	at org.mstudio.utils.SpringContextHolder.getBean(SpringContextHolder.java:31)\r\n	at org.mstudio.modules.quartz.utils.QuartzRunnable.<init>(QuartzRunnable.java:22)\r\n	at org.mstudio.modules.quartz.utils.ExecutionJob.executeInternal(ExecutionJob.java:55)\r\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\r\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\r\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\r\n', b'0', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (408, 'testTask', '2021-01-17 14:25:40', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 2);
INSERT INTO `quartz_log` VALUES (409, 'testTask', '2021-01-17 14:25:50', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (410, 'testTask', '2021-01-17 14:26:00', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (411, 'testTask', '2021-01-17 14:26:10', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (412, 'testTask', '2021-01-17 14:26:20', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 1);
INSERT INTO `quartz_log` VALUES (413, 'testTask', '2021-01-17 14:26:30', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 0);
INSERT INTO `quartz_log` VALUES (414, 'testTask', '2021-01-17 14:26:31', '0/10 * * * * ? *', NULL, b'1', 'TestTask', 'run', NULL, 0);
INSERT INTO `quartz_log` VALUES (415, 'stockQuantityGuaranteeTask', '2021-01-17 14:28:03', '0 14 14 * * ? ', NULL, b'1', '质保实数更新', 'run', '', 62791);
INSERT INTO `quartz_log` VALUES (416, 'stockQuantityGuaranteeTask', '2021-01-17 14:31:05', '0 14 14 * * ? ', NULL, b'1', '质保实数更新', 'run', '', 4860);
INSERT INTO `quartz_log` VALUES (417, 'stockQuantityGuaranteeTask', '2021-01-17 14:32:37', '0 14 14 * * ? ', NULL, b'1', '质保实数更新', 'run', '', 36677);
INSERT INTO `quartz_log` VALUES (418, 'stockQuantityGuaranteeTask', '2021-01-17 14:37:42', '0 32 14 * * ? ', NULL, b'1', '质保实数更新', 'run', '', 121593);
INSERT INTO `quartz_log` VALUES (419, 'stockQuantityGuaranteeTask', '2021-01-17 14:38:32', '0 32 14 * * ? ', NULL, b'1', '质保实数更新', 'run', '', 11599);
INSERT INTO `quartz_log` VALUES (420, 'stockQuantityGuaranteeTask', '2021-01-17 14:48:50', '20 38 14 * * ? ', NULL, b'1', '质保实数更新', 'run', '', 239);
INSERT INTO `quartz_log` VALUES (421, 'visitsTask', '2021-02-22 07:50:37', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 36);
INSERT INTO `quartz_log` VALUES (422, 'stockQuantityGuaranteeTask', '2021-02-22 07:50:37', '0 0 3 * * ? *', NULL, b'1', '质保实数更新', 'run', '', 343);
INSERT INTO `quartz_log` VALUES (423, 'visitsTask', '2021-02-27 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 139);
INSERT INTO `quartz_log` VALUES (424, 'stockQuantityGuaranteeTask', '2021-02-27 03:00:00', '0 0 3 * * ? *', NULL, b'1', '质保实数更新', 'run', '', 408);
INSERT INTO `quartz_log` VALUES (425, 'visitsTask', '2021-03-01 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 79);
INSERT INTO `quartz_log` VALUES (426, 'stockQuantityGuaranteeTask', '2021-03-01 03:00:00', '0 0 3 * * ? *', NULL, b'1', '质保实数更新', 'run', '', 316);
INSERT INTO `quartz_log` VALUES (427, 'stockQuantityGuaranteeTask', '2021-03-03 03:00:00', '0 0 3 * * ? *', NULL, b'1', '质保实数更新', 'run', '', 147);
INSERT INTO `quartz_log` VALUES (428, 'visitsTask', '2021-03-31 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 63);
INSERT INTO `quartz_log` VALUES (429, 'stockQuantityGuaranteeTask', '2021-03-31 03:00:00', '0 0 3 * * ? *', NULL, b'1', '质保实数更新', 'run', '', 381);
INSERT INTO `quartz_log` VALUES (430, 'visitsTask', '2021-04-05 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 19);
INSERT INTO `quartz_log` VALUES (431, 'stockQuantityGuaranteeTask', '2021-04-05 03:00:00', '0 0 3 * * ? *', NULL, b'1', '质保实数更新', 'run', '', 158);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '2018-11-23 11:04:37', '系统管理员', '系统所有权');
INSERT INTO `role` VALUES (2, '2018-11-23 13:09:06', '总经理', '拥有所有业务权限');
INSERT INTO `role` VALUES (4, '2019-05-15 11:12:20', '客服主管', '负责客户订单业务');
INSERT INTO `role` VALUES (5, '2019-05-15 11:12:45', '仓储主管', '负责客户仓储业务');
INSERT INTO `role` VALUES (6, '2019-05-15 11:13:43', '物流主管', '负责物流业务');
INSERT INTO `role` VALUES (7, '2019-05-15 11:23:08', '客服员', '负责客服工作');
INSERT INTO `role` VALUES (8, '2019-05-15 11:23:34', '仓管员', '负责仓库工作');
INSERT INTO `role` VALUES (9, '2019-07-04 17:24:36', '物流员', '负责物流工作');
INSERT INTO `role` VALUES (10, '2019-07-23 11:17:48', '打包打印账号', '打包打印账号');
INSERT INTO `role` VALUES (11, '2019-10-12 14:56:05', '派送员', '负责货物派送');
INSERT INTO `role` VALUES (12, '2020-12-03 19:50:25', '客户管理员', '客户管理员');

-- ----------------------------
-- Table structure for roles_menus
-- ----------------------------
DROP TABLE IF EXISTS `roles_menus`;
CREATE TABLE `roles_menus`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`menu_id`, `role_id`) USING BTREE,
  INDEX `FKcngg2qadojhi3a651a5adkvbq`(`role_id`) USING BTREE,
  CONSTRAINT `FKcngg2qadojhi3a651a5adkvbq` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKq1knxf8ykt26we8k331naabjx` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of roles_menus
-- ----------------------------
INSERT INTO `roles_menus` VALUES (1, 1);
INSERT INTO `roles_menus` VALUES (1, 2);
INSERT INTO `roles_menus` VALUES (1, 3);
INSERT INTO `roles_menus` VALUES (1, 4);
INSERT INTO `roles_menus` VALUES (1, 5);
INSERT INTO `roles_menus` VALUES (1, 6);
INSERT INTO `roles_menus` VALUES (1, 7);
INSERT INTO `roles_menus` VALUES (1, 8);
INSERT INTO `roles_menus` VALUES (1, 9);
INSERT INTO `roles_menus` VALUES (1, 12);
INSERT INTO `roles_menus` VALUES (1, 28);
INSERT INTO `roles_menus` VALUES (1, 30);
INSERT INTO `roles_menus` VALUES (1, 32);
INSERT INTO `roles_menus` VALUES (1, 33);
INSERT INTO `roles_menus` VALUES (1, 34);
INSERT INTO `roles_menus` VALUES (1, 35);
INSERT INTO `roles_menus` VALUES (1, 36);
INSERT INTO `roles_menus` VALUES (1, 37);
INSERT INTO `roles_menus` VALUES (1, 39);
INSERT INTO `roles_menus` VALUES (1, 40);
INSERT INTO `roles_menus` VALUES (1, 41);
INSERT INTO `roles_menus` VALUES (1, 42);
INSERT INTO `roles_menus` VALUES (1, 43);
INSERT INTO `roles_menus` VALUES (1, 44);
INSERT INTO `roles_menus` VALUES (1, 45);
INSERT INTO `roles_menus` VALUES (1, 47);
INSERT INTO `roles_menus` VALUES (1, 48);
INSERT INTO `roles_menus` VALUES (1, 49);
INSERT INTO `roles_menus` VALUES (1, 50);
INSERT INTO `roles_menus` VALUES (1, 52);
INSERT INTO `roles_menus` VALUES (1, 53);
INSERT INTO `roles_menus` VALUES (1, 54);
INSERT INTO `roles_menus` VALUES (1, 55);
INSERT INTO `roles_menus` VALUES (1, 56);
INSERT INTO `roles_menus` VALUES (1, 57);
INSERT INTO `roles_menus` VALUES (1, 58);
INSERT INTO `roles_menus` VALUES (1, 59);
INSERT INTO `roles_menus` VALUES (1, 60);
INSERT INTO `roles_menus` VALUES (1, 61);
INSERT INTO `roles_menus` VALUES (1, 62);
INSERT INTO `roles_menus` VALUES (1, 65);
INSERT INTO `roles_menus` VALUES (1, 66);
INSERT INTO `roles_menus` VALUES (1, 68);
INSERT INTO `roles_menus` VALUES (1, 69);
INSERT INTO `roles_menus` VALUES (1, 70);
INSERT INTO `roles_menus` VALUES (1, 71);
INSERT INTO `roles_menus` VALUES (1, 72);
INSERT INTO `roles_menus` VALUES (1, 73);
INSERT INTO `roles_menus` VALUES (1, 74);
INSERT INTO `roles_menus` VALUES (1, 75);
INSERT INTO `roles_menus` VALUES (1, 76);
INSERT INTO `roles_menus` VALUES (1, 77);
INSERT INTO `roles_menus` VALUES (1, 78);
INSERT INTO `roles_menus` VALUES (1, 79);
INSERT INTO `roles_menus` VALUES (1, 80);
INSERT INTO `roles_menus` VALUES (1, 81);
INSERT INTO `roles_menus` VALUES (1, 82);
INSERT INTO `roles_menus` VALUES (1, 83);
INSERT INTO `roles_menus` VALUES (1, 84);
INSERT INTO `roles_menus` VALUES (1, 85);
INSERT INTO `roles_menus` VALUES (1, 86);
INSERT INTO `roles_menus` VALUES (1, 87);
INSERT INTO `roles_menus` VALUES (1, 88);
INSERT INTO `roles_menus` VALUES (1, 89);
INSERT INTO `roles_menus` VALUES (1, 90);
INSERT INTO `roles_menus` VALUES (2, 2);
INSERT INTO `roles_menus` VALUES (2, 3);
INSERT INTO `roles_menus` VALUES (2, 4);
INSERT INTO `roles_menus` VALUES (2, 5);
INSERT INTO `roles_menus` VALUES (2, 7);
INSERT INTO `roles_menus` VALUES (2, 8);
INSERT INTO `roles_menus` VALUES (2, 9);
INSERT INTO `roles_menus` VALUES (2, 12);
INSERT INTO `roles_menus` VALUES (2, 28);
INSERT INTO `roles_menus` VALUES (2, 30);
INSERT INTO `roles_menus` VALUES (2, 32);
INSERT INTO `roles_menus` VALUES (2, 33);
INSERT INTO `roles_menus` VALUES (2, 34);
INSERT INTO `roles_menus` VALUES (2, 35);
INSERT INTO `roles_menus` VALUES (2, 36);
INSERT INTO `roles_menus` VALUES (2, 37);
INSERT INTO `roles_menus` VALUES (2, 39);
INSERT INTO `roles_menus` VALUES (2, 40);
INSERT INTO `roles_menus` VALUES (2, 41);
INSERT INTO `roles_menus` VALUES (2, 42);
INSERT INTO `roles_menus` VALUES (2, 43);
INSERT INTO `roles_menus` VALUES (2, 44);
INSERT INTO `roles_menus` VALUES (2, 45);
INSERT INTO `roles_menus` VALUES (2, 47);
INSERT INTO `roles_menus` VALUES (2, 48);
INSERT INTO `roles_menus` VALUES (2, 49);
INSERT INTO `roles_menus` VALUES (2, 50);
INSERT INTO `roles_menus` VALUES (2, 52);
INSERT INTO `roles_menus` VALUES (2, 53);
INSERT INTO `roles_menus` VALUES (2, 54);
INSERT INTO `roles_menus` VALUES (2, 55);
INSERT INTO `roles_menus` VALUES (2, 56);
INSERT INTO `roles_menus` VALUES (2, 57);
INSERT INTO `roles_menus` VALUES (2, 58);
INSERT INTO `roles_menus` VALUES (2, 59);
INSERT INTO `roles_menus` VALUES (2, 60);
INSERT INTO `roles_menus` VALUES (2, 61);
INSERT INTO `roles_menus` VALUES (4, 34);
INSERT INTO `roles_menus` VALUES (4, 36);
INSERT INTO `roles_menus` VALUES (4, 37);
INSERT INTO `roles_menus` VALUES (4, 43);
INSERT INTO `roles_menus` VALUES (4, 44);
INSERT INTO `roles_menus` VALUES (4, 52);
INSERT INTO `roles_menus` VALUES (4, 53);
INSERT INTO `roles_menus` VALUES (4, 55);
INSERT INTO `roles_menus` VALUES (4, 57);
INSERT INTO `roles_menus` VALUES (4, 58);
INSERT INTO `roles_menus` VALUES (4, 59);
INSERT INTO `roles_menus` VALUES (4, 61);
INSERT INTO `roles_menus` VALUES (5, 39);
INSERT INTO `roles_menus` VALUES (5, 40);
INSERT INTO `roles_menus` VALUES (5, 41);
INSERT INTO `roles_menus` VALUES (5, 42);
INSERT INTO `roles_menus` VALUES (5, 45);
INSERT INTO `roles_menus` VALUES (5, 47);
INSERT INTO `roles_menus` VALUES (5, 57);
INSERT INTO `roles_menus` VALUES (5, 58);
INSERT INTO `roles_menus` VALUES (6, 34);
INSERT INTO `roles_menus` VALUES (6, 43);
INSERT INTO `roles_menus` VALUES (6, 44);
INSERT INTO `roles_menus` VALUES (6, 48);
INSERT INTO `roles_menus` VALUES (6, 49);
INSERT INTO `roles_menus` VALUES (6, 50);
INSERT INTO `roles_menus` VALUES (6, 54);
INSERT INTO `roles_menus` VALUES (6, 56);
INSERT INTO `roles_menus` VALUES (6, 57);
INSERT INTO `roles_menus` VALUES (6, 58);
INSERT INTO `roles_menus` VALUES (6, 60);
INSERT INTO `roles_menus` VALUES (7, 43);
INSERT INTO `roles_menus` VALUES (7, 44);
INSERT INTO `roles_menus` VALUES (7, 49);
INSERT INTO `roles_menus` VALUES (7, 50);
INSERT INTO `roles_menus` VALUES (7, 52);
INSERT INTO `roles_menus` VALUES (7, 53);
INSERT INTO `roles_menus` VALUES (7, 55);
INSERT INTO `roles_menus` VALUES (7, 56);
INSERT INTO `roles_menus` VALUES (7, 57);
INSERT INTO `roles_menus` VALUES (7, 58);
INSERT INTO `roles_menus` VALUES (7, 59);
INSERT INTO `roles_menus` VALUES (8, 41);
INSERT INTO `roles_menus` VALUES (8, 42);
INSERT INTO `roles_menus` VALUES (8, 45);
INSERT INTO `roles_menus` VALUES (8, 47);
INSERT INTO `roles_menus` VALUES (8, 57);
INSERT INTO `roles_menus` VALUES (8, 58);
INSERT INTO `roles_menus` VALUES (9, 48);
INSERT INTO `roles_menus` VALUES (9, 49);
INSERT INTO `roles_menus` VALUES (9, 50);
INSERT INTO `roles_menus` VALUES (9, 56);
INSERT INTO `roles_menus` VALUES (9, 57);
INSERT INTO `roles_menus` VALUES (9, 58);
INSERT INTO `roles_menus` VALUES (10, 48);
INSERT INTO `roles_menus` VALUES (10, 49);
INSERT INTO `roles_menus` VALUES (10, 57);
INSERT INTO `roles_menus` VALUES (10, 58);
INSERT INTO `roles_menus` VALUES (11, 48);
INSERT INTO `roles_menus` VALUES (11, 49);
INSERT INTO `roles_menus` VALUES (11, 57);
INSERT INTO `roles_menus` VALUES (11, 58);

-- ----------------------------
-- Table structure for roles_permissions
-- ----------------------------
DROP TABLE IF EXISTS `roles_permissions`;
CREATE TABLE `roles_permissions`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(0) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE,
  INDEX `FKboeuhl31go7wer3bpy6so7exi`(`permission_id`) USING BTREE,
  CONSTRAINT `roles_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `roles_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of roles_permissions
-- ----------------------------
INSERT INTO `roles_permissions` VALUES (1, 1);
INSERT INTO `roles_permissions` VALUES (1, 40);
INSERT INTO `roles_permissions` VALUES (2, 40);
INSERT INTO `roles_permissions` VALUES (4, 40);
INSERT INTO `roles_permissions` VALUES (5, 40);
INSERT INTO `roles_permissions` VALUES (6, 40);
INSERT INTO `roles_permissions` VALUES (7, 40);
INSERT INTO `roles_permissions` VALUES (8, 40);
INSERT INTO `roles_permissions` VALUES (9, 40);
INSERT INTO `roles_permissions` VALUES (10, 40);
INSERT INTO `roles_permissions` VALUES (11, 40);
INSERT INTO `roles_permissions` VALUES (1, 41);
INSERT INTO `roles_permissions` VALUES (2, 41);
INSERT INTO `roles_permissions` VALUES (4, 41);
INSERT INTO `roles_permissions` VALUES (1, 42);
INSERT INTO `roles_permissions` VALUES (2, 42);
INSERT INTO `roles_permissions` VALUES (5, 42);
INSERT INTO `roles_permissions` VALUES (1, 43);
INSERT INTO `roles_permissions` VALUES (2, 43);
INSERT INTO `roles_permissions` VALUES (6, 43);
INSERT INTO `roles_permissions` VALUES (1, 44);
INSERT INTO `roles_permissions` VALUES (2, 44);
INSERT INTO `roles_permissions` VALUES (1, 45);
INSERT INTO `roles_permissions` VALUES (2, 45);
INSERT INTO `roles_permissions` VALUES (4, 45);
INSERT INTO `roles_permissions` VALUES (6, 45);
INSERT INTO `roles_permissions` VALUES (7, 45);
INSERT INTO `roles_permissions` VALUES (11, 45);
INSERT INTO `roles_permissions` VALUES (1, 46);
INSERT INTO `roles_permissions` VALUES (2, 46);
INSERT INTO `roles_permissions` VALUES (4, 46);
INSERT INTO `roles_permissions` VALUES (7, 46);
INSERT INTO `roles_permissions` VALUES (1, 47);
INSERT INTO `roles_permissions` VALUES (2, 47);
INSERT INTO `roles_permissions` VALUES (4, 47);
INSERT INTO `roles_permissions` VALUES (1, 48);
INSERT INTO `roles_permissions` VALUES (2, 48);
INSERT INTO `roles_permissions` VALUES (5, 48);
INSERT INTO `roles_permissions` VALUES (8, 48);
INSERT INTO `roles_permissions` VALUES (1, 49);
INSERT INTO `roles_permissions` VALUES (2, 49);
INSERT INTO `roles_permissions` VALUES (5, 49);
INSERT INTO `roles_permissions` VALUES (8, 49);
INSERT INTO `roles_permissions` VALUES (1, 52);
INSERT INTO `roles_permissions` VALUES (2, 52);
INSERT INTO `roles_permissions` VALUES (6, 52);
INSERT INTO `roles_permissions` VALUES (9, 52);
INSERT INTO `roles_permissions` VALUES (1, 53);
INSERT INTO `roles_permissions` VALUES (2, 53);
INSERT INTO `roles_permissions` VALUES (6, 53);
INSERT INTO `roles_permissions` VALUES (9, 53);
INSERT INTO `roles_permissions` VALUES (1, 55);
INSERT INTO `roles_permissions` VALUES (2, 55);
INSERT INTO `roles_permissions` VALUES (6, 55);
INSERT INTO `roles_permissions` VALUES (9, 55);
INSERT INTO `roles_permissions` VALUES (10, 55);
INSERT INTO `roles_permissions` VALUES (11, 55);
INSERT INTO `roles_permissions` VALUES (1, 56);
INSERT INTO `roles_permissions` VALUES (2, 56);
INSERT INTO `roles_permissions` VALUES (6, 56);
INSERT INTO `roles_permissions` VALUES (9, 56);
INSERT INTO `roles_permissions` VALUES (11, 56);
INSERT INTO `roles_permissions` VALUES (1, 57);
INSERT INTO `roles_permissions` VALUES (2, 57);
INSERT INTO `roles_permissions` VALUES (5, 57);
INSERT INTO `roles_permissions` VALUES (8, 57);
INSERT INTO `roles_permissions` VALUES (1, 58);
INSERT INTO `roles_permissions` VALUES (2, 58);
INSERT INTO `roles_permissions` VALUES (4, 58);
INSERT INTO `roles_permissions` VALUES (5, 58);
INSERT INTO `roles_permissions` VALUES (6, 58);
INSERT INTO `roles_permissions` VALUES (7, 58);
INSERT INTO `roles_permissions` VALUES (8, 58);
INSERT INTO `roles_permissions` VALUES (9, 58);
INSERT INTO `roles_permissions` VALUES (10, 58);
INSERT INTO `roles_permissions` VALUES (11, 58);
INSERT INTO `roles_permissions` VALUES (1, 59);
INSERT INTO `roles_permissions` VALUES (2, 59);
INSERT INTO `roles_permissions` VALUES (4, 59);
INSERT INTO `roles_permissions` VALUES (5, 59);
INSERT INTO `roles_permissions` VALUES (1, 60);
INSERT INTO `roles_permissions` VALUES (2, 60);
INSERT INTO `roles_permissions` VALUES (4, 60);
INSERT INTO `roles_permissions` VALUES (1, 61);
INSERT INTO `roles_permissions` VALUES (2, 61);
INSERT INTO `roles_permissions` VALUES (5, 61);
INSERT INTO `roles_permissions` VALUES (8, 61);
INSERT INTO `roles_permissions` VALUES (1, 62);
INSERT INTO `roles_permissions` VALUES (2, 62);
INSERT INTO `roles_permissions` VALUES (5, 62);
INSERT INTO `roles_permissions` VALUES (7, 62);
INSERT INTO `roles_permissions` VALUES (1, 63);
INSERT INTO `roles_permissions` VALUES (2, 63);
INSERT INTO `roles_permissions` VALUES (5, 63);
INSERT INTO `roles_permissions` VALUES (8, 63);
INSERT INTO `roles_permissions` VALUES (1, 64);
INSERT INTO `roles_permissions` VALUES (2, 64);
INSERT INTO `roles_permissions` VALUES (6, 64);
INSERT INTO `roles_permissions` VALUES (1, 65);
INSERT INTO `roles_permissions` VALUES (2, 65);
INSERT INTO `roles_permissions` VALUES (6, 65);
INSERT INTO `roles_permissions` VALUES (9, 65);
INSERT INTO `roles_permissions` VALUES (10, 65);
INSERT INTO `roles_permissions` VALUES (1, 66);
INSERT INTO `roles_permissions` VALUES (2, 66);
INSERT INTO `roles_permissions` VALUES (6, 66);
INSERT INTO `roles_permissions` VALUES (1, 68);
INSERT INTO `roles_permissions` VALUES (2, 68);
INSERT INTO `roles_permissions` VALUES (1, 69);
INSERT INTO `roles_permissions` VALUES (2, 69);
INSERT INTO `roles_permissions` VALUES (1, 70);
INSERT INTO `roles_permissions` VALUES (2, 70);
INSERT INTO `roles_permissions` VALUES (5, 70);
INSERT INTO `roles_permissions` VALUES (1, 71);
INSERT INTO `roles_permissions` VALUES (2, 71);
INSERT INTO `roles_permissions` VALUES (5, 71);
INSERT INTO `roles_permissions` VALUES (1, 72);
INSERT INTO `roles_permissions` VALUES (2, 72);
INSERT INTO `roles_permissions` VALUES (5, 72);
INSERT INTO `roles_permissions` VALUES (1, 73);
INSERT INTO `roles_permissions` VALUES (2, 73);
INSERT INTO `roles_permissions` VALUES (5, 73);
INSERT INTO `roles_permissions` VALUES (1, 74);
INSERT INTO `roles_permissions` VALUES (2, 74);
INSERT INTO `roles_permissions` VALUES (4, 74);
INSERT INTO `roles_permissions` VALUES (1, 75);
INSERT INTO `roles_permissions` VALUES (2, 75);
INSERT INTO `roles_permissions` VALUES (4, 75);
INSERT INTO `roles_permissions` VALUES (7, 75);
INSERT INTO `roles_permissions` VALUES (1, 76);
INSERT INTO `roles_permissions` VALUES (2, 76);
INSERT INTO `roles_permissions` VALUES (6, 76);
INSERT INTO `roles_permissions` VALUES (1, 77);
INSERT INTO `roles_permissions` VALUES (2, 77);
INSERT INTO `roles_permissions` VALUES (4, 77);
INSERT INTO `roles_permissions` VALUES (7, 77);
INSERT INTO `roles_permissions` VALUES (1, 78);
INSERT INTO `roles_permissions` VALUES (2, 78);
INSERT INTO `roles_permissions` VALUES (6, 78);
INSERT INTO `roles_permissions` VALUES (1, 79);
INSERT INTO `roles_permissions` VALUES (2, 79);
INSERT INTO `roles_permissions` VALUES (4, 79);
INSERT INTO `roles_permissions` VALUES (1, 80);
INSERT INTO `roles_permissions` VALUES (2, 80);
INSERT INTO `roles_permissions` VALUES (4, 80);
INSERT INTO `roles_permissions` VALUES (1, 81);
INSERT INTO `roles_permissions` VALUES (1, 82);
INSERT INTO `roles_permissions` VALUES (1, 83);
INSERT INTO `roles_permissions` VALUES (1, 84);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `enabled` bigint(0) NULL DEFAULT NULL COMMENT '状态：1启用、0禁用',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `last_password_reset_time` datetime(0) NULL DEFAULT NULL COMMENT '最后修改密码的日期',
  `coefficient` float NULL DEFAULT NULL,
  `num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_kpubos9gc2cvtkb0thktkbkes`(`email`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (4, '/avatar/2019-07-15-20291653073428.jpg', '2019-04-10 10:48:35', 'admin@ok.com', 1, '14e1b600b1fd579f47433b88e8d85291', 'admin', '2020-11-24 18:25:48', 0.1, '001');
INSERT INTO `user` VALUES (5, '/avatar/no_avatar.jpg', '2020-12-03 19:50:53', 'lf@qq.com', 1, '14e1b600b1fd579f47433b88e8d85291', '李峰', '2021-01-02 20:22:35', 0.1, '002');
INSERT INTO `user` VALUES (6, '/avatar/no_avatar.jpg', '2020-12-03 20:54:27', '9256@qq.com', 1, '14e1b600b1fd579f47433b88e8d85291', '派送李师傅', '2021-01-02 20:22:43', 0.1, '003');

-- ----------------------------
-- Table structure for users_roles
-- ----------------------------
DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE `users_roles`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `FKq4eq273l04bpu4efj0jd0jb98`(`role_id`) USING BTREE,
  CONSTRAINT `users_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_roles_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users_roles
-- ----------------------------
INSERT INTO `users_roles` VALUES (4, 1);
INSERT INTO `users_roles` VALUES (5, 1);
INSERT INTO `users_roles` VALUES (6, 1);
INSERT INTO `users_roles` VALUES (6, 9);
INSERT INTO `users_roles` VALUES (6, 11);
INSERT INTO `users_roles` VALUES (5, 12);

-- ----------------------------
-- Table structure for verification_code
-- ----------------------------
DROP TABLE IF EXISTS `verification_code`;
CREATE TABLE `verification_code`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证码',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态：1有效、0过期',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证码类型：email或者短信',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收邮箱或者手机号码',
  `scenes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务名称：如重置邮箱、重置密码等',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of verification_code
-- ----------------------------

-- ----------------------------
-- Table structure for visits
-- ----------------------------
DROP TABLE IF EXISTS `visits`;
CREATE TABLE `visits`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ip_counts` bigint(0) NULL DEFAULT NULL,
  `pv_counts` bigint(0) NULL DEFAULT NULL,
  `week_day` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_11aksgq87euk9bcyeesfs4vtp`(`date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 503 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visits
-- ----------------------------
INSERT INTO `visits` VALUES (434, '2020-08-02 00:46:57', '2020-08-02', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (435, '2020-11-24 18:23:59', '2020-11-24', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (436, '2020-11-30 10:38:55', '2020-11-30', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (437, '2020-12-03 17:08:30', '2020-12-03', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (438, '2020-12-04 00:00:00', '2020-12-04', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (439, '2020-12-05 11:27:36', '2020-12-05', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (440, '2020-12-06 19:53:08', '2020-12-06', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (441, '2020-12-07 00:00:00', '2020-12-07', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (442, '2020-12-08 00:00:00', '2020-12-08', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (443, '2020-12-09 00:00:00', '2020-12-09', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (444, '2020-12-10 00:00:00', '2020-12-10', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (445, '2020-12-11 00:00:00', '2020-12-11', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (446, '2020-12-12 00:00:00', '2020-12-12', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (447, '2020-12-13 00:00:00', '2020-12-13', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (448, '2020-12-14 21:55:42', '2020-12-14', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (449, '2020-12-15 00:00:00', '2020-12-15', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (450, '2020-12-16 00:00:00', '2020-12-16', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (451, '2020-12-17 21:48:24', '2020-12-17', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (452, '2020-12-18 00:00:00', '2020-12-18', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (453, '2020-12-19 01:07:32', '2020-12-19', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (454, '2021-01-01 11:13:24', '2021-01-01', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (455, '2021-01-02 00:02:04', '2021-01-02', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (456, '2021-01-03 00:00:00', '2021-01-03', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (457, '2021-01-04 22:37:25', '2021-01-04', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (458, '2021-01-05 00:00:00', '2021-01-05', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (459, '2021-01-06 19:52:59', '2021-01-06', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (460, '2021-01-07 00:34:13', '2021-01-07', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (461, '2021-01-08 05:51:48', '2021-01-08', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (462, '2021-01-09 00:12:24', '2021-01-09', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (463, '2021-01-11 11:16:24', '2021-01-11', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (464, '2021-01-12 00:00:00', '2021-01-12', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (465, '2021-01-13 01:30:05', '2021-01-13', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (466, '2021-01-14 08:13:35', '2021-01-14', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (467, '2021-01-15 06:03:33', '2021-01-15', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (468, '2021-01-16 05:31:34', '2021-01-16', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (469, '2021-01-17 12:57:47', '2021-01-17', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (470, '2021-01-20 06:52:30', '2021-01-20', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (471, '2021-01-24 17:56:41', '2021-01-24', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (472, '2021-01-29 08:00:27', '2021-01-29', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (473, '2021-01-30 08:43:16', '2021-01-30', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (474, '2021-01-31 17:20:28', '2021-01-31', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (475, '2021-02-01 06:47:11', '2021-02-01', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (476, '2021-02-03 08:14:57', '2021-02-03', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (477, '2021-02-05 06:57:09', '2021-02-05', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (478, '2021-02-07 07:43:43', '2021-02-07', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (479, '2021-02-08 07:36:11', '2021-02-08', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (480, '2021-02-21 11:39:08', '2021-02-21', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (481, '2021-02-22 07:50:37', '2021-02-22', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (482, '2021-02-23 07:10:21', '2021-02-23', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (483, '2021-02-24 07:05:22', '2021-02-24', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (484, '2021-02-25 07:52:40', '2021-02-25', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (485, '2021-02-26 07:25:29', '2021-02-26', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (486, '2021-02-27 00:00:00', '2021-02-27', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (487, '2021-02-28 08:57:24', '2021-02-28', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (488, '2021-03-01 00:00:00', '2021-03-01', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (489, '2021-03-03 01:36:51', '2021-03-03', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (490, '2021-03-11 08:16:31', '2021-03-11', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (491, '2021-03-12 07:54:29', '2021-03-12', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (492, '2021-03-17 08:00:18', '2021-03-17', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (493, '2021-03-23 20:51:46', '2021-03-23', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (494, '2021-03-27 10:02:44', '2021-03-27', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (495, '2021-03-30 07:33:37', '2021-03-30', 1, 1, 'Tue');
INSERT INTO `visits` VALUES (496, '2021-03-31 00:00:00', '2021-03-31', 1, 1, 'Wed');
INSERT INTO `visits` VALUES (497, '2021-04-01 05:00:21', '2021-04-01', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (498, '2021-04-02 07:39:53', '2021-04-02', 1, 1, 'Fri');
INSERT INTO `visits` VALUES (499, '2021-04-04 09:53:51', '2021-04-04', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (500, '2021-04-05 00:00:00', '2021-04-05', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (501, '2021-04-08 07:48:31', '2021-04-08', 1, 1, 'Thu');
INSERT INTO `visits` VALUES (502, '2021-04-12 01:23:22', '2021-04-12', 1, 1, 'Mon');
INSERT INTO `visits` VALUES (503, '2021-07-17 17:06:22', '2021-07-17', 1, 1, 'Sat');
INSERT INTO `visits` VALUES (504, '2021-09-19 16:06:47', '2021-09-19', 1, 1, 'Sun');

-- ----------------------------
-- Table structure for wms_address
-- ----------------------------
DROP TABLE IF EXISTS `wms_address`;
CREATE TABLE `wms_address`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address_type_id` bigint(0) NULL DEFAULT NULL,
  `coefficient` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_store` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address_area_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK67rl8f969orhpugijk7ertqu5`(`address_type_id`) USING BTREE,
  INDEX `FKh57prxix6p4nra1lvv6m297p0`(`address_area_id`) USING BTREE,
  CONSTRAINT `FK67rl8f969orhpugijk7ertqu5` FOREIGN KEY (`address_type_id`) REFERENCES `wms_address_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKh57prxix6p4nra1lvv6m297p0` FOREIGN KEY (`address_area_id`) REFERENCES `wms_address_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_address
-- ----------------------------
INSERT INTO `wms_address` VALUES (10000, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨守会', '膏霜+洗护杨守会15223319179', '中百重庆市大渡口区--朵力店', '15223319179', 784159469637468160, '1', '中百重庆市大渡口区--朵力店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10002, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '熊敏', '膏霜+洗护熊敏13637889043', '中百重庆市南岸区--青龙路店', '13637889043', 784159469637468160, '1', '中百重庆市南岸区--青龙路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10004, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘晓梅', '膏霜+洗护刘晓梅18723053732', '中百重庆市渝北区--宝圣二路店', '18723053732', 784159469637468160, '1', '中百重庆市渝北区--宝圣二路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10006, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '卢荣慧', '膏霜+洗护卢荣慧15923229201', '中百重庆市渝北区--宝圣一店', '15923229201', 784159469637468160, '1', '中百重庆市渝北区--宝圣一店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10008, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘小丽', '膏霜+洗护刘小丽18223522106', '中百重庆市渝北区--龙兴店', '18223522106', 784159469637468160, '1', '中百重庆市渝北区--龙兴店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10010, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘福菊', '膏霜+洗护刘福菊13272650251', '中百重庆市渝北区--上品十六店', '13272650251', 784159469637468160, '1', '中百重庆市渝北区--上品十六店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10012, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张必英', '膏霜+洗护张必英13608314042', '重两江新区--嘉和路店', '13608314042', 784159469637468160, '1', '重两江新区--嘉和路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10014, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '邓晓琴', '洗发水专职：刘盛芳15922642550；膏霜邓晓琴13752993929', '重庆巴南区—巴南万达店', '13752993929', 784159469637468160, '1', '重庆巴南区—巴南万达店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10016, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王乔英', '膏霜+洗护王乔英18983044371，儿童李向华13752945516', '重庆巴南区--都和广场店', '18983044371', 784159469637468160, '1', '重庆巴南区--都和广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10018, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李远群', '膏霜+洗护李远群15223222613', '重庆巴南区--人民广场店', '15223222613', 784159469637468160, '1', '重庆巴南区--人民广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10020, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '徐永凤', '膏霜+洗护徐永凤15123946745', '重庆巴南区--土桥店', '15123946745', 784159469637468160, '1', '重庆巴南区--土桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10022, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王培', '膏霜+洗护王培17783583195', '重庆北碚区--缙云大道店', '17783583195', 784159469637468160, '1', '重庆北碚区--缙云大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10024, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '唐祖梅', '膏霜+洗护唐祖梅15023765641', '重庆北碚区--双元大道店', '15023765641', 784159469637468160, '1', '重庆北碚区--双元大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10026, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '胡琴', '膏霜+洗护胡琴18725930895', '重庆北碚区--天生丽街店', '18725930895', 784159469637468160, '1', '重庆北碚区--天生丽街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10028, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '罗小霜', '膏霜+洗护罗小霜18725982757', '重庆北碚区--文星湾旺德旺城店', '18725982757', 784159469637468160, '1', '重庆北碚区--文星湾旺德旺城店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10030, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '冉茂学', '膏霜+洗护冉茂学13752807470', '重庆璧山县--金山广场店', '13752807470', 784159469637468160, '1', '重庆璧山县--金山广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10032, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '卿庆梅', '膏霜+洗护卿庆梅13272835359', '重庆璧山县--青杠店', '13272835359', 784159469637468160, '1', '重庆璧山县--青杠店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10034, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李道淑', '膏霜+洗护李道淑13996235391', '重庆璧山县--时代商都店', '13996235391', 784159469637468160, '1', '重庆璧山县--时代商都店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10036, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘雪梅', '膏霜+洗护刘雪梅13883635016', '重庆大渡口区--大渡口万达店', '13883635016', 784159469637468160, '1', '重庆大渡口区--大渡口万达店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10038, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '魏忠华', '膏霜+洗护魏忠华18725925139', '重庆大渡口区--香港城店', '18725925139', 784159469637468160, '1', '重庆大渡口区--香港城店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10040, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王锡琴', '膏霜+洗护王锡琴17783496583', '重庆大渡口区--壹街购物中心店', '17783496583', 784159469637468160, '1', '重庆大渡口区--壹街购物中心店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10042, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '于小凤', '膏霜+洗护于小凤17830862342', '重庆大渡口区--中房店', '17830862342', 784159469637468160, '1', '重庆大渡口区--中房店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10044, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '舒通素', '洗发水专职：杨芳13983173227；膏霜舒通素13452031804', '重庆大渡口区--中交丽景店', '13452031804', 784159469637468160, '1', '重庆大渡口区--中交丽景店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10046, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '郑开芳', '膏霜+洗护郑开芳18725688938', '重庆大足区--五星大道店', '18725688938', 784159469637468160, '1', '重庆大足区--五星大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10048, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '罗元平', '膏霜+洗护罗元平13647654805', '重庆大足县--国梁店', '13647654805', 784159469637468160, '1', '重庆大足县--国梁店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10050, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周身菊', '膏霜+洗护周身菊13996144750', '重庆大足县--双桥店', '13996144750', 784159469637468160, '1', '重庆大足县--双桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10052, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李凤', '膏霜+洗护李凤13896608498', '重庆垫江县--昆翔明悦天店', '13896608498', 784159469637468160, '1', '重庆垫江县--昆翔明悦天店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10054, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '蔡成辉', '膏霜+洗护蔡成辉15978972373', '重庆垫江县--西欧花园店', '15978972373', 784159469637468160, '1', '重庆垫江县--西欧花园店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10056, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈在飞', '洗发水专职：李晓丽15826231476；膏霜陈在飞18983588719', '重庆丰都区--久桓大道店', '18983588719', 784159469637468160, '1', '重庆丰都区--久桓大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10058, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '秦淑琼', '膏霜+洗护秦淑琼15736520004', '重庆涪陵区--涪陵宝龙店', '15736520004', 784159469637468160, '1', '重庆涪陵区--涪陵宝龙店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10060, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈仁英', '陈仁英13983582076', '重庆涪陵区--涪陵万达店', '13983582076', 784159469637468160, '1', '重庆涪陵区--涪陵万达店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10062, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '田小梅', '膏霜+洗护田小梅15923718377', '重庆涪陵区--南门山金科店', '15923718377', 784159469637468160, '1', '重庆涪陵区--南门山金科店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10064, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '谭会英', '膏霜+洗护谭会英13996724228', '重庆涪陵区--泽胜广场店', '13996724228', 784159469637468160, '1', '重庆涪陵区--泽胜广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10066, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘长淑', '膏霜+洗护刘长淑13896776940', '重庆涪陵区--中慧西街店', '13896776940', 784159469637468160, '1', '重庆涪陵区--中慧西街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10068, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '何召会', '膏霜+洗护何召会17830129725', '重庆合川区--合川宝龙店', '17830129725', 784159469637468160, '1', '重庆合川区--合川宝龙店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10070, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王中梅', '膏霜+洗护王中梅13508373850', '重庆合川区--金世纪广场店', '13508373850', 784159469637468160, '1', '重庆合川区--金世纪广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10072, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王能洪', '膏霜+洗护王能洪13983229521', '重庆江北区--大石坝店', '13983229521', 784159469637468160, '1', '重庆江北区--大石坝店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10074, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王玲', '膏霜+洗护王玲15922972883', '重庆江北区--观音桥店', '15922972883', 784159469637468160, '1', '重庆江北区--观音桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10076, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '庞烈菊', '膏霜+洗护庞烈菊19923350166', '重庆江北区--国奥村店', '19923350166', 784159469637468160, '1', '重庆江北区--国奥村店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10078, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈小娇', '膏霜+洗护陈小娇13883915520', '重庆江北区--建新东路店', '13883915520', 784159469637468160, '1', '重庆江北区--建新东路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10080, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '郑克辉', '膏霜+洗护郑克辉13509413128', '重庆江北区--金源时代购物中心店', '13509413128', 784159469637468160, '1', '重庆江北区--金源时代购物中心店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10082, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周芬', '膏霜+洗护周芬18203062261', '重庆江北区--龙湖新壹街店', '18203062261', 784159469637468160, '1', '重庆江北区--龙湖新壹街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10084, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李佑君', '膏霜+洗护李佑君13883397207', '重庆江北区--望江店', '13883397207', 784159469637468160, '1', '重庆江北区--望江店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10086, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈安梅', '膏霜+洗护陈安梅13220366190', '重庆江北区--五里店', '13220366190', 784159469637468160, '1', '重庆江北区--五里店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10088, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '毛彦梅', '膏霜+洗护毛彦梅18375712897', '重庆江北区--永辉生活广场店', '18375712897', 784159469637468160, '1', '重庆江北区--永辉生活广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10090, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '何敏', '膏霜+洗护何敏19122186090', '重庆江津区--江津西江大道店', '19122186090', 784159469637468160, '1', '重庆江津区--江津西江大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10092, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '郭建群', '膏霜+洗护郭建群15223383016', '重庆江津区--江洲大道店', '15223383016', 784159469637468160, '1', '重庆江津区--江洲大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10094, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '苏春', '膏霜+洗护苏春15223387810', '重庆江津区--双福星街店', '15223387810', 784159469637468160, '1', '重庆江津区--双福星街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10096, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨材芳', '膏霜+洗护杨材芳18323428712', '重庆江津区--塔坪路店', '18323428712', 784159469637468160, '1', '重庆江津区--塔坪路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10098, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '赵玉兰', '洗发水专职：徐亚琴18983190663；膏霜赵玉兰18875360793', '重庆九龙坡区--奥园盘龙店', '18875360793', 784159469637468160, '1', '重庆九龙坡区--奥园盘龙店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10100, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '石先芳', '膏霜+洗护石先芳13193125258', '重庆九龙坡区--白市驿店', '13193125258', 784159469637468160, '1', '重庆九龙坡区--白市驿店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10102, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '黄宽英', '膏霜+洗护黄宽英19923836138', '重庆九龙坡区--华福金科店', '19923836138', 784159469637468160, '1', '重庆九龙坡区--华福金科店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10104, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '魏姐', '膏霜+洗护魏姐19923135988', '重庆九龙坡区--龙湖新壹城店', '19923135988', 784159469637468160, '1', '重庆九龙坡区--龙湖新壹城店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10106, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘涛', '膏霜+洗护刘涛13193082479', '重庆九龙坡区--民生广场店', '13193082479', 784159469637468160, '1', '重庆九龙坡区--民生广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10108, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '罗永碧', '膏霜+洗护罗永碧18323086849', '重庆九龙坡区--石坪桥店', '18323086849', 784159469637468160, '1', '重庆九龙坡区--石坪桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10110, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈洪碧', '膏霜+洗护陈洪碧13668013654', '重庆九龙坡区--石桥铺店', '13668013654', 784159469637468160, '1', '重庆九龙坡区--石桥铺店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10112, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '何兴秀', '膏霜+洗护何兴秀18223031878', '重庆九龙坡区--西城天街店', '18223031878', 784159469637468160, '1', '重庆九龙坡区--西城天街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10114, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周淑琴', '膏霜+洗护周淑琴17783055632', '重庆九龙坡区--谢家湾店', '17783055632', 784159469637468160, '1', '重庆九龙坡区--谢家湾店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10116, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王海燕', '膏霜+洗护王海燕15723233937', '重庆九龙坡区--渝州路店', '15723233937', 784159469637468160, '1', '重庆九龙坡区--渝州路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10118, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '魏萍', '膏霜+洗护魏萍13658214138', '重庆开县--新天地店', '13658214138', 784159469637468160, '1', '重庆开县--新天地店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10120, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周代姝', '膏霜+洗护周代姝15320715069', '重庆开县--云枫嶺尚城店', '15320715069', 784159469637468160, '1', '重庆开县--云枫嶺尚城店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10122, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '叶如辉', '膏霜+洗护叶如辉15330427756', '重庆梁平县--大众店', '15330427756', 784159469637468160, '1', '重庆梁平县--大众店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10124, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '吕后宣', '膏霜+洗护吕后宣15870512355', '重庆梁平县--西池广场店', '15870512355', 784159469637468160, '1', '重庆梁平县--西池广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10126, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '曾学英', '膏霜+洗护曾学英17823199393', '重庆九龙坡区--仁悦天地店', '17823199393', 784159469637468160, '1', '重庆九龙坡区--仁悦天地店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10128, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '徐小红', '洗护林素英18203097129，膏霜徐小红13368253344', '重庆南岸区--奥园城市天地店', '13368253344', 784159469637468160, '1', '重庆南岸区--奥园城市天地店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10130, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈娇', '膏霜+洗护陈娇15823839809', '重庆南岸区--茶园金科店', '15823839809', 784159469637468160, '1', '重庆南岸区--茶园金科店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10132, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '邓满红', '膏霜+洗护邓满红15340528066', '重庆南岸区--崇文店', '15340528066', 784159469637468160, '1', '重庆南岸区--崇文店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10134, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张冬容', '膏霜+洗护张冬容13110278944', '重庆南岸区--弹新街店', '13110278944', 784159469637468160, '1', '重庆南岸区--弹新街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10136, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘国红', '膏霜+洗护刘国红13272650023', '重庆南岸区--风临路店', '13272650023', 784159469637468160, '1', '重庆南岸区--风临路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10138, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '韦玉成', '膏霜+洗护韦玉成18723183953', '重庆南岸区--南湖花园店', '18723183953', 784159469637468160, '1', '重庆南岸区--南湖花园店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10140, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '唐小红', '膏霜+洗护唐小红13452035733', '重庆南岸区--南坪东路店', '13452035733', 784159469637468160, '1', '重庆南岸区--南坪东路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10142, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周国梅', '洗发水专职：伍红梅18716681718；膏霜周国梅15922657245', '重庆南岸区--四公里店', '15922657245', 784159469637468160, '1', '重庆南岸区--四公里店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10144, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '唐六梅', '膏霜+洗护唐六梅13983673617', '重庆南岸区--腾龙大道店', '13983673617', 784159469637468160, '1', '重庆南岸区--腾龙大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10146, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '邓晓梅', '膏霜+洗护邓晓梅19942339529', '重庆南岸区--万达广场店', '19942339529', 784159469637468160, '1', '重庆南岸区--万达广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10148, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '廖英', '膏霜+洗护廖英18983588842', '重庆南川区--南川万达店', '18983588842', 784159469637468160, '1', '重庆南川区--南川万达店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10150, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '彭显芳', '洗发水专职：苏玉环13983593504；膏霜彭显芳15023506313', '重庆南川区--南大街店', '15023506313', 784159469637468160, '1', '重庆南川区--南大街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10152, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王润秀', '膏霜+洗护王润秀18323973827', '重庆南川区--渝南大道店', '18323973827', 784159469637468160, '1', '重庆南川区--渝南大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10154, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李亚', '洗发水专职：田小琴13045864149，李亚18725674079', '重庆綦江县--河东店', '18725674079', 784159469637468160, '1', '重庆綦江县--河东店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10156, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '翁庆孝', '膏霜+洗护翁庆孝15683990979', '重庆綦江县--河西店', '15683990979', 784159469637468160, '1', '重庆綦江县--河西店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10158, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周光芬', '膏霜+洗护周光芬17774900200', '重庆綦江县--九龙大道店', '17774900200', 784159469637468160, '1', '重庆綦江县--九龙大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10160, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李会', '膏霜+洗护李会13527373430', '重庆綦江县--綦江万达广场店', '13527373430', 784159469637468160, '1', '重庆綦江县--綦江万达广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10162, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘克兰', '膏霜+洗护刘克兰18225402618', '重庆黔江区--丽都花苑店', '18225402618', 784159469637468160, '1', '重庆黔江区--丽都花苑店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10164, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张志兰', '膏霜+洗护张志兰13657648068', '重庆荣昌县--莲花广场店', '13657648068', 784159469637468160, '1', '重庆荣昌县--莲花广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10166, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨玉兰', '膏霜+洗护杨玉兰15828465780', '重庆荣昌县--荣昌迎宾大道店', '15828465780', 784159469637468160, '1', '重庆荣昌县--荣昌迎宾大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10168, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '何长书', '膏霜+洗护何长书13647607947', '重庆荣昌县--沿河中路店', '13647607947', 784159469637468160, '1', '重庆荣昌县--沿河中路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10170, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '温春霞', '膏霜+洗护温春霞15923017618', '重庆沙坪坝区--陈家桥店', '15923017618', 784159469637468160, '1', '重庆沙坪坝区--陈家桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10172, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '方小华', '膏霜+洗护方小华15870463236', '重庆沙坪坝区--春华秋实店', '15870463236', 784159469637468160, '1', '重庆沙坪坝区--春华秋实店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10174, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈文利', '膏霜+洗护陈文利13452315943', '重庆沙坪坝区--汉渝路店', '13452315943', 784159469637468160, '1', '重庆沙坪坝区--汉渝路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10176, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '戴红', '膏霜膏霜戴红15178821016，洗护18996325102廖蓉', '重庆沙坪坝区--嘉茂购物中心店', '15178821016', 784159469637468160, '1', '重庆沙坪坝区--嘉茂购物中心店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10178, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '柏开蓉', '源萃收货柏开蓉17784253675，展鹿收货人刘万英13883699193', '重庆沙坪坝区--联芳桥店', '17784253675', 784159469637468160, '1', '重庆沙坪坝区--联芳桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10180, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨玲', '膏霜+洗护杨玲13012349309', '重庆沙坪坝区--龙湖大学城店', '13012349309', 784159469637468160, '1', '重庆沙坪坝区--龙湖大学城店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10182, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王蓓', '膏霜+洗护王蓓18223036764', '重庆沙坪坝区--沙坪坝万达广场店', '18223036764', 784159469637468160, '1', '重庆沙坪坝区--沙坪坝万达广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10184, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '程英', '膏霜+洗护程英15215108577', '重庆沙坪坝区--双碑鼎盛店', '15215108577', 784159469637468160, '1', '重庆沙坪坝区--双碑鼎盛店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10186, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '舒恩兰', '膏霜+洗护舒恩兰13594274960', '重庆沙坪坝区--天星桥店', '13594274960', 784159469637468160, '1', '重庆沙坪坝区--天星桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10188, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '吴小华', '膏霜+洗护吴小华13635487420', '重庆沙坪坝区--童家桥店', '13635487420', 784159469637468160, '1', '重庆沙坪坝区--童家桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10190, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周维兰', '膏霜+洗护周维兰13628355623', '重庆沙坪坝区--新桥店', '13628355623', 784159469637468160, '1', '重庆沙坪坝区--新桥店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10192, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '冉翠', '膏霜+洗护冉翠18315293894', '重庆石柱县--康德中央大街店', '18315293894', 784159469637468160, '1', '重庆石柱县--康德中央大街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10194, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '秦秀梅', '膏霜+洗护秦秀梅18725904792', '重庆市沙坪坝区--西林大道店', '18725904792', 784159469637468160, '1', '重庆市沙坪坝区--西林大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10196, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈秋荣', '膏霜+洗护陈秋荣15025792116', '重庆市酉阳县--碧津广场店', '15025792116', 784159469637468160, '1', '重庆市酉阳县--碧津广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10198, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王成会', '膏霜+洗护王成会13637991275', '重庆市渝北区--红叶路店', '13637991275', 784159469637468160, '1', '重庆市渝北区--红叶路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10200, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '唐伏容', '膏霜+洗护唐伏容13598028478', '重庆市渝北区--赛迪路店', '13598028478', 784159469637468160, '1', '重庆市渝北区--赛迪路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10202, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李兴分', '膏霜+洗护李兴分15023856371', '重庆市忠县--财富广场店', '15023856371', 784159469637468160, '1', '重庆市忠县--财富广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10204, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈隆芳', '膏霜+洗护陈隆芳18203021028', '重庆铜梁县--广龙明珠店', '18203021028', 784159469637468160, '1', '重庆铜梁县--广龙明珠店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10206, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李良君', '膏霜+洗护李良君13648369886', '重庆潼南县--东安大道店', '13648369886', 784159469637468160, '1', '重庆潼南县--东安大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10208, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨雪', '膏霜+洗护杨雪18883749637', '重庆潼南区--巴渝大道店', '18883749637', 784159469637468160, '1', '重庆潼南区--巴渝大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10210, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '朱正兰', '膏霜+洗护朱正兰18223139261', '重庆万盛区--民盛店', '18223139261', 784159469637468160, '1', '重庆万盛区--民盛店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10212, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘晓翠', '膏霜+洗护刘晓翠18523810032', '重庆万盛区--万盛名都店', '18523810032', 784159469637468160, '1', '重庆万盛区--万盛名都店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10214, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张顺芝', '膏霜+洗护张顺芝15923445650', '重庆万州区--北城中心广场店', '15923445650', 784159469637468160, '1', '重庆万州区--北城中心广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10216, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李庆红', '膏霜+洗护李庆红18223841213', '重庆万州区--国贸广场店', '18223841213', 784159469637468160, '1', '重庆万州区--国贸广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10218, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李坤群', '膏霜+洗护李坤群13896216291', '重庆万州区--万州万达店', '13896216291', 784159469637468160, '1', '重庆万州区--万州万达店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10220, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张华英', '膏霜+洗护张华英15023470814', '重庆万州区--王牌路店', '15023470814', 784159469637468160, '1', '重庆万州区--王牌路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10222, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '匡苹', '膏霜+洗护匡苹18323692465', '重庆巫山县--神女尚熙台店', '18323692465', 784159469637468160, '1', '重庆巫山县--神女尚熙台店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10224, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张仁琼', '膏霜+洗护张仁琼15095872292', '重庆武隆县--南城中央广场店', '15095872292', 784159469637468160, '1', '重庆武隆县--南城中央广场店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10226, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨芳琼', '洗发水专职：何薇18225386889；膏霜+洗护杨芳琼15095959824', '重庆秀山县-渝秀大道店', '15095959824', 784159469637468160, '1', '重庆秀山县-渝秀大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10228, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '龚富春', '膏霜+洗护龚富春15823514489', '重庆永川区--学府大道店', '15823514489', 784159469637468160, '1', '重庆永川区--学府大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10230, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '任永红', '膏霜任永红13635476246，洗发水不清楚', '重庆永川区--永川协信店', '13635476246', 784159469637468160, '1', '重庆永川区--永川协信店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10232, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '孙秋霞', '膏霜+洗护孙秋霞13983563511', '重庆渝北区--爱琴海店', '13983563511', 784159469637468160, '1', '重庆渝北区--爱琴海店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10234, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '庞小义', '膏霜+洗护庞小义17383168285', '重庆渝北区--斑竹路店', '17383168285', 784159469637468160, '1', '重庆渝北区--斑竹路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10236, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '冯委', '膏霜+洗护冯委15683128608', '重庆渝北区--宝圣西路店', '15683128608', 784159469637468160, '1', '重庆渝北区--宝圣西路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10238, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '廖宇', '膏霜+洗护廖宇13527509053', '重庆渝北区--东和春天店', '13527509053', 784159469637468160, '1', '重庆渝北区--东和春天店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10240, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '杨传容', '膏霜+洗护杨传容15215096819', '重庆渝北区--黄泥塝店', '15215096819', 784159469637468160, '1', '重庆渝北区--黄泥塝店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10242, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '常津罱', '膏霜+洗护常津罱13657638027', '重庆渝北区--加州店', '13657638027', 784159469637468160, '1', '重庆渝北区--加州店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10244, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '夏萍', '膏霜+洗护夏萍18202335355', '重庆渝北区--金开大道店', '18202335355', 784159469637468160, '1', '重庆渝北区--金开大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10246, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '唐伏容', '膏霜+洗护唐伏容13598028478', '重庆渝北区--金渝大道店', '13598028478', 784159469637468160, '1', '重庆渝北区--金渝大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10248, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '冉仁丽', '膏霜+洗护冉仁丽13677692573', '重庆渝北区--空港大道店', '13677692573', 784159469637468160, '1', '重庆渝北区--空港大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10250, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李华渊', '膏霜+洗护李华渊15123161398', '重庆渝北区--空港店', '15123161398', 784159469637468160, '1', '重庆渝北区--空港店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10252, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '辜莉华', '洗发水专职：秦勤15683846396；膏霜辜莉华18223456257', '重庆渝北区--兰馨大道店', '18223456257', 784159469637468160, '1', '重庆渝北区--兰馨大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10254, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '周顺梅', '膏霜+洗护周顺梅19923352755', '重庆渝北区--龙湖源著天街店', '19923352755', 784159469637468160, '1', '重庆渝北区--龙湖源著天街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10256, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '邹敏', '洗发水专职：张平17774918376，膏霜邹敏13635442183', '重庆渝北区--龙头寺店', '13635442183', 784159469637468160, '1', '重庆渝北区--龙头寺店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10258, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘文琴', '膏霜+洗护刘文琴13212358563', '重庆渝北区--双龙店', '13212358563', 784159469637468160, '1', '重庆渝北区--双龙店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10260, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '饶玉竹', '膏霜+洗护饶玉竹13140379382', '重庆渝北区--水木天地店', '13140379382', 784159469637468160, '1', '重庆渝北区--水木天地店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10262, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '陈忠英', '膏霜+洗护陈忠英18203031697', '重庆渝北区--泰山大道店', '18203031697', 784159469637468160, '1', '重庆渝北区--泰山大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10264, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '齐红', '膏霜+洗护齐红17723170186', '重庆渝北区--武陵路店', '17723170186', 784159469637468160, '1', '重庆渝北区--武陵路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10266, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李林会', '膏霜+洗护李林会13668005915', '重庆渝北区--喜悦汇店', '13668005915', 784159469637468160, '1', '重庆渝北区--喜悦汇店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10268, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '龚兴兰', '膏霜+洗护龚兴兰15023393423', '重庆渝北区--星光天地店', '15023393423', 784159469637468160, '1', '重庆渝北区--星光天地店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10270, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '张玉勤', '膏霜+洗护张玉勤15802859463', '重庆渝北区--星湖路店', '15802859463', 784159469637468160, '1', '重庆渝北区--星湖路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10272, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '沈家兰', '膏霜+洗护张学会 15002396580,膏霜沈家兰17383019213', '重庆渝北区--兴科大道店', '17383019213', 784159469637468160, '1', '重庆渝北区--兴科大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10274, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '戴淑英', '膏霜+洗护戴淑英13883869679', '重庆渝中区--白象街店', '13883869679', 784159469637468160, '1', '重庆渝中区--白象街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10276, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李玉兰', '膏霜李玉兰15808060393、洗护张娟13368476568', '重庆渝中区--大坪店', '15808060393', 784159469637468160, '1', '重庆渝中区--大坪店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10278, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '吴秀英', '膏霜+洗护吴秀英15823525529', '重庆渝中区--大坪协信店', '15823525529', 784159469637468160, '1', '重庆渝中区--大坪协信店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10280, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李延菊', '膏霜+洗护李延菊13271939174', '重庆渝中区--较场口店', '13271939174', 784159469637468160, '1', '重庆渝中区--较场口店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10282, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '龚维芳', '膏霜+洗护龚维芳15723008678', '重庆渝中区--龙湖时代天街店', '15723008678', 784159469637468160, '1', '重庆渝中区--龙湖时代天街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10284, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '王琼', '膏霜+洗护王琼13678462596', '重庆渝中区--人和街店', '13678462596', 784159469637468160, '1', '重庆渝中区--人和街店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10286, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '余敏', '膏霜+洗护余敏15703073936', '重庆长寿区--盛世桃源店', '15703073936', 784159469637468160, '1', '重庆长寿区--盛世桃源店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10288, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '李芳容', '膏霜+洗护李芳容15909324992', '重庆长寿区--桃源大道店', '15909324992', 784159469637468160, '1', '重庆长寿区--桃源大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10290, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '任莲', '膏霜任莲13368259908，洗护余红17772364396。儿童周春梅15111911212', '重庆长寿区--协信店', '13368259908', 784159469637468160, '1', '重庆长寿区--协信店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10292, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '刘定霞', '膏霜+洗护刘定霞15025536106', '重庆忠县--中博大道店', '15025536106', 784159469637468160, '1', '重庆忠县--中博大道店', 889189185951367168);
INSERT INTO `wms_address` VALUES (10294, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '韩亚林', '膏霜+洗护韩亚林13638275003', '重庆忠县--忠县环城路店', '13638275003', 784159469637468160, '1', '重庆忠县--忠县环城路店', 889189185951367168);
INSERT INTO `wms_address` VALUES (784159810646966272, '2020-12-03 20:51:08', '2021-09-19 17:00:29', '张先生', '备注信息 注意安全', '重庆-吉安园11-2', '18588888888', 784159469637468160, '0.1', '重庆-江北店', 889189185951367168);

-- ----------------------------
-- Table structure for wms_address_area
-- ----------------------------
DROP TABLE IF EXISTS `wms_address_area`;
CREATE TABLE `wms_address_area`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_address_area
-- ----------------------------
INSERT INTO `wms_address_area` VALUES (10000, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '中百重庆市大渡口区--朵力店', NULL);
INSERT INTO `wms_address_area` VALUES (10002, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '中百重庆市南岸区--青龙路店', NULL);
INSERT INTO `wms_address_area` VALUES (10004, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '中百重庆市渝北区--宝圣二路店', NULL);
INSERT INTO `wms_address_area` VALUES (10006, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '中百重庆市渝北区--宝圣一店', NULL);
INSERT INTO `wms_address_area` VALUES (10008, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '中百重庆市渝北区--龙兴店', NULL);
INSERT INTO `wms_address_area` VALUES (10010, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '中百重庆市渝北区--上品十六店', NULL);
INSERT INTO `wms_address_area` VALUES (10012, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重两江新区--嘉和路店', NULL);
INSERT INTO `wms_address_area` VALUES (10014, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆巴南区—巴南万达店', NULL);
INSERT INTO `wms_address_area` VALUES (10016, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆巴南区--都和广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10018, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆巴南区--人民广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10020, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆巴南区--土桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10022, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆北碚区--缙云大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10024, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆北碚区--双元大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10026, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆北碚区--天生丽街店', NULL);
INSERT INTO `wms_address_area` VALUES (10028, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆北碚区--文星湾旺德旺城店', NULL);
INSERT INTO `wms_address_area` VALUES (10030, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆璧山县--金山广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10032, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆璧山县--青杠店', NULL);
INSERT INTO `wms_address_area` VALUES (10034, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆璧山县--时代商都店', NULL);
INSERT INTO `wms_address_area` VALUES (10036, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大渡口区--大渡口万达店', NULL);
INSERT INTO `wms_address_area` VALUES (10038, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大渡口区--香港城店', NULL);
INSERT INTO `wms_address_area` VALUES (10040, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大渡口区--壹街购物中心店', NULL);
INSERT INTO `wms_address_area` VALUES (10042, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大渡口区--中房店', NULL);
INSERT INTO `wms_address_area` VALUES (10044, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大渡口区--中交丽景店', NULL);
INSERT INTO `wms_address_area` VALUES (10046, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大足区--五星大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10048, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大足县--国梁店', NULL);
INSERT INTO `wms_address_area` VALUES (10050, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆大足县--双桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10052, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆垫江县--昆翔明悦天店', NULL);
INSERT INTO `wms_address_area` VALUES (10054, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆垫江县--西欧花园店', NULL);
INSERT INTO `wms_address_area` VALUES (10056, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆丰都区--久桓大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10058, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆涪陵区--涪陵宝龙店', NULL);
INSERT INTO `wms_address_area` VALUES (10060, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆涪陵区--涪陵万达店', NULL);
INSERT INTO `wms_address_area` VALUES (10062, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆涪陵区--南门山金科店', NULL);
INSERT INTO `wms_address_area` VALUES (10064, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆涪陵区--泽胜广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10066, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆涪陵区--中慧西街店', NULL);
INSERT INTO `wms_address_area` VALUES (10068, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆合川区--合川宝龙店', NULL);
INSERT INTO `wms_address_area` VALUES (10070, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆合川区--金世纪广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10072, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--大石坝店', NULL);
INSERT INTO `wms_address_area` VALUES (10074, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--观音桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10076, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--国奥村店', NULL);
INSERT INTO `wms_address_area` VALUES (10078, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--建新东路店', NULL);
INSERT INTO `wms_address_area` VALUES (10080, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--金源时代购物中心店', NULL);
INSERT INTO `wms_address_area` VALUES (10082, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--龙湖新壹街店', NULL);
INSERT INTO `wms_address_area` VALUES (10084, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--望江店', NULL);
INSERT INTO `wms_address_area` VALUES (10086, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--五里店', NULL);
INSERT INTO `wms_address_area` VALUES (10088, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江北区--永辉生活广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10090, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江津区--江津西江大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10092, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江津区--江洲大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10094, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江津区--双福星街店', NULL);
INSERT INTO `wms_address_area` VALUES (10096, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆江津区--塔坪路店', NULL);
INSERT INTO `wms_address_area` VALUES (10098, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--奥园盘龙店', NULL);
INSERT INTO `wms_address_area` VALUES (10100, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--白市驿店', NULL);
INSERT INTO `wms_address_area` VALUES (10102, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--华福金科店', NULL);
INSERT INTO `wms_address_area` VALUES (10104, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--龙湖新壹城店', NULL);
INSERT INTO `wms_address_area` VALUES (10106, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--民生广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10108, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--石坪桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10110, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--石桥铺店', NULL);
INSERT INTO `wms_address_area` VALUES (10112, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--西城天街店', NULL);
INSERT INTO `wms_address_area` VALUES (10114, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--谢家湾店', NULL);
INSERT INTO `wms_address_area` VALUES (10116, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--渝州路店', NULL);
INSERT INTO `wms_address_area` VALUES (10118, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆开县--新天地店', NULL);
INSERT INTO `wms_address_area` VALUES (10120, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆开县--云枫嶺尚城店', NULL);
INSERT INTO `wms_address_area` VALUES (10122, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆梁平县--大众店', NULL);
INSERT INTO `wms_address_area` VALUES (10124, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆梁平县--西池广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10126, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆九龙坡区--仁悦天地店', NULL);
INSERT INTO `wms_address_area` VALUES (10128, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--奥园城市天地店', NULL);
INSERT INTO `wms_address_area` VALUES (10130, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--茶园金科店', NULL);
INSERT INTO `wms_address_area` VALUES (10132, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--崇文店', NULL);
INSERT INTO `wms_address_area` VALUES (10134, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--弹新街店', NULL);
INSERT INTO `wms_address_area` VALUES (10136, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--风临路店', NULL);
INSERT INTO `wms_address_area` VALUES (10138, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--南湖花园店', NULL);
INSERT INTO `wms_address_area` VALUES (10140, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--南坪东路店', NULL);
INSERT INTO `wms_address_area` VALUES (10142, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--四公里店', NULL);
INSERT INTO `wms_address_area` VALUES (10144, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--腾龙大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10146, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南岸区--万达广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10148, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南川区--南川万达店', NULL);
INSERT INTO `wms_address_area` VALUES (10150, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南川区--南大街店', NULL);
INSERT INTO `wms_address_area` VALUES (10152, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆南川区--渝南大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10154, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆綦江县--河东店', NULL);
INSERT INTO `wms_address_area` VALUES (10156, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆綦江县--河西店', NULL);
INSERT INTO `wms_address_area` VALUES (10158, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆綦江县--九龙大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10160, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆綦江县--綦江万达广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10162, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆黔江区--丽都花苑店', NULL);
INSERT INTO `wms_address_area` VALUES (10164, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆荣昌县--莲花广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10166, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆荣昌县--荣昌迎宾大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10168, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆荣昌县--沿河中路店', NULL);
INSERT INTO `wms_address_area` VALUES (10170, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--陈家桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10172, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--春华秋实店', NULL);
INSERT INTO `wms_address_area` VALUES (10174, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--汉渝路店', NULL);
INSERT INTO `wms_address_area` VALUES (10176, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--嘉茂购物中心店', NULL);
INSERT INTO `wms_address_area` VALUES (10178, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--联芳桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10180, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--龙湖大学城店', NULL);
INSERT INTO `wms_address_area` VALUES (10182, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--沙坪坝万达广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10184, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--双碑鼎盛店', NULL);
INSERT INTO `wms_address_area` VALUES (10186, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--天星桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10188, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--童家桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10190, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆沙坪坝区--新桥店', NULL);
INSERT INTO `wms_address_area` VALUES (10192, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆石柱县--康德中央大街店', NULL);
INSERT INTO `wms_address_area` VALUES (10194, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆市沙坪坝区--西林大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10196, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆市酉阳县--碧津广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10198, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆市渝北区--红叶路店', NULL);
INSERT INTO `wms_address_area` VALUES (10200, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆市渝北区--赛迪路店', NULL);
INSERT INTO `wms_address_area` VALUES (10202, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆市忠县--财富广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10204, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆铜梁县--广龙明珠店', NULL);
INSERT INTO `wms_address_area` VALUES (10206, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆潼南县--东安大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10208, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆潼南区--巴渝大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10210, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆万盛区--民盛店', NULL);
INSERT INTO `wms_address_area` VALUES (10212, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆万盛区--万盛名都店', NULL);
INSERT INTO `wms_address_area` VALUES (10214, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆万州区--北城中心广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10216, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆万州区--国贸广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10218, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆万州区--万州万达店', NULL);
INSERT INTO `wms_address_area` VALUES (10220, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆万州区--王牌路店', NULL);
INSERT INTO `wms_address_area` VALUES (10222, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆巫山县--神女尚熙台店', NULL);
INSERT INTO `wms_address_area` VALUES (10224, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆武隆县--南城中央广场店', NULL);
INSERT INTO `wms_address_area` VALUES (10226, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆秀山县-渝秀大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10228, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆永川区--学府大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10230, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆永川区--永川协信店', NULL);
INSERT INTO `wms_address_area` VALUES (10232, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--爱琴海店', NULL);
INSERT INTO `wms_address_area` VALUES (10234, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--斑竹路店', NULL);
INSERT INTO `wms_address_area` VALUES (10236, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--宝圣西路店', NULL);
INSERT INTO `wms_address_area` VALUES (10238, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--东和春天店', NULL);
INSERT INTO `wms_address_area` VALUES (10240, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--黄泥塝店', NULL);
INSERT INTO `wms_address_area` VALUES (10242, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--加州店', NULL);
INSERT INTO `wms_address_area` VALUES (10244, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--金开大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10246, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--金渝大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10248, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--空港大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10250, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--空港店', NULL);
INSERT INTO `wms_address_area` VALUES (10252, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--兰馨大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10254, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--龙湖源著天街店', NULL);
INSERT INTO `wms_address_area` VALUES (10256, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--龙头寺店', NULL);
INSERT INTO `wms_address_area` VALUES (10258, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--双龙店', NULL);
INSERT INTO `wms_address_area` VALUES (10260, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--水木天地店', NULL);
INSERT INTO `wms_address_area` VALUES (10262, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--泰山大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10264, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--武陵路店', NULL);
INSERT INTO `wms_address_area` VALUES (10266, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--喜悦汇店', NULL);
INSERT INTO `wms_address_area` VALUES (10268, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--星光天地店', NULL);
INSERT INTO `wms_address_area` VALUES (10270, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--星湖路店', NULL);
INSERT INTO `wms_address_area` VALUES (10272, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝北区--兴科大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10274, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝中区--白象街店', NULL);
INSERT INTO `wms_address_area` VALUES (10276, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝中区--大坪店', NULL);
INSERT INTO `wms_address_area` VALUES (10278, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝中区--大坪协信店', NULL);
INSERT INTO `wms_address_area` VALUES (10280, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝中区--较场口店', NULL);
INSERT INTO `wms_address_area` VALUES (10282, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝中区--龙湖时代天街店', NULL);
INSERT INTO `wms_address_area` VALUES (10284, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆渝中区--人和街店', NULL);
INSERT INTO `wms_address_area` VALUES (10286, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆长寿区--盛世桃源店', NULL);
INSERT INTO `wms_address_area` VALUES (10288, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆长寿区--桃源大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10290, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆长寿区--协信店', NULL);
INSERT INTO `wms_address_area` VALUES (10292, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆忠县--中博大道店', NULL);
INSERT INTO `wms_address_area` VALUES (10294, '2021-09-19 00:00:00', '2021-09-19 00:00:00', '重庆忠县--忠县环城路店', NULL);
INSERT INTO `wms_address_area` VALUES (889189185951367168, '2021-09-19 16:40:22', '2021-09-19 16:42:28', '重庆', 1);
INSERT INTO `wms_address_area` VALUES (889189564738961408, '2021-09-19 16:41:53', '2021-09-19 16:42:35', '成都', 2);

-- ----------------------------
-- Table structure for wms_address_type
-- ----------------------------
DROP TABLE IF EXISTS `wms_address_type`;
CREATE TABLE `wms_address_type`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_address_type
-- ----------------------------
INSERT INTO `wms_address_type` VALUES (784159469637468160, '2020-12-03 20:49:47', '2020-12-03 20:49:47', '默认', 1);

-- ----------------------------
-- Table structure for wms_car
-- ----------------------------
DROP TABLE IF EXISTS `wms_car`;
CREATE TABLE `wms_car`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `car_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `car_driver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `car_model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `car_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `car_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `car_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '车辆信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_car
-- ----------------------------

-- ----------------------------
-- Table structure for wms_car_cost
-- ----------------------------
DROP TABLE IF EXISTS `wms_car_cost`;
CREATE TABLE `wms_car_cost`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `car_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date_time` datetime(0) NULL DEFAULT NULL,
  `driver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mile` double NULL DEFAULT NULL,
  `oil_cost` double NULL DEFAULT NULL,
  `parking_charge` double NULL DEFAULT NULL,
  `toll_charge` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '车辆费用信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_car_cost
-- ----------------------------
INSERT INTO `wms_car_cost` VALUES (789682175447400448, '2020-12-19 02:35:02', '2020-12-19 02:51:52', '3', '2020-12-11 02:34:56', '12', 12, 12, 12, 12);

-- ----------------------------
-- Table structure for wms_count_stock
-- ----------------------------
DROP TABLE IF EXISTS `wms_count_stock`;
CREATE TABLE `wms_count_stock`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `current_quantity` bigint(0) NULL DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `months_of_warranty` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pack_count` int(0) NOT NULL,
  `quantity` bigint(0) NULL DEFAULT NULL,
  `sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ware_position_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_count_stock
-- ----------------------------
INSERT INTO `wms_count_stock` VALUES (828276292750147584, '2021-04-04 14:34:17', '2021-04-04 14:34:17', 66, '宝供物流', 48, '英特尔（Intel）i5-10400', 1, NULL, '1606996819404', '重庆市南坪红旗河沟茂山路22号A区--001', '2020-12-15');
INSERT INTO `wms_count_stock` VALUES (828276292750147585, '2021-04-04 14:34:17', '2021-04-04 14:34:17', 66, '宝供物流', 36, '相框（8寸）', 12, NULL, '1606996819466', '重庆市南坪红旗河沟茂山路22号A区-003', '2025-01-02');

-- ----------------------------
-- Table structure for wms_customer
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer`;
CREATE TABLE `wms_customer`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `short_name_cn` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `short_name_en` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_customer
-- ----------------------------
INSERT INTO `wms_customer` VALUES (86, '2021-07-17 18:06:12', '2021-07-17 18:10:51', '重庆市展鹿商贸有限公司', '展鹿商贸', 'ZL');
INSERT INTO `wms_customer` VALUES (87, '2021-07-17 18:06:12', '2021-07-17 18:10:48', '四川省和谊华辉责任有限公司', '和谊华辉责任', 'HY');
INSERT INTO `wms_customer` VALUES (88, '2021-07-17 18:06:12', '2021-07-17 18:10:45', '重庆市沿泰贸易有限公司', '沿泰贸易', 'YT');
INSERT INTO `wms_customer` VALUES (91, '2021-07-17 18:06:12', '2021-07-17 18:10:42', '成都世泽尚秀商贸有限公司', '世泽尚秀商贸', 'SZSX');
INSERT INTO `wms_customer` VALUES (93, '2021-07-17 18:06:12', '2021-07-17 18:10:39', '成都美丝丽贸易有限公司', '美丝丽贸易', 'MSL');

-- ----------------------------
-- Table structure for wms_customer_order
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order`;
CREATE TABLE `wms_customer_order`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `auto_increase_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cancel_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `client_operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_order_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_order_sn2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_store` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `complete_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `complete_price` decimal(19, 2) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expire_date_max` date NULL DEFAULT NULL,
  `expire_date_min` date NULL DEFAULT NULL,
  `fetch_all` bit(1) NOT NULL,
  `flow_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_active` bit(1) NULL DEFAULT NULL,
  `is_printed` bit(1) NULL DEFAULT NULL,
  `is_satisfied` bit(1) NULL DEFAULT NULL,
  `order_status` int(0) NULL DEFAULT NULL,
  `target_ware_zones` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `total_price` decimal(19, 2) NULL DEFAULT NULL,
  `use_pack_count` bit(1) NULL DEFAULT NULL,
  `owner_id` bigint(0) NULL DEFAULT NULL,
  `user_creator_id` bigint(0) NULL DEFAULT NULL,
  `user_gathering_id` bigint(0) NULL DEFAULT NULL,
  `sign_time` datetime(0) NULL DEFAULT NULL,
  `print_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `receive_type` int(0) NULL DEFAULT NULL,
  `user_reviewer_id` bigint(0) NULL DEFAULT NULL,
  `quality_assurance_exponent` float NULL DEFAULT NULL,
  `wait_gathering_num` int(0) NULL DEFAULT NULL,
  `wait_reviewer_num` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK87o5jxxtu5fj0oppo2pxvk23k`(`owner_id`) USING BTREE,
  INDEX `FKj4t64s5hnf1obetdw0vsvpl86`(`user_creator_id`) USING BTREE,
  INDEX `FKenc9bneww5jo89i0fos6b4nx7`(`user_gathering_id`) USING BTREE,
  INDEX `FK6vec2wd3skfu4js6f20vl1mf4`(`user_reviewer_id`) USING BTREE,
  CONSTRAINT `FK6vec2wd3skfu4js6f20vl1mf4` FOREIGN KEY (`user_reviewer_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK87o5jxxtu5fj0oppo2pxvk23k` FOREIGN KEY (`owner_id`) REFERENCES `wms_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKenc9bneww5jo89i0fos6b4nx7` FOREIGN KEY (`user_gathering_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKj4t64s5hnf1obetdw0vsvpl86` FOREIGN KEY (`user_creator_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_customer_order
-- ----------------------------

-- ----------------------------
-- Table structure for wms_customer_order_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order_item`;
CREATE TABLE `wms_customer_order_item`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pack_count` int(0) NULL DEFAULT NULL,
  `price` decimal(19, 2) NULL DEFAULT NULL,
  `quantity` bigint(0) NULL DEFAULT NULL,
  `quantity_initial` bigint(0) NULL DEFAULT NULL,
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  `customer_order_id` bigint(0) NULL DEFAULT NULL,
  `months_of_warranty` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKcigudap8fdsaygbfgnnje4hfs`(`customer_order_id`) USING BTREE,
  CONSTRAINT `FKcigudap8fdsaygbfgnnje4hfs` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_customer_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for wms_customer_order_page
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order_page`;
CREATE TABLE `wms_customer_order_page`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `flow_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `order_status` int(0) NULL DEFAULT NULL,
  `customer_order_id` bigint(0) NULL DEFAULT NULL,
  `num` int(0) NULL DEFAULT NULL,
  `receive_type` int(0) NULL DEFAULT NULL,
  `pack_id` bigint(0) NULL DEFAULT NULL,
  `user_sending_id` bigint(0) NULL DEFAULT NULL,
  `total_price` decimal(19, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK2rby1wdsdcojfy32m6ks97dyl`(`customer_order_id`) USING BTREE,
  INDEX `FK6i7j8w4t0kybe6mbmhr0fftcy`(`pack_id`) USING BTREE,
  INDEX `FKevv60ptqyrc4q39hdh7gigd2f`(`user_sending_id`) USING BTREE,
  CONSTRAINT `FK2rby1wdsdcojfy32m6ks97dyl` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK6i7j8w4t0kybe6mbmhr0fftcy` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKevv60ptqyrc4q39hdh7gigd2f` FOREIGN KEY (`user_sending_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_customer_order_page
-- ----------------------------

-- ----------------------------
-- Table structure for wms_customer_order_stock
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order_stock`;
CREATE TABLE `wms_customer_order_stock`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `price` decimal(19, 2) NULL DEFAULT NULL,
  `quantity` bigint(0) NULL DEFAULT NULL,
  `quantity_initial` bigint(0) NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  `customer_order_id` bigint(0) NULL DEFAULT NULL,
  `goods_id` bigint(0) NULL DEFAULT NULL,
  `ware_position_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKnelosame93oc8dk3paj6s8xh1`(`customer_order_id`) USING BTREE,
  INDEX `FKobf4ws7hvxnl4xu9e53orq6h0`(`goods_id`) USING BTREE,
  INDEX `FK75nd8dwqxnhjky9x1s8j1fep0`(`ware_position_id`) USING BTREE,
  CONSTRAINT `FK75nd8dwqxnhjky9x1s8j1fep0` FOREIGN KEY (`ware_position_id`) REFERENCES `wms_ware_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKnelosame93oc8dk3paj6s8xh1` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKobf4ws7hvxnl4xu9e53orq6h0` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_customer_order_stock
-- ----------------------------

-- ----------------------------
-- Table structure for wms_dispatch_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `wms_dispatch_coefficient`;
CREATE TABLE `wms_dispatch_coefficient`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `dispatch` float NULL DEFAULT NULL,
  `mileage` float NULL DEFAULT NULL,
  `store` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配送计件系数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_dispatch_coefficient
-- ----------------------------
INSERT INTO `wms_dispatch_coefficient` VALUES (1, '2020-12-08 23:48:01', '2020-12-08 23:59:31', 0.1, 0.2, 0.1);

-- ----------------------------
-- Table structure for wms_dispatch_piece
-- ----------------------------
DROP TABLE IF EXISTS `wms_dispatch_piece`;
CREATE TABLE `wms_dispatch_piece`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `dispatch_price` float NULL DEFAULT NULL,
  `dispatch_sum` int(0) NULL DEFAULT NULL,
  `mileage` float NULL DEFAULT NULL,
  `mileage_price` float NULL DEFAULT NULL,
  `score` float NULL DEFAULT NULL,
  `status` int(0) NULL DEFAULT NULL,
  `store_num` int(0) NULL DEFAULT NULL,
  `store_price` float NULL DEFAULT NULL,
  `dispatch_sys_id` bigint(0) NULL DEFAULT NULL,
  `user_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKo13ne2y10rrj4wochajsffvwb`(`dispatch_sys_id`) USING BTREE,
  INDEX `FKddm8g6ln7hoaj5g91oy01il1j`(`user_id`) USING BTREE,
  CONSTRAINT `FKddm8g6ln7hoaj5g91oy01il1j` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKo13ne2y10rrj4wochajsffvwb` FOREIGN KEY (`dispatch_sys_id`) REFERENCES `wms_dispatch_sys_coefficient` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配送计件信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_dispatch_piece
-- ----------------------------
INSERT INTO `wms_dispatch_piece` VALUES (787529668998725632, '2020-12-13 04:01:45', '2020-12-14 23:50:38', 0.1, 10, 5, 0.2, 2.73, 1, 1, 0.1, 786031512658116608, 4);
INSERT INTO `wms_dispatch_piece` VALUES (799902978344484864, '2021-01-16 07:28:52', '2021-01-16 07:29:23', 0.1, 15, 5, 0.2, 3.38, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (799906219086053376, '2021-01-16 07:41:44', '2021-01-16 07:41:51', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (799959509018607616, '2021-01-16 11:13:29', '2021-01-16 11:13:47', 0.1, 3, 5, 0.2, 1.82, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (815509506673868800, '2021-02-28 09:03:38', '2021-02-28 09:04:19', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 4);
INSERT INTO `wms_dispatch_piece` VALUES (815510775643766784, '2021-02-28 09:08:40', '2021-02-28 09:09:40', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 5);
INSERT INTO `wms_dispatch_piece` VALUES (815513716006060032, '2021-02-28 09:20:21', '2021-02-28 09:20:50', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (815515848474099712, '2021-02-28 09:28:50', '2021-02-28 09:29:03', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 4);
INSERT INTO `wms_dispatch_piece` VALUES (816487874164686848, '2021-03-03 01:51:19', '2021-03-03 01:51:30', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (816488718599716864, '2021-03-03 01:54:40', '2021-03-03 01:54:50', 0.1, 10, 5, 0.2, 1.26, 1, 1, 0.1, 787437343387680768, 6);
INSERT INTO `wms_dispatch_piece` VALUES (825317421228228608, '2021-03-27 10:36:47', '2021-03-27 10:37:08', 0.1, 2, 5, 0.2, 0.78, 1, 1, 0.1, 787437343387680768, 6);
INSERT INTO `wms_dispatch_piece` VALUES (828290490485964800, '2021-04-04 15:30:42', '2021-04-04 15:31:03', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (828637299590823936, '2021-04-05 14:28:48', '2021-04-05 14:29:30', 0.1, 1, 5, 0.2, 1.56, 1, 1, 0.1, 786031512658116608, 6);
INSERT INTO `wms_dispatch_piece` VALUES (828639917067206656, '2021-04-05 14:39:12', '2021-04-05 14:39:30', 0.1, 2, 5, 0.2, 1.69, 1, 1, 0.1, 786031512658116608, 6);

-- ----------------------------
-- Table structure for wms_dispatch_sys_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `wms_dispatch_sys_coefficient`;
CREATE TABLE `wms_dispatch_sys_coefficient`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配送计件系统系数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_dispatch_sys_coefficient
-- ----------------------------
INSERT INTO `wms_dispatch_sys_coefficient` VALUES (786031512658116608, '2020-12-09 00:48:36', '2020-12-12 21:54:24', '永辉', 13);
INSERT INTO `wms_dispatch_sys_coefficient` VALUES (787437306188398592, '2020-12-12 21:54:44', '2020-12-12 21:54:44', '嘉电子', 12);
INSERT INTO `wms_dispatch_sys_coefficient` VALUES (787437343387680768, '2020-12-12 21:54:53', '2020-12-12 21:54:53', '新世纪', 6);

-- ----------------------------
-- Table structure for wms_fixed_estate
-- ----------------------------
DROP TABLE IF EXISTS `wms_fixed_estate`;
CREATE TABLE `wms_fixed_estate`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `assets_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `assets_input_operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `assets_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `assets_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '固定资产' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_fixed_estate
-- ----------------------------

-- ----------------------------
-- Table structure for wms_goods
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods`;
CREATE TABLE `wms_goods`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `months_of_warranty` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pack_count` int(0) NOT NULL,
  `price` float NOT NULL,
  `return_price` float NOT NULL,
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_id` bigint(0) NULL DEFAULT NULL,
  `goods_type_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKivxemy2vpkuws6w84xp8q5obh`(`customer_id`) USING BTREE,
  INDEX `FKeabmgyqha1j52id423urd1prb`(`goods_type_id`) USING BTREE,
  CONSTRAINT `FKeabmgyqha1j52id423urd1prb` FOREIGN KEY (`goods_type_id`) REFERENCES `wms_goods_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKivxemy2vpkuws6w84xp8q5obh` FOREIGN KEY (`customer_id`) REFERENCES `wms_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_goods
-- ----------------------------
INSERT INTO `wms_goods` VALUES (866019825879613440, '2021-07-17 18:13:36', '2021-07-17 18:13:36', NULL, 12, '键盘', 1, 100, 100, '1610335564596', '台', 87, 802987006039687168);

-- ----------------------------
-- Table structure for wms_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods_type`;
CREATE TABLE `wms_goods_type`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_goods_type
-- ----------------------------
INSERT INTO `wms_goods_type` VALUES (784145672067612672, '2020-12-03 19:54:57', '2020-12-03 19:54:57', '电子', 1);
INSERT INTO `wms_goods_type` VALUES (784145702568591360, '2020-12-03 19:55:04', '2020-12-03 19:55:21', '食品', 2);
INSERT INTO `wms_goods_type` VALUES (784145755479736320, '2020-12-03 19:55:17', '2020-12-03 19:55:17', '水果', 3);
INSERT INTO `wms_goods_type` VALUES (802987006039687168, '2021-01-24 19:43:41', '2021-01-24 19:43:41', '日用', NULL);
INSERT INTO `wms_goods_type` VALUES (802987053938638848, '2021-01-24 19:43:52', '2021-01-24 19:43:52', '干活', NULL);

-- ----------------------------
-- Table structure for wms_join_table_customer_orders_page_user_gatherings
-- ----------------------------
DROP TABLE IF EXISTS `wms_join_table_customer_orders_page_user_gatherings`;
CREATE TABLE `wms_join_table_customer_orders_page_user_gatherings`  (
  `orders_gathering_id` bigint(0) NOT NULL,
  `user_gatherings_id` bigint(0) NOT NULL,
  INDEX `FK72en6qklsric88phq2ydhol7j`(`user_gatherings_id`) USING BTREE,
  INDEX `FKqdo3kjb7s7qcktyyx9o2n6lo3`(`orders_gathering_id`) USING BTREE,
  CONSTRAINT `FK72en6qklsric88phq2ydhol7j` FOREIGN KEY (`user_gatherings_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKqdo3kjb7s7qcktyyx9o2n6lo3` FOREIGN KEY (`orders_gathering_id`) REFERENCES `wms_customer_order_page` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_join_table_customer_orders_page_user_gatherings
-- ----------------------------

-- ----------------------------
-- Table structure for wms_join_table_customer_orders_page_user_reviewers
-- ----------------------------
DROP TABLE IF EXISTS `wms_join_table_customer_orders_page_user_reviewers`;
CREATE TABLE `wms_join_table_customer_orders_page_user_reviewers`  (
  `orders_reviewer_id` bigint(0) NOT NULL,
  `user_reviewers_id` bigint(0) NOT NULL,
  INDEX `FKfu5od7pe0kqa3uk938pi7if9w`(`user_reviewers_id`) USING BTREE,
  INDEX `FK9n1cy0jqrvhpde6k4xjdx4axp`(`orders_reviewer_id`) USING BTREE,
  CONSTRAINT `FK9n1cy0jqrvhpde6k4xjdx4axp` FOREIGN KEY (`orders_reviewer_id`) REFERENCES `wms_customer_order_page` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKfu5od7pe0kqa3uk938pi7if9w` FOREIGN KEY (`user_reviewers_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_join_table_customer_orders_page_user_reviewers
-- ----------------------------

-- ----------------------------
-- Table structure for wms_join_table_customers_users
-- ----------------------------
DROP TABLE IF EXISTS `wms_join_table_customers_users`;
CREATE TABLE `wms_join_table_customers_users`  (
  `customers_id` bigint(0) NOT NULL,
  `users_id` bigint(0) NOT NULL,
  INDEX `FKe986ai7mjfj66xgasvc2d97tc`(`users_id`) USING BTREE,
  INDEX `FKnhxi99588dm2fosv8ggav9y8f`(`customers_id`) USING BTREE,
  CONSTRAINT `FKe986ai7mjfj66xgasvc2d97tc` FOREIGN KEY (`users_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKnhxi99588dm2fosv8ggav9y8f` FOREIGN KEY (`customers_id`) REFERENCES `wms_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_join_table_customers_users
-- ----------------------------
INSERT INTO `wms_join_table_customers_users` VALUES (93, 4);
INSERT INTO `wms_join_table_customers_users` VALUES (91, 4);
INSERT INTO `wms_join_table_customers_users` VALUES (88, 4);
INSERT INTO `wms_join_table_customers_users` VALUES (87, 4);
INSERT INTO `wms_join_table_customers_users` VALUES (86, 4);

-- ----------------------------
-- Table structure for wms_logistics_detail
-- ----------------------------
DROP TABLE IF EXISTS `wms_logistics_detail`;
CREATE TABLE `wms_logistics_detail`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `bill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `compute_weight` int(0) NULL DEFAULT NULL,
  `first` int(0) NULL DEFAULT NULL,
  `first_price` int(0) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `piece` int(0) NULL DEFAULT NULL,
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `reality_weight` int(0) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `renew` int(0) NULL DEFAULT NULL,
  `renew_num` int(0) NULL DEFAULT NULL,
  `renew_price` int(0) NULL DEFAULT NULL,
  `total_price` int(0) NULL DEFAULT NULL,
  `address_id` bigint(0) NULL DEFAULT NULL,
  `customer_id` bigint(0) NULL DEFAULT NULL,
  `logistics_template_id` bigint(0) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `customer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `protect_price` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKg0ovv152gkagxjnnrc25xto4y`(`address_id`) USING BTREE,
  INDEX `FKj8tt187nqv6ouhwp637lqghag`(`customer_id`) USING BTREE,
  INDEX `FKgl4tsn31wq5g37ug53lus8ai`(`logistics_template_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '物流结算明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_logistics_detail
-- ----------------------------
INSERT INTO `wms_logistics_detail` VALUES (799883737855688704, '2021-01-16 06:12:24', '2021-01-16 07:12:24', '凄凄切切', 0, 1, 1, '客户管理', 3, '重庆', 0, '客户管理员', 1, 2, 1, 3, 784159810646966272, 784144733298491392, 799534242571747328, '重庆江北店', '宝供物流', NULL);
INSERT INTO `wms_logistics_detail` VALUES (799899071195119616, '2021-01-16 07:13:20', '2021-01-16 07:13:20', '凄凄切切', 800, 1, 1, '客户管理', 0, '重庆', 1000, '客户管理员', 1, 799, 1, 800, NULL, NULL, 799534242571747328, '重庆江北店', '宝供物流', NULL);
INSERT INTO `wms_logistics_detail` VALUES (816487888333045760, '2021-03-03 01:51:22', '2021-03-03 01:51:22', 'PK2103038110777372672', 1, 1, 1, '圆通', 1, '吉安园11', 1, NULL, 1, 0, 1, 1, NULL, NULL, NULL, '吉安园11-2', '宝供物流', NULL);
INSERT INTO `wms_logistics_detail` VALUES (816488734814896128, '2021-03-03 01:54:44', '2021-03-03 01:54:44', 'PK2103039133076058112', 10, 1, 1, '顺丰', 10, '重庆', 10, NULL, 1, 9, 1, 9, NULL, NULL, NULL, '重庆-吉安园11-2', '宝供物流', NULL);
INSERT INTO `wms_logistics_detail` VALUES (828637316619698176, '2021-04-05 14:28:52', '2021-04-05 14:28:52', 'PK2104057164328128512', 1, 1, 1, '顺丰', 1, '重庆', 1, NULL, 1, 0, 1, 1, NULL, NULL, NULL, '重庆-吉安园11-2', '宝供物流', NULL);
INSERT INTO `wms_logistics_detail` VALUES (828641181419175936, '2021-04-05 14:44:13', '2021-04-05 14:44:13', 'PK2104051438168715264', 1, 1, 1, '顺丰', 1, '重庆', 1, '', 1, 0, 1, 1, NULL, NULL, NULL, '重庆-吉安园11-2', '宝供物流', NULL);

-- ----------------------------
-- Table structure for wms_logistics_template
-- ----------------------------
DROP TABLE IF EXISTS `wms_logistics_template`;
CREATE TABLE `wms_logistics_template`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `date_time` datetime(0) NULL DEFAULT NULL,
  `first` float NULL DEFAULT NULL,
  `first_price` int(0) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `renew` float NULL DEFAULT NULL,
  `renew_price` int(0) NULL DEFAULT NULL,
  `type` bit(1) NULL DEFAULT NULL,
  `protect_price` int(0) NULL DEFAULT NULL,
  `address_area_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK8heggk29ggxvgnjbbeuqqj947`(`address_area_id`) USING BTREE,
  CONSTRAINT `FK8heggk29ggxvgnjbbeuqqj947` FOREIGN KEY (`address_area_id`) REFERENCES `wms_address_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '物流结算模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_logistics_template
-- ----------------------------
INSERT INTO `wms_logistics_template` VALUES (800418354824216576, '2021-01-17 17:36:47', '2021-09-19 16:43:08', '2021-01-17 00:00:00', 1.01, 1, '圆通', 1.01, 1, b'0', 0, 889189185951367168);
INSERT INTO `wms_logistics_template` VALUES (800421098129719296, '2021-01-17 17:47:41', '2021-09-19 16:43:12', '2021-01-16 00:00:00', 1.01, 1, '顺丰', 1.02, 1, b'1', 0, 889189564738961408);

-- ----------------------------
-- Table structure for wms_operate_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `wms_operate_snapshot`;
CREATE TABLE `wms_operate_snapshot`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_order_id` bigint(0) NULL DEFAULT NULL,
  `pack_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9ap438kqyd85r2oi7x3q1drq6`(`customer_order_id`) USING BTREE,
  INDEX `FK3b1iiekyytkxekqwlbjnc5qwr`(`pack_id`) USING BTREE,
  CONSTRAINT `FK3b1iiekyytkxekqwlbjnc5qwr` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK9ap438kqyd85r2oi7x3q1drq6` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_operate_snapshot
-- ----------------------------

-- ----------------------------
-- Table structure for wms_pack
-- ----------------------------
DROP TABLE IF EXISTS `wms_pack`;
CREATE TABLE `wms_pack`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `cancel_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flow_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_active` bit(1) NULL DEFAULT NULL,
  `is_packaged` bit(1) NULL DEFAULT NULL,
  `is_printed` bit(1) NULL DEFAULT NULL,
  `pack_status` int(0) NULL DEFAULT NULL,
  `pack_type` int(0) NULL DEFAULT NULL,
  `packages` int(0) NULL DEFAULT NULL,
  `signed_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `total_price` decimal(19, 2) NULL DEFAULT NULL,
  `tracking_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address_id` bigint(0) NULL DEFAULT NULL,
  `customer_id` bigint(0) NULL DEFAULT NULL,
  `user_id` bigint(0) NULL DEFAULT NULL,
  `receive_type` int(0) NULL DEFAULT NULL,
  `dispatch_piece_id` bigint(0) NULL DEFAULT NULL,
  `dispatch_user_id` bigint(0) NULL DEFAULT NULL,
  `weight` float NULL DEFAULT NULL,
  `logistics_template_id` bigint(0) NULL DEFAULT NULL,
  `reality_weight` float NULL DEFAULT NULL,
  `size` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK7v7oum3arwxl9du3vnoutdrfv`(`address_id`) USING BTREE,
  INDEX `FKrb2ekgr4me41uitq6vt67687`(`customer_id`) USING BTREE,
  INDEX `FKquvvxpiolia18jtbshgb9i35n`(`user_id`) USING BTREE,
  INDEX `FKcpyqwpiqimaby0qxbhbn3a4vl`(`dispatch_piece_id`) USING BTREE,
  INDEX `FKg74ua4rafwjedpu4m7tt73m21`(`dispatch_user_id`) USING BTREE,
  INDEX `FKhqr5dvjpiwslakqq7y9gmyxi7`(`logistics_template_id`) USING BTREE,
  CONSTRAINT `FK7v7oum3arwxl9du3vnoutdrfv` FOREIGN KEY (`address_id`) REFERENCES `wms_address` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKcpyqwpiqimaby0qxbhbn3a4vl` FOREIGN KEY (`dispatch_piece_id`) REFERENCES `wms_dispatch_piece` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKg74ua4rafwjedpu4m7tt73m21` FOREIGN KEY (`dispatch_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKhqr5dvjpiwslakqq7y9gmyxi7` FOREIGN KEY (`logistics_template_id`) REFERENCES `wms_logistics_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKquvvxpiolia18jtbshgb9i35n` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKrb2ekgr4me41uitq6vt67687` FOREIGN KEY (`customer_id`) REFERENCES `wms_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_pack
-- ----------------------------

-- ----------------------------
-- Table structure for wms_pack_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_pack_item`;
CREATE TABLE `wms_pack_item`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `expire_date` date NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `number` int(0) NOT NULL,
  `quantity` bigint(0) NOT NULL,
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pack_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK3wy5q1qnj3q1dgooxg15u3gfe`(`pack_id`) USING BTREE,
  CONSTRAINT `FK3wy5q1qnj3q1dgooxg15u3gfe` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_pack_item
-- ----------------------------

-- ----------------------------
-- Table structure for wms_pick_match
-- ----------------------------
DROP TABLE IF EXISTS `wms_pick_match`;
CREATE TABLE `wms_pick_match`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `money` float NULL DEFAULT NULL,
  `pick_match` float NULL DEFAULT NULL,
  `piece` float NULL DEFAULT NULL,
  `review` float NULL DEFAULT NULL,
  `score` float NULL DEFAULT NULL,
  `user_id` bigint(0) NULL DEFAULT NULL,
  `type` int(0) NULL DEFAULT NULL,
  `pack_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK8xm1105jmnf2y0jjs544960ey`(`user_id`) USING BTREE,
  INDEX `FKf6hk1xax6iokhh5ypgskk902n`(`pack_id`) USING BTREE,
  CONSTRAINT `FK8xm1105jmnf2y0jjs544960ey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKf6hk1xax6iokhh5ypgskk902n` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '拣配/复核计件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_pick_match
-- ----------------------------

-- ----------------------------
-- Table structure for wms_pick_match_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `wms_pick_match_coefficient`;
CREATE TABLE `wms_pick_match_coefficient`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `money` float NULL DEFAULT NULL,
  `pick_match` float NULL DEFAULT NULL,
  `piece` float NULL DEFAULT NULL COMMENT '计件系数',
  `review` float NULL DEFAULT NULL,
  `dtype` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `score` float NULL DEFAULT NULL,
  `user_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKdw6u37h3ob925gvwa4i8l4jt7`(`user_id`) USING BTREE,
  CONSTRAINT `FKdw6u37h3ob925gvwa4i8l4jt7` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '拣配/复核计件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_pick_match_coefficient
-- ----------------------------
INSERT INTO `wms_pick_match_coefficient` VALUES (1, '2020-12-05 11:36:26', '2020-12-05 16:41:21', 0.1, 0.1, 0.2, 0.11, '', NULL, NULL);

-- ----------------------------
-- Table structure for wms_receive_goods
-- ----------------------------
DROP TABLE IF EXISTS `wms_receive_goods`;
CREATE TABLE `wms_receive_goods`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `audit_time` datetime(0) NULL DEFAULT NULL,
  `auditor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flow_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_audited` bit(1) NULL DEFAULT NULL,
  `receive_goods_type` int(0) NULL DEFAULT NULL,
  `customer_id` bigint(0) NULL DEFAULT NULL,
  `is_unload` bit(1) NULL DEFAULT NULL,
  `receive_user_id` bigint(0) NULL DEFAULT NULL,
  `unload_user_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKiy8xcjslvahnq2xej7yi3oyqb`(`customer_id`) USING BTREE,
  INDEX `FKn476bfv4h6gapodbkautdu9q3`(`receive_user_id`) USING BTREE,
  INDEX `FK8tmvcj4fxosqgbvjvc5hawrc2`(`unload_user_id`) USING BTREE,
  CONSTRAINT `FK8tmvcj4fxosqgbvjvc5hawrc2` FOREIGN KEY (`unload_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKiy8xcjslvahnq2xej7yi3oyqb` FOREIGN KEY (`customer_id`) REFERENCES `wms_customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKn476bfv4h6gapodbkautdu9q3` FOREIGN KEY (`receive_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_receive_goods
-- ----------------------------

-- ----------------------------
-- Table structure for wms_receive_goods_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `wms_receive_goods_coefficient`;
CREATE TABLE `wms_receive_goods_coefficient`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `put_in_price` float NULL DEFAULT NULL,
  `unload_price` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收货、卸货系统参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_receive_goods_coefficient
-- ----------------------------

-- ----------------------------
-- Table structure for wms_receive_goods_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_receive_goods_item`;
CREATE TABLE `wms_receive_goods_item`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `quantity` bigint(0) NULL DEFAULT NULL,
  `quantity_cancel_fetch` bigint(0) NULL DEFAULT NULL,
  `quantity_initial` bigint(0) NULL DEFAULT NULL,
  `goods_id` bigint(0) NULL DEFAULT NULL,
  `receive_goods_id` bigint(0) NULL DEFAULT NULL,
  `ware_position_id` bigint(0) NULL DEFAULT NULL,
  `price` decimal(19, 2) NULL DEFAULT NULL,
  `packages` bigint(0) NULL DEFAULT NULL,
  `packages_initial` bigint(0) NULL DEFAULT NULL,
  `receive_user_id` bigint(0) NULL DEFAULT NULL,
  `unload_user_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKixcxn54e16vqxnq743hgeuhxk`(`goods_id`) USING BTREE,
  INDEX `FK7myex2ugivdbt8x1nmruml7rn`(`receive_goods_id`) USING BTREE,
  INDEX `FKk03nijbthoq9fkn8q1kv75q7f`(`ware_position_id`) USING BTREE,
  INDEX `FK9t6awdw7phkbqrdg8ul7lyvlq`(`receive_user_id`) USING BTREE,
  INDEX `FK7v35tl4xn74nigupxi2p1pyqg`(`unload_user_id`) USING BTREE,
  CONSTRAINT `FK7myex2ugivdbt8x1nmruml7rn` FOREIGN KEY (`receive_goods_id`) REFERENCES `wms_receive_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK7v35tl4xn74nigupxi2p1pyqg` FOREIGN KEY (`unload_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK9t6awdw7phkbqrdg8ul7lyvlq` FOREIGN KEY (`receive_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKixcxn54e16vqxnq743hgeuhxk` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKk03nijbthoq9fkn8q1kv75q7f` FOREIGN KEY (`ware_position_id`) REFERENCES `wms_ware_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_receive_goods_item
-- ----------------------------

-- ----------------------------
-- Table structure for wms_receive_goods_piece
-- ----------------------------
DROP TABLE IF EXISTS `wms_receive_goods_piece`;
CREATE TABLE `wms_receive_goods_piece`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `packages` bigint(0) NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `score` float NULL DEFAULT NULL,
  `staff_price` float NULL DEFAULT NULL,
  `type` int(0) NULL DEFAULT NULL,
  `receive_goodses_id` bigint(0) NULL DEFAULT NULL,
  `user_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKh457d9s59t89h90k2b6lq46a5`(`receive_goodses_id`) USING BTREE,
  INDEX `FK91bl6hfoy9qewgvt6a89w8498`(`user_id`) USING BTREE,
  CONSTRAINT `FK91bl6hfoy9qewgvt6a89w8498` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKh457d9s59t89h90k2b6lq46a5` FOREIGN KEY (`receive_goodses_id`) REFERENCES `wms_receive_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库计件信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_receive_goods_piece
-- ----------------------------

-- ----------------------------
-- Table structure for wms_stock
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock`;
CREATE TABLE `wms_stock`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `is_active` bit(1) NULL DEFAULT NULL,
  `quantity` bigint(0) NULL DEFAULT NULL,
  `goods_id` bigint(0) NULL DEFAULT NULL,
  `ware_position_id` bigint(0) NULL DEFAULT NULL,
  `quantity_guarantee` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKm7613w9xxy7inl6dpydf21svp`(`goods_id`) USING BTREE,
  INDEX `FKjabua3ntvqsrv9wwqyfspow6l`(`ware_position_id`) USING BTREE,
  CONSTRAINT `FKjabua3ntvqsrv9wwqyfspow6l` FOREIGN KEY (`ware_position_id`) REFERENCES `wms_ware_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKm7613w9xxy7inl6dpydf21svp` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_stock
-- ----------------------------

-- ----------------------------
-- Table structure for wms_stock_flow
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_flow`;
CREATE TABLE `wms_stock_flow`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `flow_operate_type` int(0) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pack_count` int(0) NULL DEFAULT NULL,
  `price` decimal(19, 2) NULL DEFAULT NULL,
  `quantity` bigint(0) NULL DEFAULT NULL,
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_order_id` bigint(0) NULL DEFAULT NULL,
  `goods_id` bigint(0) NULL DEFAULT NULL,
  `receive_goods_id` bigint(0) NULL DEFAULT NULL,
  `ware_position_in_id` bigint(0) NULL DEFAULT NULL,
  `ware_position_out_id` bigint(0) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_order_page_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKje4cp70xrmm91t5xjttk15xyo`(`customer_order_id`) USING BTREE,
  INDEX `FKllp5wpv70hgvj1rxhq17p8wr`(`goods_id`) USING BTREE,
  INDEX `FK4ad7nvgjesgd8ufatljeufgq0`(`receive_goods_id`) USING BTREE,
  INDEX `FKpb1uji669s559903dnogbempq`(`ware_position_in_id`) USING BTREE,
  INDEX `FKef6lig6xjxaw34fq8dodaa6pt`(`ware_position_out_id`) USING BTREE,
  INDEX `FKfms54m1hmse7n83dj7d53d6x8`(`customer_order_page_id`) USING BTREE,
  CONSTRAINT `FK4ad7nvgjesgd8ufatljeufgq0` FOREIGN KEY (`receive_goods_id`) REFERENCES `wms_receive_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKef6lig6xjxaw34fq8dodaa6pt` FOREIGN KEY (`ware_position_out_id`) REFERENCES `wms_ware_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKfms54m1hmse7n83dj7d53d6x8` FOREIGN KEY (`customer_order_page_id`) REFERENCES `wms_customer_order_page` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKje4cp70xrmm91t5xjttk15xyo` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKllp5wpv70hgvj1rxhq17p8wr` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKpb1uji669s559903dnogbempq` FOREIGN KEY (`ware_position_in_id`) REFERENCES `wms_ware_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_stock_flow
-- ----------------------------

-- ----------------------------
-- Table structure for wms_store
-- ----------------------------
DROP TABLE IF EXISTS `wms_store`;
CREATE TABLE `wms_store`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_store
-- ----------------------------

-- ----------------------------
-- Table structure for wms_ware_position
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_position`;
CREATE TABLE `wms_ware_position`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  `ware_zone_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKt2vusqjgiepb9xbwjvbuspc4w`(`ware_zone_id`) USING BTREE,
  CONSTRAINT `FKt2vusqjgiepb9xbwjvbuspc4w` FOREIGN KEY (`ware_zone_id`) REFERENCES `wms_ware_zone` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_ware_position
-- ----------------------------
INSERT INTO `wms_ware_position` VALUES (431, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (432, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (433, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (434, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (435, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (436, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (437, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (438, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (439, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (440, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (441, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (442, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (443, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (444, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (445, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (446, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (447, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (448, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (449, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (450, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-15-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (451, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (452, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (453, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (454, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (455, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (456, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (457, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (458, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (459, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (460, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (461, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (462, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (463, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (464, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (465, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (466, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (467, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (468, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (469, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (470, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (471, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (472, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (473, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (474, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (475, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (476, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (477, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (478, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (479, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (480, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (481, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-04-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (482, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (483, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (484, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (485, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (486, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (487, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (488, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (489, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (490, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (491, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (492, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (493, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (494, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-04-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (495, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (496, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (497, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (498, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (499, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-04-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (500, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (501, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (502, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (503, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (504, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (505, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (506, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (507, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (508, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-06-03', 1, 3);
INSERT INTO `wms_ware_position` VALUES (509, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-06-04', 1, 3);
INSERT INTO `wms_ware_position` VALUES (510, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-06-05', 1, 3);
INSERT INTO `wms_ware_position` VALUES (511, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-06-06', 1, 3);
INSERT INTO `wms_ware_position` VALUES (512, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (513, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (514, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (515, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (516, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (517, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (518, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (519, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-04-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (520, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (521, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-21-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (522, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-19-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (523, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-21-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (524, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-03', 1, 3);
INSERT INTO `wms_ware_position` VALUES (525, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-05', 1, 3);
INSERT INTO `wms_ware_position` VALUES (526, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-21-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (527, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (528, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-20-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (529, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-04', 1, 3);
INSERT INTO `wms_ware_position` VALUES (530, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-20-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (531, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-20-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (532, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (533, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-21-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (534, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (535, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-11-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (536, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-18-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (537, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-18-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (538, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-18-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (539, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (540, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (541, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (542, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (543, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (544, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (545, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (546, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (547, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-19-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (548, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (549, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-08-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (550, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-08-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (551, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-08-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (552, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-07-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (553, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-07-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (554, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-07-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (555, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-21-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (556, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-11-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (557, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (558, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (559, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (560, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (561, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (562, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (563, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (564, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-08-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (565, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-18-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (566, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-19-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (567, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-19-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (568, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-08-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (569, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-19-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (570, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-09-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (571, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-07-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (572, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-07-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (573, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-07-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (574, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (575, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-09-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (576, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-06', 1, 3);
INSERT INTO `wms_ware_position` VALUES (577, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (578, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (579, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (581, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (582, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (583, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (584, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (585, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (586, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (587, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (588, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (589, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (590, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (591, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (592, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (593, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (594, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (595, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (596, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (597, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-09-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (598, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (599, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (600, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (601, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (602, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-08-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (603, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (604, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (605, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (606, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-05-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (607, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (608, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (609, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (610, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (611, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (612, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (613, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (614, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-06-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (615, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (616, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (617, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (618, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (619, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (620, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (621, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (622, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (623, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (624, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (625, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (626, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (627, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (628, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (629, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (630, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (631, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (632, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (633, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (634, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (635, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (636, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (637, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (638, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (639, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (640, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (641, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (642, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (643, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (644, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (645, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (646, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (647, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (648, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (649, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (650, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (651, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (652, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (653, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (654, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (655, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (656, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (657, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (658, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (659, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (660, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (661, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (662, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (663, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (664, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (665, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (666, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (667, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (668, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (669, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (670, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (671, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (672, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (673, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (674, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (675, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (676, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (677, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (678, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (679, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (680, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (681, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (682, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (683, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (684, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (685, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-01-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (686, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-82', 1, 3);
INSERT INTO `wms_ware_position` VALUES (687, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (688, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (689, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-15-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (690, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (691, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (692, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (693, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (694, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (695, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (696, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (697, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (698, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (699, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (700, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (701, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (702, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (703, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (704, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (705, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (706, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (707, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (708, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (709, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (710, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (711, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (712, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-13-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (713, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (714, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (715, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (716, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (717, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (718, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (719, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (720, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (721, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (722, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (723, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (724, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (725, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (726, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (727, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (728, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (729, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (730, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (731, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (732, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (733, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (734, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (735, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (736, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (737, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (738, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-12-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (739, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (740, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (741, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (742, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (743, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (744, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (745, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-13-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (746, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (747, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (748, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (749, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (750, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (751, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (752, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (753, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-10-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (754, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (755, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (756, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (757, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (758, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (759, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (760, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-11-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (761, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (762, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (763, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (764, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (765, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (766, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (767, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (768, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-08-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (769, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (770, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (771, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (772, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (773, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (774, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (775, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (776, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (777, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (778, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (779, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (780, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (781, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (782, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (783, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (784, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (785, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (786, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (787, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (788, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (789, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (790, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (791, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (792, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (793, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-13-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (794, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (795, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (796, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (797, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (798, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (799, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (800, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (801, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (802, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (803, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (804, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (805, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (806, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (807, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (808, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (809, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (810, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (811, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (812, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (813, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (814, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (815, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (816, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (817, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (818, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (819, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-11-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (820, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (821, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-12-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (822, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-12-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (823, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (824, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-12-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (825, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (826, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (827, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (828, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (829, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (830, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (831, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (832, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (833, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (834, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (835, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (836, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (837, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (838, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (839, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (840, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (841, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (842, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (843, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (844, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (845, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (846, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (847, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (848, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (849, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (850, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (851, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (852, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (853, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (854, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (855, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-11-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (856, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (857, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (858, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (859, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (860, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-16-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (861, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-15-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (862, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (863, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (864, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (865, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (866, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (867, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (868, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (869, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (870, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (871, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (872, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (873, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (874, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (875, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (876, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (877, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (878, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (879, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (880, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (881, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (882, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (883, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (884, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (885, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (886, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (887, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (888, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-10-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (889, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (890, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (891, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (892, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (893, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (894, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (895, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-08-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (896, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-09-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (897, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-07-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (898, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (899, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (900, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (901, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-01', 1, 3);
INSERT INTO `wms_ware_position` VALUES (902, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-02', 1, 3);
INSERT INTO `wms_ware_position` VALUES (903, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-04', 1, 3);
INSERT INTO `wms_ware_position` VALUES (904, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-05', 1, 3);
INSERT INTO `wms_ware_position` VALUES (905, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (906, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-03', 1, 3);
INSERT INTO `wms_ware_position` VALUES (907, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (908, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (909, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (910, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (911, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (912, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (913, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (914, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (915, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (916, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (917, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (918, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (919, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (920, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (921, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (922, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-04-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (923, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (924, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (925, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (926, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (927, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (928, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (929, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-14-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (930, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (931, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (932, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (933, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (934, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (935, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (936, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (937, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (938, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (939, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (940, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (941, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (942, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (943, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (944, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (945, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (946, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (947, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (948, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (949, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (950, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (951, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (952, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (953, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (954, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (955, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (956, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (957, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (958, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (959, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (960, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (961, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (962, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (963, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (964, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (965, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (966, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (967, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (968, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (969, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (970, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (971, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (972, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (973, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (974, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (975, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (976, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (977, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (978, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (979, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-01', 1, 3);
INSERT INTO `wms_ware_position` VALUES (980, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-69', 1, 3);
INSERT INTO `wms_ware_position` VALUES (981, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-02', 1, 3);
INSERT INTO `wms_ware_position` VALUES (982, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-55', 1, 3);
INSERT INTO `wms_ware_position` VALUES (983, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-68', 1, 3);
INSERT INTO `wms_ware_position` VALUES (984, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-62', 1, 3);
INSERT INTO `wms_ware_position` VALUES (985, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (986, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-03', 1, 3);
INSERT INTO `wms_ware_position` VALUES (987, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (988, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-04', 1, 3);
INSERT INTO `wms_ware_position` VALUES (989, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-05', 1, 3);
INSERT INTO `wms_ware_position` VALUES (990, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (991, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-06', 1, 3);
INSERT INTO `wms_ware_position` VALUES (992, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-07', 1, 3);
INSERT INTO `wms_ware_position` VALUES (993, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-08', 1, 3);
INSERT INTO `wms_ware_position` VALUES (994, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-09', 1, 3);
INSERT INTO `wms_ware_position` VALUES (995, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (996, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-10', 1, 3);
INSERT INTO `wms_ware_position` VALUES (997, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-11', 1, 3);
INSERT INTO `wms_ware_position` VALUES (998, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-04-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (999, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-12', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1000, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-04-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1001, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-15', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1002, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1003, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-17', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1004, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-18', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1005, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-20', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1006, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-21', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1007, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-22', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1008, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-65', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1009, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-23', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1010, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1011, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-24', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1012, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1013, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1014, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-25', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1015, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-26', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1016, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-01-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1017, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-27', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1018, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-28', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1019, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-29', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1020, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-03-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1021, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-30', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1022, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-31', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1023, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1024, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-32', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1025, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-33', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1026, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-34', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1027, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-35', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1028, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-37', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1029, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-38', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1030, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-14', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1031, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-39', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1032, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-40', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1033, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-41', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1034, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-42', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1035, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-43', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1036, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-44', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1037, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-45', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1038, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-46', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1039, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-47', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1040, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-48', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1041, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-49', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1042, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-50', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1043, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-51', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1044, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-52', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1045, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-53', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1046, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-54', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1047, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1048, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1049, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1050, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-13-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1051, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1052, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1053, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1054, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1055, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1056, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1057, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-02-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1058, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1059, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1060, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1061, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1062, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1063, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-07-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1064, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1065, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1066, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1067, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1068, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1069, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1070, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-09-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1071, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-20-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1072, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1073, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-09-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1074, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1075, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1076, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1077, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1078, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1079, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1080, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1081, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1082, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1083, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-01-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1084, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1085, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1086, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1087, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1088, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1089, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1090, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-03-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1091, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1092, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1093, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1094, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1095, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1096, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1097, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-01-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1098, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1099, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1100, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1101, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1102, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1103, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1104, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1105, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1106, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1107, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1108, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1109, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1110, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1111, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1112, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1113, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1114, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1115, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1116, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1117, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1118, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1119, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1120, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1121, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1122, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1123, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1124, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1125, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1126, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1127, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1128, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1129, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1130, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1131, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1132, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1133, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1134, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1135, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1136, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1137, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1138, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1139, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1140, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1141, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1142, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-03-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1143, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1144, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1145, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1146, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1147, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1148, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1149, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1150, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1151, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1152, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1153, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1154, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1155, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1156, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1157, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1158, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1159, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1160, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1161, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1162, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1163, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1164, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-14-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1165, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1166, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1167, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1168, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1169, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1170, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1171, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1172, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1173, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1174, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1175, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1176, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-06-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1177, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1178, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1179, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-08-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1180, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1181, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1182, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-07-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1183, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-06-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1184, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1185, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1186, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-04-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1187, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-05-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1188, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-04-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1189, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-13-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1191, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (1192, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'H-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1193, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-20-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1194, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-20-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1195, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-04-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1196, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-01-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1197, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1198, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-05-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1199, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1200, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1201, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1202, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-02-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1203, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-03-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1204, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-17-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1205, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1206, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1207, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-01-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1209, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-07-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1210, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-18-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1211, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-09-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1213, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-11-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1214, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-02', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1215, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1235, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1236, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1237, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-10-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1238, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-02-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1239, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-01', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1240, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1241, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1242, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-14-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1243, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1244, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-10-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1245, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'E-10-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1246, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-04-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1247, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-13', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1248, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1249, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1250, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1251, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1252, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-02-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1253, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-02-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1254, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-17-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1255, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-17-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1256, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-04-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1257, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'D-11-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1258, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-10-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1259, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1260, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-03-07', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1261, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-06', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1262, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-06-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1263, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-19', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1264, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-17-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1266, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-17-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1267, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-17-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1268, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-03-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1269, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-12-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1270, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1271, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1272, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1273, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1274, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1275, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1276, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1277, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1278, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1279, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1280, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1281, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-01-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1282, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1283, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1284, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1285, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1286, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1287, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1288, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1289, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'M-02-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1290, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'B-16-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1291, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-13-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1292, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1293, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-16', 1, 3);
INSERT INTO `wms_ware_position` VALUES (1294, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-13-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1295, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'C-13-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (1296, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1297, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1298, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1299, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1300, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1301, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1302, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1303, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1304, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1305, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1306, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1307, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1308, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1309, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1310, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1311, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1312, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1313, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1314, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1315, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1316, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1317, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1318, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1319, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1320, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1321, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1322, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1323, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1324, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1325, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1326, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1327, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1328, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1329, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1330, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1331, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1332, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1333, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1334, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1335, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1336, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1337, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1338, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1339, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1340, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1341, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1342, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1343, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1344, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1345, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1346, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1347, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1348, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1349, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1350, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1351, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1352, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1353, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1354, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1355, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1356, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1357, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1358, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1359, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1360, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1361, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1362, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1363, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1364, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1365, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1366, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1367, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1368, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1369, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1370, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1371, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1372, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1373, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1374, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1375, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1376, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1377, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1378, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1379, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1380, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1381, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1382, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1383, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1384, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1385, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1386, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1387, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1388, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-01-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1389, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-01-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1390, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1391, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1392, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1393, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1394, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1395, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1396, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1397, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-20', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1398, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1399, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1400, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1401, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1402, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1403, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1404, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1405, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1406, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1407, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1408, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1409, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1410, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1411, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1412, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1413, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1414, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1415, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1416, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1417, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1418, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1419, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1420, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1421, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1422, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1423, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1424, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1425, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1426, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1427, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1428, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1429, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1430, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1431, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1432, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1433, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1434, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1435, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1436, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1437, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1438, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1439, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1440, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1441, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1442, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1443, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1444, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1445, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1446, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-04-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1447, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1448, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1449, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1450, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1451, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1452, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1453, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-06-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1454, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-06-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1455, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1456, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1457, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1458, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1459, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1460, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1461, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1462, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1463, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1464, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1465, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1466, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1467, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1468, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1469, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1470, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1471, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-16-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1472, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-16-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1473, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1474, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1475, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1476, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1477, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1478, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1479, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1480, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1481, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1482, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1483, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1484, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1485, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1486, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1487, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1488, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1489, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y=11-7', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1490, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1491, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1492, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-15-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1493, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-15-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1494, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1495, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1496, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1497, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1498, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1499, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1500, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1501, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1502, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1503, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1504, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1505, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1506, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1507, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1508, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1509, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1510, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1511, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1512, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1513, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1514, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1515, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1516, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1517, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1518, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1519, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1520, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1521, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1522, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1523, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-16-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1524, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-16-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1525, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-16-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1526, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-16-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1527, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-16-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1528, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-16-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1529, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1530, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1531, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1532, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1533, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1534, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1535, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1536, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1537, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1538, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1539, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1540, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-05-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1541, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-06-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1542, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-06-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1543, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-06-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1544, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-07-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1545, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-07-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1546, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-07-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1547, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-07-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1548, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-07-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1549, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-07-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1550, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-08-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1551, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-08-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1552, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1553, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1554, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1555, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1556, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1557, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1558, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1559, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1560, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1561, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1562, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1563, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1564, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1565, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1566, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1567, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1568, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1569, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1570, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1571, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1572, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1573, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1574, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1575, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1576, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1577, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1578, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1579, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1580, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1581, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1582, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1583, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1584, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1585, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1586, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1587, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1588, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1589, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1590, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1591, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1592, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1593, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1594, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1595, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1596, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1597, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1598, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1599, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1600, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1601, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1602, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1603, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1604, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1605, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1606, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1607, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1608, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1609, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1610, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1611, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1612, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1613, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-06-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1614, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1615, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1616, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1617, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1618, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1619, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1620, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1621, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1622, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1623, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1624, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1625, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-02-07', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1626, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1627, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1628, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1629, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1630, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1631, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1632, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1633, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1634, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1635, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1636, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1637, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1638, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1639, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1640, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1641, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1642, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1643, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1644, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1645, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-02-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1646, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-03-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1647, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1648, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1649, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1650, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1651, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1652, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1653, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1654, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-05-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1655, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1656, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1657, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1658, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1659, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1660, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1661, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1662, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1663, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1664, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1665, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1666, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1667, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1668, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1670, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1671, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1672, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1673, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1674, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1675, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1676, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1677, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-13-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1678, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-02-07', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1679, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-02-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1680, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-02-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1681, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-01-06', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1682, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-01-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1683, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-01-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1684, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1685, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1686, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1687, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1688, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1689, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1690, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-15-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1691, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1692, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1693, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1694, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1695, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1696, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1697, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1698, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1699, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1700, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1701, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1702, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1703, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1704, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1705, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1706, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1707, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1708, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1709, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1710, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1711, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1712, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1713, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1714, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1715, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1716, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1717, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1718, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1719, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1720, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x14-6', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1721, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-06-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1722, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-09-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1723, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-09-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1724, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-09-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1725, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-09-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1726, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-10-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1727, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-10-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1728, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-11-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1729, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w11-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1730, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-12-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1731, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-12-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1732, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-13-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1733, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-13-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1734, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-13-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1735, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-13-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1736, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-13-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1737, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1738, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1739, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1740, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1741, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1742, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1743, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1744, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1745, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1746, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1747, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1748, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1749, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-07', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1750, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1751, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-07', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1752, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1753, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1754, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1755, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1756, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1757, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1758, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1759, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1760, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1761, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1762, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1763, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1764, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1765, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1766, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1767, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1768, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1769, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1770, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1771, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1772, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1773, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1774, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1775, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1776, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1777, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1778, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1779, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1780, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1781, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1782, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1783, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1784, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1785, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1786, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1787, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1788, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1789, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-01-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1790, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-01-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1791, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1792, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1793, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1794, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1795, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1796, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1797, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1798, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1799, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1800, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1801, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1802, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1803, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1804, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1805, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1806, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1807, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1808, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1809, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1810, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W16-3', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1811, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-04', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1812, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1813, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1814, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-07', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1815, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1816, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1817, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1818, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1819, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1820, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1821, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1822, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1823, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1824, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1825, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1826, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1827, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1828, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1829, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1830, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1831, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1832, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-05', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1833, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1834, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1835, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1836, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1837, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (1838, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-04', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1839, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-01', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1840, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1841, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1842, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1843, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1844, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1845, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1846, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1847, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-06', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1848, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1849, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1850, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1851, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1852, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1853, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1854, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1855, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1856, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1857, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1858, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1859, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1860, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1861, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1862, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1863, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1864, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1865, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1866, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1867, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-08', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1868, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-05-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1869, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1870, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1871, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1872, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1873, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1874, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1875, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1876, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-11-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1877, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1878, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1879, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1880, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1881, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1882, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1883, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-10-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1884, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1885, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1886, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1887, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1888, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1889, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1890, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-14-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1891, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-15-08', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1892, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-15-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1893, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1894, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1895, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1896, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1897, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1898, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-13-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1899, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-13-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1900, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-13-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1901, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-13-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1902, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-13-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1903, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-13-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1904, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1905, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1906, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1907, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1908, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1909, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1910, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-06-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (1911, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1912, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-16-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1913, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-18-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1914, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-19-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1915, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-15-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1916, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-15-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1917, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-18-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1918, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-19-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1919, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-19-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1920, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-19-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1921, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1922, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1923, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1924, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-01-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1925, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1926, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1927, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1928, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1929, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1930, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1931, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1932, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (1933, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1934, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1935, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1936, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1937, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1938, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1939, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1940, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1941, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1942, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1943, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1944, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1945, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1946, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1947, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1948, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1949, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1950, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1951, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1952, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1953, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1954, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-01-03', 1, 5);
INSERT INTO `wms_ware_position` VALUES (1955, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1956, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1957, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1958, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1959, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1960, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1961, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1962, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1963, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-10', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1964, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-11', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1965, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-12', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1966, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-18', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1967, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-17', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1968, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-16', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1969, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1970, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-14', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1971, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-13', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1972, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-12', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1973, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-06-11', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1974, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-13', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1975, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1976, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1977, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1978, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1979, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1980, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1981, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1982, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1983, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1984, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1985, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1986, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1987, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1988, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1989, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1990, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1991, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1992, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1993, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1994, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1995, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1996, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (1997, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-09', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1998, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (1999, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2000, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2001, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2002, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-06-10', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2003, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-01-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2004, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-01-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2005, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-01-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2006, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-02-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2007, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-05-10', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2008, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-05-11', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2009, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-05-12', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2010, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-05-13', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2011, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-05-14', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2012, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-05-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2013, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-07-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2014, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2015, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-18-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2016, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-18-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2017, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2018, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-07-14', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2019, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-07-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2020, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-07-16', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2021, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-16', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2022, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2023, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2024, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2025, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2026, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2027, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2028, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2029, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2030, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2031, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-10', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2032, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-11', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2033, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-12', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2034, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-09-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2035, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-15-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2036, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-15-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2037, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-15-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2038, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-15-04', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2039, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-16-08', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2040, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-18-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2041, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-18-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2042, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-18--6', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2043, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2044, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2045, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2046, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2047, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2048, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2049, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-05-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2050, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2051, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-07-17', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2052, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-07-18', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2053, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2054, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2055, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2056, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2057, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2058, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2059, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2060, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2061, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2062, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2063, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2064, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2065, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2066, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2067, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-09-07', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2068, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2069, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2070, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-03', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2071, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-04', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2072, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-05', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2073, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-06', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2074, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-10-07', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2075, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2076, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2077, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-13', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2078, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2079, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-01', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2080, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-02', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2081, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-03', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2082, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2083, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2084, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-14', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2085, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-20-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2086, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2087, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-02-20', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2088, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-20', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2089, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2090, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2091, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2092, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2093, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2094, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-01', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2095, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2096, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-03-15', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2097, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-07', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2098, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2099, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-02', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2100, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-06-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2101, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2102, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2103, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2104, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2105, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-06', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2106, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2107, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2108, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02-03', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2109, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-17', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2110, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-18', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2111, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-16', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2112, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2113, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-14', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2114, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2115, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-04-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2116, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-08', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2117, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-18-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2118, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-15', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2119, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-12-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2120, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2121, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2122, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-15-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2123, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-16-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2124, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-14-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2125, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-04', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2126, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2127, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-10-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2128, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-11-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2129, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-12-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2130, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-13-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2131, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2132, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V7-18', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2133, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-10-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2134, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-10-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2135, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-10-02', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2136, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-03', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2137, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-81', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2138, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-80', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2139, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-78', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2140, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-79', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2141, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-05', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2142, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-05', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2143, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2144, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2145, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2146, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2147, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-03-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2148, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-02-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2149, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2150, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-04-10', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2151, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-08', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2152, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'z-04-01', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2153, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-02', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2154, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-07-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2155, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-15-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2156, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-11-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2157, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F*-01-04', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2158, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-11-04', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2159, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-02', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2160, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2161, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2162, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2163, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2164, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2165, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2166, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2167, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2168, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2169, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2170, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2171, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2172, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2173, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2174, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2175, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-16-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2176, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2177, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2178, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2179, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2180, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2181, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2182, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-07', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2183, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-08', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2184, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-17-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2185, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2186, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2187, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-02', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2188, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01-36', 1, 3);
INSERT INTO `wms_ware_position` VALUES (2189, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13--11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2190, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-06', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2191, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2192, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-01', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2193, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-02', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2194, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-04', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2195, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-05', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2196, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2197, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-09-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2198, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-07-19', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2199, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-08', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2200, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2201, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-01-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2202, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2203, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2204, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2205, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2206, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2207, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2208, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2209, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2210, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-04-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2211, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2212, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2213, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2215, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T--02-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2217, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2218, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2219, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2220, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2221, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-05-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2222, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2224, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-05', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2225, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-03', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2226, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-3-19', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2227, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W15-8', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2228, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W14-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2229, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W14-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2230, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X2-6', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2231, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X2-1', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2232, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X2-2', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2233, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W15-12', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2234, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W15-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2237, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V6-6', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2238, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V7-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2241, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V8-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2242, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X3-1', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2243, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W2-15', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2244, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W2-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2245, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W2-18', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2246, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W5-6', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2247, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W4-6', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2248, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W4-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2249, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V3-5', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2250, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W3-14', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2251, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2252, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-14-09', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2275, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-5-7', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2277, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-11', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2280, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-14-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2281, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-03', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2282, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-05', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2283, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-06', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2284, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-07-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2285, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W10-16', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2286, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2287, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-02-09-W-02-10', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2288, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-13', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2289, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-052-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2290, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W15-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2291, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2292, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2293, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2294, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2295, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2296, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2297, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2298, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2299, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2300, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2301, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-19-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2302, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-19-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2303, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2304, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2305, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2306, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2307, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2308, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2309, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2310, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2311, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2312, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2313, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2314, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2315, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2316, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2317, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2318, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2319, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2320, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2321, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2322, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-10-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2323, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2324, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2325, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2326, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2327, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2328, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2329, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2330, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-11-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2331, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-16-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2332, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-16-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2333, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2334, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2335, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2336, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-13-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2337, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-14-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2338, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2340, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2341, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2342, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2343, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2344, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2345, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2346, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2347, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2348, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2349, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2350, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2351, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2352, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2353, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2354, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2355, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2356, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2357, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-15-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2358, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-16-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2359, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-16-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2360, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-17-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2361, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-17-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2362, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-17-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2363, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-17-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2364, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-17-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2365, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-18-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2366, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-18-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2367, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-18-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2368, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-18-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2369, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2370, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2371, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2372, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2373, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2374, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2375, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-19-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2376, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-19-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2377, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-19-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2380, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2381, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-11-1', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2382, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X -10-02', 1, 5);
INSERT INTO `wms_ware_position` VALUES (2383, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T19-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2384, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W11-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2385, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2386, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15--08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2387, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02--05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2389, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2390, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-05-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2391, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2392, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2393, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2394, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2395, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2396, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2397, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2398, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2399, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'u-06-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2401, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2402, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--04-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2403, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-00-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2404, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02--03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2405, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2406, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2407, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-07-04', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2408, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-09-04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2409, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2412, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2413, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-1-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2414, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2415, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U01-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2416, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2417, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-15-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2418, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-14-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2421, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2422, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A--07-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2423, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-03', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2424, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-04', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2425, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-05', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2426, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2427, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-02', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2428, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-03', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2429, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-04', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2430, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-05', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2431, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-03-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2432, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-03-02', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2433, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-03-03', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2434, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-03-04', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2435, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-03-05', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2436, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2437, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-02', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2438, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-04', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2439, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2440, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-19-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2441, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2442, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2443, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2444, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W14-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2445, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-05-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2446, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-05-02', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2447, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-05-03', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2448, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-05-04', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2449, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-05-05', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2450, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2451, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-1-4', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2452, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-03-06', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2453, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2454, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-05-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2455, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-9-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2456, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2457, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-5', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2458, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2459, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2460, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-9', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2461, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-8', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2462, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-15-7', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2463, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-3-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2464, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-8-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2465, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-8-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2466, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-8-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2467, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2468, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-02', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2469, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W15-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2470, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-16-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2472, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-010', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2473, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-04-4', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2474, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-04--07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2475, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-X-X', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2477, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2478, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'y-19-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2479, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-0915', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2480, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2481, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2482, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2483, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--02-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2484, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2485, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-07', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2486, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-06', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2487, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-14-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2488, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-13-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2490, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-9-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2491, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X--14-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2493, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2494, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2496, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-01-06', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2497, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-15-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2498, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-07-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2499, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2500, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--05-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2501, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2502, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-01-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2503, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-15-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2504, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z05-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2505, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z05-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2506, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-12-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2507, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'x-01-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2508, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'w-001-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2509, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2510, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-02-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2511, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-02-26', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2512, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-15-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2513, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2514, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-10-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2515, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-14-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2516, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2517, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-03-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2518, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-05', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2519, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-04-07', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2520, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-074', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2521, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y--06-03', 1, 4);
INSERT INTO `wms_ware_position` VALUES (2522, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2523, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y10-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2524, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2525, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-14-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2526, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2527, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-19', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2528, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-06', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2529, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-07', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2530, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-08', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2531, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-09', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2532, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-11', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2533, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-17', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2534, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-19', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2535, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-17-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2536, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-21-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2537, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-22-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2538, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-23-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2539, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-24-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2540, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-25-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2541, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-26-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2542, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-27-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2543, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-28-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2544, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-29-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2545, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-30-01', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2546, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'v-02-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2547, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-08-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2548, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09-15', 1, 8);
INSERT INTO `wms_ware_position` VALUES (2549, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W14-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2550, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W16-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2551, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-3-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2552, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W11-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2553, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-12-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2554, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-19-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2555, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-14-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2556, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-13-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2557, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-18-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2558, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-17-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2559, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y06-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2560, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-20-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2561, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--15-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2562, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2563, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-2', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2564, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-3', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2565, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2566, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2567, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-7', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2568, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-8', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2569, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-9', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2570, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2571, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2572, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2573, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2574, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2575, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2576, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-17F', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2577, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2578, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2579, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2580, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-21', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2581, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-22', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2582, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-23', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2583, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-24', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2584, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-25', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2585, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-26', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2586, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-27', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2587, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-28', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2588, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-29', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2589, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2590, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-09.02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2591, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-31', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2592, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-32', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2593, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-33', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2594, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-34', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2595, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-35', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2596, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-36', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2597, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-37', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2598, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-38', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2599, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-39', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2600, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-40', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2601, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-41', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2602, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-42', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2603, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-43', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2604, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-45', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2605, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F1-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2606, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F2-2', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2607, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F2-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2608, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F2-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2609, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F2-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2610, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F2-7', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2611, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F2-5', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2612, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-13-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2613, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2614, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-2', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2615, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-3', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2616, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2617, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-5', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2618, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2619, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-8', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2620, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2621, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2622, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2623, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2624, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2625, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2626, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2627, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2628, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2629, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-17', 1, 6);
INSERT INTO `wms_ware_position` VALUES (2630, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2631, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2632, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2633, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2634, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2635, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-9', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2636, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-7', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2637, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2638, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2639, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-3', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2640, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-2', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2641, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-2-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2642, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2643, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2644, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-2', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2645, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-3', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2646, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2647, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-5', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2648, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-6', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2649, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-7', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2650, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-8', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2651, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2652, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2653, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2654, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-10-9', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2655, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2656, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-2', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2657, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-3', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2658, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2659, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-5', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2660, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-05-24', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2661, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-15-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2662, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U06-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2663, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2664, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-09-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2665, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2666, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-10', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2667, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-12-11', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2668, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V--09-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2669, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-01', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2670, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-05', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2671, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-04', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2672, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-03', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2673, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-06', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2674, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2675, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-08', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2676, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-07-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2677, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2678, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--04-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2679, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-07', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2680, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2681, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-10', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2682, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-11', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2683, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-02', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2684, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-03', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2685, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-04', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2686, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-05', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2687, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-06', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2688, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-07', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2689, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-08', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2690, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-09', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2691, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-10', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2692, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-11', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2693, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-12', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2694, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-13', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2695, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-14', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2696, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-15', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2697, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-16', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2698, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y--09-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2699, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-1-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2700, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-12', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2701, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-06-12', 1, 11);
INSERT INTO `wms_ware_position` VALUES (2702, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-03-02-', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2703, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-5-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2704, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-30-30', 1, 7);
INSERT INTO `wms_ware_position` VALUES (2705, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2706, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-08-01', 1, 10);
INSERT INTO `wms_ware_position` VALUES (2707, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-04-45', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2708, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-01--41', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2709, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-02-09', 1, 2);
INSERT INTO `wms_ware_position` VALUES (2710, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-02-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2711, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X12-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2712, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T01-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2713, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T11-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2714, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--01-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2718, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, '-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2719, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-30-030', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2720, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, '-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2722, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--03-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2723, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A-30-30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2724, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'A30-30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2725, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X--02-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2726, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-05-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2728, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--06-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2729, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V--09-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2730, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-20-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2731, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--06-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2732, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-26', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2733, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, '-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2734, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F--01-36', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2735, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2736, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-06-03.', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2737, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-19-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2738, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-20-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2739, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-21-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2740, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-22-01', 1, 9);
INSERT INTO `wms_ware_position` VALUES (2741, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y--12-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2742, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-10-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2743, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2744, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-1-41', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2745, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-23-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2746, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-12-8', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2747, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'lL-01-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2748, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W10-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2749, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2750, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'L-01-16V', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2751, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2752, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-23-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2753, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U--01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2754, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-*04-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2755, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-17-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2756, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y16-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2757, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2758, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-4-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2759, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--04-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2760, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-01-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2761, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-07-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2762, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W*04-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2763, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y--20-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2764, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2765, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2766, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-5-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2767, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W*02-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2768, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-05-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2769, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2770, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-08-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2771, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-11-', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2772, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-02-11', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2773, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W10-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2774, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-12-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2775, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2776, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2777, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-07-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2778, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-19-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2779, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z--08-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2780, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-4-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2781, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-5-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2782, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y04-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2783, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-04-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2784, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U09-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2785, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-02-30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2786, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X12-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2787, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-5-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2788, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-15-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2789, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-30-30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2790, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'S-02-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2791, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-10-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2792, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-30-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2793, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'YY-17-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2794, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-20-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2795, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-30--30', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2796, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-09-3', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2797, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-08-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2798, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'F-02-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2799, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-23-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2800, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X+08-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2801, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-12-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2802, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T-1-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2803, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-6-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2804, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W+04-17', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2805, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-14-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2806, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-11-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2807, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2808, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y14-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2809, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'T--05-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2810, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-4-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2811, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W12-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2812, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-08-16', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2813, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-17-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2814, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-7-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2815, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-18-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2816, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z+12-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2817, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y--15-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2818, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-18-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2819, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-20-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2820, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-20-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2821, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-21-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2822, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-21-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2823, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-21-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2824, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-21-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2825, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-22-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2826, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-22-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2827, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-22-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2828, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-22-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2829, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-01-06', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2830, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-01-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2831, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2832, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-17-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2833, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-17-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2834, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-17-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2835, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-13-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2836, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2837, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-12-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2838, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-21-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2839, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-22-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2840, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-07-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2841, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-18-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2842, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-20-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2843, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-01-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2844, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-20-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2845, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-03-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2846, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2847, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-18-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2848, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2849, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-03-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2850, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-06-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2852, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-10', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2853, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-04', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2854, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2855, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2856, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2857, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-20', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2858, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-15', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2859, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2860, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2861, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2862, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2863, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-01-07', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2864, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-1-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2865, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1608', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2866, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-0316', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2867, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1615', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2868, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-11-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2869, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Z-04-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2870, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-17-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2871, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-19-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2872, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-08-01', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2873, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-08-02', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2874, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-08-03', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2875, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-08-06', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2876, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-08-07', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2877, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-01', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2878, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-02', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2879, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-03', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2880, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-04', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2881, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU--06-04', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2882, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-05', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2883, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-06', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2884, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-06-07', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2885, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-07', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2886, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-06', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2887, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-05', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2888, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-04', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2889, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-03', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2890, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-02', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2891, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-01', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2892, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-02', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2893, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-03', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2894, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-04', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2895, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-05', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2896, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-06', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2897, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-04-07', 1, 12);
INSERT INTO `wms_ware_position` VALUES (2898, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W--01-09', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2899, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W13-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2900, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'TT-01-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2901, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X-08-08', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2902, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-08-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2903, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-03-4', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2904, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-18-18', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2905, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'UU-05-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2906, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-13.-01', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2907, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-7-14', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2908, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-21', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2909, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-0-12', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2910, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'U-01-1', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2911, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'Y-21-13', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2912, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-19-05', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2913, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-08-21', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2914, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-16-03', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2915, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-16-31', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2916, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-10-19', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2917, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-12-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2918, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'V-23-02', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2919, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'W-1416', 1, 1);
INSERT INTO `wms_ware_position` VALUES (2920, '2021-07-17 17:40:14', '2021-07-17 17:40:14', NULL, 'X05-07', 1, 1);

-- ----------------------------
-- Table structure for wms_ware_zone
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_zone`;
CREATE TABLE `wms_ware_zone`  (
  `id` bigint(0) NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_order` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_ware_zone
-- ----------------------------
INSERT INTO `wms_ware_zone` VALUES (1, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '其它', 1);
INSERT INTO `wms_ware_zone` VALUES (2, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿赠品物料仓库-T区', 1);
INSERT INTO `wms_ware_zone` VALUES (3, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-F区', 1);
INSERT INTO `wms_ware_zone` VALUES (4, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-Y区', 1);
INSERT INTO `wms_ware_zone` VALUES (5, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-X区', 1);
INSERT INTO `wms_ware_zone` VALUES (6, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-W区', 1);
INSERT INTO `wms_ware_zone` VALUES (7, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-Z区', 1);
INSERT INTO `wms_ware_zone` VALUES (8, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-V区', 1);
INSERT INTO `wms_ware_zone` VALUES (9, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿主仓库-U区', 1);
INSERT INTO `wms_ware_zone` VALUES (10, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿包场破损仓库-S区', 1);
INSERT INTO `wms_ware_zone` VALUES (11, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '展鹿临期品仓库-L区', 1);
INSERT INTO `wms_ware_zone` VALUES (12, '2021-07-17 17:23:15', '2021-07-17 17:23:15', NULL, '源萃合作库-UU区', 1);

SET FOREIGN_KEY_CHECKS = 1;
