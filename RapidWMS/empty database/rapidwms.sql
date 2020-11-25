/*
 Navicat Premium Data Transfer

 Source Server         : localhost MySQL
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : rapidwms

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 24/11/2020 18:27:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for avatar
-- ----------------------------
DROP TABLE IF EXISTS `avatar`;
CREATE TABLE `avatar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime DEFAULT NULL COMMENT '上传日期',
  `delete_url` varchar(255) DEFAULT NULL COMMENT '删除的URL',
  `filename` varchar(255) DEFAULT NULL COMMENT '图片名称',
  `height` varchar(255) DEFAULT NULL COMMENT '图片高度',
  `size` varchar(255) DEFAULT NULL COMMENT '图片大小',
  `url` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `width` varchar(255) DEFAULT NULL COMMENT '图片宽度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of avatar
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for email_config
-- ----------------------------
DROP TABLE IF EXISTS `email_config`;
CREATE TABLE `email_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from_user` varchar(255) DEFAULT NULL COMMENT '收件人',
  `host` varchar(255) DEFAULT NULL COMMENT '邮件服务器SMTP地址',
  `pass` varchar(255) DEFAULT NULL COMMENT '密码',
  `port` varchar(255) DEFAULT NULL COMMENT '端口',
  `user` varchar(255) DEFAULT NULL COMMENT '发件者用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of email_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exception_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `log_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `request_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
BEGIN;
INSERT INTO `log` VALUES (1, '2020-08-02 00:50:00', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 162, '王宏');
INSERT INTO `log` VALUES (2, '2020-08-02 00:50:02', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 119, '王宏');
INSERT INTO `log` VALUES (3, '2020-08-02 00:50:06', '删除角色', 'org.mstudio.exception.BadRequestException: could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement\n	at org.mstudio.aspect.LogAspect.logAround(LogAspect.java:51)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor.invoke(MethodSecurityInterceptor.java:69)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:93)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at org.mstudio.modules.system.rest.RoleController$$EnhancerBySpringCGLIB$$d07a3367.delete(<generated>)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:892)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doDelete(FrameworkServlet.java:930)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:666)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.mstudio.modules.security.security.JwtAuthorizationTokenFilter.doFilterInternal(JwtAuthorizationTokenFilter.java:70)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200)\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:834)\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1415)\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\n	at java.lang.Thread.run(Thread.java:748)\n', 'ERROR', 'org.mstudio.modules.system.rest.RoleController.delete()', '{ id: 12 }', '172.18.0.5', 42, '王宏');
INSERT INTO `log` VALUES (4, '2020-08-02 00:50:09', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 7, '王宏');
INSERT INTO `log` VALUES (5, '2020-08-02 00:50:13', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 33 }', '172.18.0.5', 23, '王宏');
INSERT INTO `log` VALUES (6, '2020-08-02 00:50:13', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 92, '王宏');
INSERT INTO `log` VALUES (7, '2020-08-02 00:50:16', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 32 }', '172.18.0.5', 8, '王宏');
INSERT INTO `log` VALUES (8, '2020-08-02 00:50:17', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 48, '王宏');
INSERT INTO `log` VALUES (9, '2020-08-02 00:50:18', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 31 }', '172.18.0.5', 9, '王宏');
INSERT INTO `log` VALUES (10, '2020-08-02 00:50:18', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 48, '王宏');
INSERT INTO `log` VALUES (11, '2020-08-02 00:50:20', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 30 }', '172.18.0.5', 9, '王宏');
INSERT INTO `log` VALUES (12, '2020-08-02 00:50:20', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 47, '王宏');
INSERT INTO `log` VALUES (13, '2020-08-02 00:50:22', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 29 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (14, '2020-08-02 00:50:23', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 42, '王宏');
INSERT INTO `log` VALUES (15, '2020-08-02 00:50:24', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 28 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (16, '2020-08-02 00:50:24', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 37, '王宏');
INSERT INTO `log` VALUES (17, '2020-08-02 00:50:26', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 27 }', '172.18.0.5', 7, '王宏');
INSERT INTO `log` VALUES (18, '2020-08-02 00:50:27', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 37, '王宏');
INSERT INTO `log` VALUES (19, '2020-08-02 00:50:29', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 26 }', '172.18.0.5', 4, '王宏');
INSERT INTO `log` VALUES (20, '2020-08-02 00:50:29', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 35, '王宏');
INSERT INTO `log` VALUES (21, '2020-08-02 00:50:31', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 25 }', '172.18.0.5', 8, '王宏');
INSERT INTO `log` VALUES (22, '2020-08-02 00:50:31', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 43, '王宏');
INSERT INTO `log` VALUES (23, '2020-08-02 00:50:33', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 24 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (24, '2020-08-02 00:50:33', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 59, '王宏');
INSERT INTO `log` VALUES (25, '2020-08-02 00:50:34', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 23 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (26, '2020-08-02 00:50:35', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 33, '王宏');
INSERT INTO `log` VALUES (27, '2020-08-02 00:50:36', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 22 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (28, '2020-08-02 00:50:36', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 32, '王宏');
INSERT INTO `log` VALUES (29, '2020-08-02 00:50:38', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 21 }', '172.18.0.5', 4, '王宏');
INSERT INTO `log` VALUES (30, '2020-08-02 00:50:38', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 30, '王宏');
INSERT INTO `log` VALUES (31, '2020-08-02 00:50:40', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 20 }', '172.18.0.5', 6, '王宏');
INSERT INTO `log` VALUES (32, '2020-08-02 00:50:40', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 30, '王宏');
INSERT INTO `log` VALUES (33, '2020-08-02 00:50:41', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 19 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (34, '2020-08-02 00:50:42', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 33, '王宏');
INSERT INTO `log` VALUES (35, '2020-08-02 00:50:48', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 16 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (36, '2020-08-02 00:50:48', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 42, '王宏');
INSERT INTO `log` VALUES (37, '2020-08-02 00:50:51', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 15 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (38, '2020-08-02 00:50:51', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 33, '王宏');
INSERT INTO `log` VALUES (39, '2020-08-02 00:50:53', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 17 }', '172.18.0.5', 6, '王宏');
INSERT INTO `log` VALUES (40, '2020-08-02 00:50:53', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 22, '王宏');
INSERT INTO `log` VALUES (41, '2020-08-02 00:50:55', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 14 }', '172.18.0.5', 14, '王宏');
INSERT INTO `log` VALUES (42, '2020-08-02 00:50:55', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 19, '王宏');
INSERT INTO `log` VALUES (43, '2020-08-02 00:50:57', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 13 }', '172.18.0.5', 4, '王宏');
INSERT INTO `log` VALUES (44, '2020-08-02 00:50:58', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 17, '王宏');
INSERT INTO `log` VALUES (45, '2020-08-02 00:51:00', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 12 }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (46, '2020-08-02 00:51:00', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 15, '王宏');
INSERT INTO `log` VALUES (47, '2020-08-02 00:51:20', '修改用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.update()', '{ resources: User{id=5, username=\'总经理\', avatar=\'null\', email=\'manager@kerryeas.com\', enabled=true, password=\'null\', createTime=null, lastPasswordResetTime=null} }', '172.18.0.5', 332, '王宏');
INSERT INTO `log` VALUES (48, '2020-08-02 00:51:20', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 9, '王宏');
INSERT INTO `log` VALUES (49, '2020-08-02 00:51:22', '重置用户密码', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.resetPassword()', '{ id: 5 }', '172.18.0.5', 25, '王宏');
INSERT INTO `log` VALUES (50, '2020-08-02 00:51:29', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 5, '王宏');
INSERT INTO `log` VALUES (51, '2020-08-02 00:51:32', '删除角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.delete()', '{ id: 12 }', '172.18.0.5', 7, '王宏');
INSERT INTO `log` VALUES (52, '2020-08-02 00:51:32', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '172.18.0.5', 24, '王宏');
INSERT INTO `log` VALUES (53, '2020-08-02 00:51:37', '查询权限', NULL, 'INFO', 'org.mstudio.modules.system.rest.PermissionController.getPermissions()', '{ name: null }', '172.18.0.5', 10, '王宏');
INSERT INTO `log` VALUES (54, '2020-08-02 00:51:38', '查询菜单', NULL, 'INFO', 'org.mstudio.modules.system.rest.MenuController.getMenus()', '{ name: null }', '172.18.0.5', 9, '王宏');
INSERT INTO `log` VALUES (55, '2020-08-02 00:51:39', '查询定时任务', NULL, 'INFO', 'org.mstudio.modules.quartz.rest.QuartzJobController.getJobs()', '{ resources: QuartzJob(id=null, jobName=null, beanName=null, methodName=null, params=null, cronExpression=null, isPause=false, remark=null, updateTime=null) pageable: Page request [number: 0, size 20, sort: id: DESC] }', '172.18.0.5', 13, '王宏');
INSERT INTO `log` VALUES (56, '2020-11-24 18:24:50', '用户登录', 'org.mstudio.exception.BadRequestException: User 不存在 {name=Macrow}\n	at org.mstudio.aspect.LogAspect.logAround(LogAspect.java:51)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:93)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at org.mstudio.modules.security.rest.AuthenticationController$$EnhancerBySpringCGLIB$$86d7a2c0.login(<generated>)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:892)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:908)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.mstudio.modules.security.security.JwtAuthorizationTokenFilter.doFilterInternal(JwtAuthorizationTokenFilter.java:70)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200)\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:834)\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1415)\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)\n	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\n	at java.base/java.lang.Thread.run(Thread.java:834)\n', 'ERROR', 'org.mstudio.modules.security.rest.AuthenticationController.login()', '{ authorizationUser: {username=Macrow, password= ******} }', '127.0.0.1', 25, 'Macrow');
INSERT INTO `log` VALUES (57, '2020-11-24 18:24:56', '用户登录', 'org.mstudio.exception.BadRequestException: 密码错误\n	at org.mstudio.aspect.LogAspect.logAround(LogAspect.java:51)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:93)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at org.mstudio.modules.security.rest.AuthenticationController$$EnhancerBySpringCGLIB$$86d7a2c0.login(<generated>)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:892)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:908)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.mstudio.modules.security.security.JwtAuthorizationTokenFilter.doFilterInternal(JwtAuthorizationTokenFilter.java:70)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200)\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:834)\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1415)\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)\n	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\n	at java.base/java.lang.Thread.run(Thread.java:834)\n', 'ERROR', 'org.mstudio.modules.security.rest.AuthenticationController.login()', '{ authorizationUser: {username=王宏, password= ******} }', '127.0.0.1', 33, '王宏');
INSERT INTO `log` VALUES (58, '2020-11-24 18:25:01', '用户登录', NULL, 'INFO', 'org.mstudio.modules.security.rest.AuthenticationController.login()', '{ authorizationUser: {username=王宏, password= ******} }', '127.0.0.1', 34, '王宏');
INSERT INTO `log` VALUES (59, '2020-11-24 18:25:40', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 151, '王宏');
INSERT INTO `log` VALUES (60, '2020-11-24 18:25:44', '删除用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.delete()', '{ id: 5 }', '127.0.0.1', 51, '王宏');
INSERT INTO `log` VALUES (61, '2020-11-24 18:25:45', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 55, '王宏');
INSERT INTO `log` VALUES (62, '2020-11-24 18:25:48', '重置用户密码', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.resetPassword()', '{ id: 4 }', '127.0.0.1', 39, '王宏');
INSERT INTO `log` VALUES (63, '2020-11-24 18:26:08', '用户登录', 'org.mstudio.exception.BadRequestException: User 不存在 {name=admin}\n	at org.mstudio.aspect.LogAspect.logAround(LogAspect.java:51)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:93)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at org.mstudio.modules.security.rest.AuthenticationController$$EnhancerBySpringCGLIB$$86d7a2c0.login(<generated>)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:892)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:908)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.mstudio.modules.security.security.JwtAuthorizationTokenFilter.doFilterInternal(JwtAuthorizationTokenFilter.java:70)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200)\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:834)\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1415)\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)\n	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\n	at java.base/java.lang.Thread.run(Thread.java:834)\n', 'ERROR', 'org.mstudio.modules.security.rest.AuthenticationController.login()', '{ authorizationUser: {username=admin, password= ******} }', '127.0.0.1', 13, 'admin');
INSERT INTO `log` VALUES (64, '2020-11-24 18:26:29', '用户登录', NULL, 'INFO', 'org.mstudio.modules.security.rest.AuthenticationController.login()', '{ authorizationUser: {username=admin, password= ******} }', '127.0.0.1', 354, 'admin');
INSERT INTO `log` VALUES (65, '2020-11-24 18:26:42', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 47, 'admin');
INSERT INTO `log` VALUES (66, '2020-11-24 18:26:43', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 129, 'admin');
INSERT INTO `log` VALUES (67, '2020-11-24 18:26:45', '查询权限', NULL, 'INFO', 'org.mstudio.modules.system.rest.PermissionController.getPermissions()', '{ name: null }', '127.0.0.1', 38, 'admin');
INSERT INTO `log` VALUES (68, '2020-11-24 18:26:48', '查询角色', NULL, 'INFO', 'org.mstudio.modules.system.rest.RoleController.getRoles()', '{ name: null pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 8, 'admin');
INSERT INTO `log` VALUES (69, '2020-11-24 18:27:05', '查询用户', NULL, 'INFO', 'org.mstudio.modules.system.rest.UserController.getUsers()', '{ userDTO: UserDTO(id=null, username=null, avatar=null, email=null, enabled=null, password=null, createTime=null, lastPasswordResetTime=null, roles=null, customers=null) pageable: Page request [number: 0, size 1000, sort: id: DESC] }', '127.0.0.1', 4, 'admin');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `i_frame` bit(1) DEFAULT NULL COMMENT '是否外链',
  `name` varchar(255) DEFAULT NULL COMMENT '菜单名称',
  `component` varchar(255) DEFAULT NULL COMMENT '组件',
  `pid` bigint(20) NOT NULL COMMENT '上级菜单ID',
  `sort` bigint(20) NOT NULL COMMENT '排序',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `path` varchar(255) DEFAULT NULL COMMENT '链接地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, '2018-12-18 15:11:29', b'0', '系统管理', NULL, 0, 9, 'setting', 'system');
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
INSERT INTO `menu` VALUES (34, '2019-04-04 16:41:54', b'0', '基础设置', NULL, 0, 5, 'shop', 'Infrastructure');
INSERT INTO `menu` VALUES (35, '2019-04-04 16:46:58', b'0', '客户管理', '/Infrastructure/customer', 34, 1, 'solution', '/Infrastructure/customer');
INSERT INTO `menu` VALUES (36, '2019-04-04 16:47:42', b'0', '客户商品管理', '/infrastructure/goods', 34, 6, 'gift', '/infrastructure/goods');
INSERT INTO `menu` VALUES (37, '2019-04-08 02:12:35', b'0', '商品种类管理', '/infrastructure/goodsType', 34, 7, 'branches', '/infrastructure/goodsType');
INSERT INTO `menu` VALUES (39, '2019-04-09 00:04:42', b'0', '库区管理', '/infrastructure/wareZone', 34, 2, 'gold', '/infrastructure/wareZone');
INSERT INTO `menu` VALUES (40, '2019-04-09 00:06:00', b'0', '库位管理', '/infrastructure/warePosition', 34, 3, 'reconciliation', '/infrastructure/warePosition');
INSERT INTO `menu` VALUES (41, '2019-04-09 09:40:23', b'0', '仓储管理', NULL, 0, 3, 'inbox', 'warehouse');
INSERT INTO `menu` VALUES (42, '2019-04-09 09:41:32', b'0', '实时库存管理', '/warehouse/stock', 41, 1, 'exception', '/warehouse/stock');
INSERT INTO `menu` VALUES (43, '2019-04-09 14:58:56', b'0', '销售管理', '', 0, 2, 'dollar', 'order');
INSERT INTO `menu` VALUES (44, '2019-04-09 15:00:16', b'0', '订单管理', '/order/order', 43, 1, 'schedule', '/order/order');
INSERT INTO `menu` VALUES (45, '2019-04-09 15:04:21', b'0', '入库管理', '/warehouse/receiveGoods', 41, 2, 'appstore', '/warehouse/receiveGoods');
INSERT INTO `menu` VALUES (47, '2019-04-09 15:06:48', b'0', '进出库流水查询', '/warehouse/stockFlow', 41, 4, 'read', '/warehouse/stockFlow');
INSERT INTO `menu` VALUES (48, '2019-04-09 15:11:17', b'0', '物流管理', NULL, 0, 4, 'select', 'transit');
INSERT INTO `menu` VALUES (49, '2019-04-09 15:13:48', b'0', '打包管理', '/transit/pack', 48, 2, 'medicine-box', '/transit/pack');
INSERT INTO `menu` VALUES (50, '2019-04-09 15:19:19', b'0', '新增打包', '/transit/addPack', 48, 3, 'build', '/transit/addPack');
INSERT INTO `menu` VALUES (51, '2019-04-12 16:47:31', b'0', '新增入库', '/warehouse/addReceiveGoods', 41, 3, 'download', '/warehouse/addReceiveGoods');
INSERT INTO `menu` VALUES (52, '2019-04-29 23:44:12', b'0', '新增订单', '/order/addOrder', 43, 2, 'exception', '/order/addOrder');
INSERT INTO `menu` VALUES (53, '2019-04-29 23:45:43', b'0', '导入订单', '/order/importOrder', 43, 3, 'cloud-upload', '/order/importOrder');
INSERT INTO `menu` VALUES (54, '2019-04-29 23:47:41', b'0', '地址管理', '/infrastructure/address', 34, 4, 'car', '/infrastructure/address');
INSERT INTO `menu` VALUES (55, '2019-05-07 15:38:57', b'0', '订单出库流水查询', '/order/stockFlow', 43, 4, 'cluster', '/order/stockFlow');
INSERT INTO `menu` VALUES (56, '2019-05-15 15:06:03', b'0', '拣货确认', '/transit/confirmOrder', 48, 1, 'schedule', '/transit/confirmOrder');
INSERT INTO `menu` VALUES (57, '2019-05-16 11:44:01', b'0', '数据表盘', NULL, 0, 1, 'dashboard', 'dashboard');
INSERT INTO `menu` VALUES (58, '2019-05-16 11:44:41', b'0', '今日看板', '/dashboard/analysis', 57, 1, 'alert', '/dashboard/analysis');
INSERT INTO `menu` VALUES (59, '2019-07-08 10:36:01', b'0', '已完成订单报表', '/order/completeOrder', 43, 5, 'check-circle', '/order/completeOrder');
INSERT INTO `menu` VALUES (60, '2019-07-09 10:45:11', b'0', '地址类别管理', '/infrastructure/addressType', 34, 5, 'layout', '/infrastructure/addressType');
INSERT INTO `menu` VALUES (61, '2019-09-28 19:01:10', b'0', '订单客户名称管理', '/infrastructure/store', 34, 8, 'usergroup-add', '/infrastructure/store');
COMMIT;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `alias` varchar(255) DEFAULT NULL COMMENT '别名',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `pid` int(11) NOT NULL COMMENT '上级权限',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
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
COMMIT;

-- ----------------------------
-- Table structure for quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `quartz_job`;
CREATE TABLE `quartz_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bean_name` varchar(255) DEFAULT NULL COMMENT 'Spring Bean名称',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron 表达式',
  `is_pause` bit(1) DEFAULT NULL COMMENT '状态：1暂停、0启用',
  `job_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `method_name` varchar(255) DEFAULT NULL COMMENT '方法名称',
  `params` varchar(255) DEFAULT NULL COMMENT '参数',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `update_time` datetime DEFAULT NULL COMMENT '创建或更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of quartz_job
-- ----------------------------
BEGIN;
INSERT INTO `quartz_job` VALUES (1, 'visitsTask', '0 0 0 * * ?', b'0', '更新访客记录', 'run', NULL, '每日0点创建新的访客记录', '2019-01-08 14:53:31');
COMMIT;

-- ----------------------------
-- Table structure for quartz_log
-- ----------------------------
DROP TABLE IF EXISTS `quartz_log`;
CREATE TABLE `quartz_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `baen_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `exception_detail` text,
  `is_success` bit(1) DEFAULT NULL,
  `job_name` varchar(255) DEFAULT NULL,
  `method_name` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=384 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of quartz_log
-- ----------------------------
BEGIN;
INSERT INTO `quartz_log` VALUES (383, 'visitsTask', '2020-08-02 00:00:00', '0 0 0 * * ?', NULL, b'1', '更新访客记录', 'run', NULL, 31);
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
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
COMMIT;

-- ----------------------------
-- Table structure for roles_menus
-- ----------------------------
DROP TABLE IF EXISTS `roles_menus`;
CREATE TABLE `roles_menus` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`menu_id`,`role_id`) USING BTREE,
  KEY `FKcngg2qadojhi3a651a5adkvbq` (`role_id`) USING BTREE,
  CONSTRAINT `FKcngg2qadojhi3a651a5adkvbq` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FKq1knxf8ykt26we8k331naabjx` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of roles_menus
-- ----------------------------
BEGIN;
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
INSERT INTO `roles_menus` VALUES (1, 51);
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
INSERT INTO `roles_menus` VALUES (2, 51);
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
INSERT INTO `roles_menus` VALUES (5, 51);
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
INSERT INTO `roles_menus` VALUES (8, 51);
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
COMMIT;

-- ----------------------------
-- Table structure for roles_permissions
-- ----------------------------
DROP TABLE IF EXISTS `roles_permissions`;
CREATE TABLE `roles_permissions` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`,`permission_id`) USING BTREE,
  KEY `FKboeuhl31go7wer3bpy6so7exi` (`permission_id`) USING BTREE,
  CONSTRAINT `roles_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `roles_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of roles_permissions
-- ----------------------------
BEGIN;
INSERT INTO `roles_permissions` VALUES (1, 1);
INSERT INTO `roles_permissions` VALUES (2, 40);
INSERT INTO `roles_permissions` VALUES (4, 40);
INSERT INTO `roles_permissions` VALUES (5, 40);
INSERT INTO `roles_permissions` VALUES (6, 40);
INSERT INTO `roles_permissions` VALUES (7, 40);
INSERT INTO `roles_permissions` VALUES (8, 40);
INSERT INTO `roles_permissions` VALUES (9, 40);
INSERT INTO `roles_permissions` VALUES (10, 40);
INSERT INTO `roles_permissions` VALUES (11, 40);
INSERT INTO `roles_permissions` VALUES (2, 41);
INSERT INTO `roles_permissions` VALUES (4, 41);
INSERT INTO `roles_permissions` VALUES (2, 42);
INSERT INTO `roles_permissions` VALUES (5, 42);
INSERT INTO `roles_permissions` VALUES (2, 43);
INSERT INTO `roles_permissions` VALUES (6, 43);
INSERT INTO `roles_permissions` VALUES (2, 44);
INSERT INTO `roles_permissions` VALUES (2, 45);
INSERT INTO `roles_permissions` VALUES (4, 45);
INSERT INTO `roles_permissions` VALUES (6, 45);
INSERT INTO `roles_permissions` VALUES (7, 45);
INSERT INTO `roles_permissions` VALUES (11, 45);
INSERT INTO `roles_permissions` VALUES (2, 46);
INSERT INTO `roles_permissions` VALUES (4, 46);
INSERT INTO `roles_permissions` VALUES (7, 46);
INSERT INTO `roles_permissions` VALUES (2, 47);
INSERT INTO `roles_permissions` VALUES (4, 47);
INSERT INTO `roles_permissions` VALUES (2, 48);
INSERT INTO `roles_permissions` VALUES (5, 48);
INSERT INTO `roles_permissions` VALUES (8, 48);
INSERT INTO `roles_permissions` VALUES (2, 49);
INSERT INTO `roles_permissions` VALUES (5, 49);
INSERT INTO `roles_permissions` VALUES (8, 49);
INSERT INTO `roles_permissions` VALUES (2, 52);
INSERT INTO `roles_permissions` VALUES (6, 52);
INSERT INTO `roles_permissions` VALUES (9, 52);
INSERT INTO `roles_permissions` VALUES (2, 53);
INSERT INTO `roles_permissions` VALUES (6, 53);
INSERT INTO `roles_permissions` VALUES (9, 53);
INSERT INTO `roles_permissions` VALUES (2, 55);
INSERT INTO `roles_permissions` VALUES (6, 55);
INSERT INTO `roles_permissions` VALUES (9, 55);
INSERT INTO `roles_permissions` VALUES (10, 55);
INSERT INTO `roles_permissions` VALUES (11, 55);
INSERT INTO `roles_permissions` VALUES (2, 56);
INSERT INTO `roles_permissions` VALUES (6, 56);
INSERT INTO `roles_permissions` VALUES (9, 56);
INSERT INTO `roles_permissions` VALUES (11, 56);
INSERT INTO `roles_permissions` VALUES (2, 57);
INSERT INTO `roles_permissions` VALUES (5, 57);
INSERT INTO `roles_permissions` VALUES (8, 57);
INSERT INTO `roles_permissions` VALUES (2, 58);
INSERT INTO `roles_permissions` VALUES (4, 58);
INSERT INTO `roles_permissions` VALUES (5, 58);
INSERT INTO `roles_permissions` VALUES (6, 58);
INSERT INTO `roles_permissions` VALUES (7, 58);
INSERT INTO `roles_permissions` VALUES (8, 58);
INSERT INTO `roles_permissions` VALUES (9, 58);
INSERT INTO `roles_permissions` VALUES (10, 58);
INSERT INTO `roles_permissions` VALUES (11, 58);
INSERT INTO `roles_permissions` VALUES (2, 59);
INSERT INTO `roles_permissions` VALUES (4, 59);
INSERT INTO `roles_permissions` VALUES (5, 59);
INSERT INTO `roles_permissions` VALUES (2, 60);
INSERT INTO `roles_permissions` VALUES (4, 60);
INSERT INTO `roles_permissions` VALUES (2, 61);
INSERT INTO `roles_permissions` VALUES (5, 61);
INSERT INTO `roles_permissions` VALUES (8, 61);
INSERT INTO `roles_permissions` VALUES (2, 62);
INSERT INTO `roles_permissions` VALUES (5, 62);
INSERT INTO `roles_permissions` VALUES (7, 62);
INSERT INTO `roles_permissions` VALUES (2, 63);
INSERT INTO `roles_permissions` VALUES (5, 63);
INSERT INTO `roles_permissions` VALUES (8, 63);
INSERT INTO `roles_permissions` VALUES (2, 64);
INSERT INTO `roles_permissions` VALUES (6, 64);
INSERT INTO `roles_permissions` VALUES (2, 65);
INSERT INTO `roles_permissions` VALUES (6, 65);
INSERT INTO `roles_permissions` VALUES (9, 65);
INSERT INTO `roles_permissions` VALUES (10, 65);
INSERT INTO `roles_permissions` VALUES (2, 66);
INSERT INTO `roles_permissions` VALUES (6, 66);
INSERT INTO `roles_permissions` VALUES (2, 68);
INSERT INTO `roles_permissions` VALUES (2, 69);
INSERT INTO `roles_permissions` VALUES (2, 70);
INSERT INTO `roles_permissions` VALUES (5, 70);
INSERT INTO `roles_permissions` VALUES (2, 71);
INSERT INTO `roles_permissions` VALUES (5, 71);
INSERT INTO `roles_permissions` VALUES (2, 72);
INSERT INTO `roles_permissions` VALUES (5, 72);
INSERT INTO `roles_permissions` VALUES (2, 73);
INSERT INTO `roles_permissions` VALUES (5, 73);
INSERT INTO `roles_permissions` VALUES (2, 74);
INSERT INTO `roles_permissions` VALUES (4, 74);
INSERT INTO `roles_permissions` VALUES (2, 75);
INSERT INTO `roles_permissions` VALUES (4, 75);
INSERT INTO `roles_permissions` VALUES (7, 75);
INSERT INTO `roles_permissions` VALUES (2, 76);
INSERT INTO `roles_permissions` VALUES (6, 76);
INSERT INTO `roles_permissions` VALUES (2, 77);
INSERT INTO `roles_permissions` VALUES (4, 77);
INSERT INTO `roles_permissions` VALUES (7, 77);
INSERT INTO `roles_permissions` VALUES (2, 78);
INSERT INTO `roles_permissions` VALUES (6, 78);
INSERT INTO `roles_permissions` VALUES (2, 79);
INSERT INTO `roles_permissions` VALUES (4, 79);
INSERT INTO `roles_permissions` VALUES (2, 80);
INSERT INTO `roles_permissions` VALUES (4, 80);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `enabled` bigint(20) DEFAULT NULL COMMENT '状态：1启用、0禁用',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `last_password_reset_time` datetime DEFAULT NULL COMMENT '最后修改密码的日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UK_kpubos9gc2cvtkb0thktkbkes` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (4, '/avatar/2019-07-15-20291653073428.jpg', '2019-04-10 10:48:35', 'admin@ok.com', 1, '14e1b600b1fd579f47433b88e8d85291', 'admin', '2020-11-24 18:25:48');
COMMIT;

-- ----------------------------
-- Table structure for users_roles
-- ----------------------------
DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE `users_roles` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `FKq4eq273l04bpu4efj0jd0jb98` (`role_id`) USING BTREE,
  CONSTRAINT `users_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `users_roles_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of users_roles
-- ----------------------------
BEGIN;
INSERT INTO `users_roles` VALUES (4, 1);
COMMIT;

-- ----------------------------
-- Table structure for verification_code
-- ----------------------------
DROP TABLE IF EXISTS `verification_code`;
CREATE TABLE `verification_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` varchar(255) DEFAULT NULL COMMENT '验证码',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `status` bit(1) DEFAULT NULL COMMENT '状态：1有效、0过期',
  `type` varchar(255) DEFAULT NULL COMMENT '验证码类型：email或者短信',
  `value` varchar(255) DEFAULT NULL COMMENT '接收邮箱或者手机号码',
  `scenes` varchar(255) DEFAULT NULL COMMENT '业务名称：如重置邮箱、重置密码等',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of verification_code
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for visits
-- ----------------------------
DROP TABLE IF EXISTS `visits`;
CREATE TABLE `visits` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_counts` bigint(20) DEFAULT NULL,
  `pv_counts` bigint(20) DEFAULT NULL,
  `week_day` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_11aksgq87euk9bcyeesfs4vtp` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=436 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of visits
-- ----------------------------
BEGIN;
INSERT INTO `visits` VALUES (434, '2020-08-02 00:46:57', '2020-08-02', 1, 1, 'Sun');
INSERT INTO `visits` VALUES (435, '2020-11-24 18:23:59', '2020-11-24', 1, 1, 'Tue');
COMMIT;

-- ----------------------------
-- Table structure for wms_address
-- ----------------------------
DROP TABLE IF EXISTS `wms_address`;
CREATE TABLE `wms_address` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address_type_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK67rl8f969orhpugijk7ertqu5` (`address_type_id`),
  CONSTRAINT `FK67rl8f969orhpugijk7ertqu5` FOREIGN KEY (`address_type_id`) REFERENCES `wms_address_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_address
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_address_type
-- ----------------------------
DROP TABLE IF EXISTS `wms_address_type`;
CREATE TABLE `wms_address_type` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_address_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_customer
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer`;
CREATE TABLE `wms_customer` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `short_name_cn` varchar(20) DEFAULT NULL,
  `short_name_en` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_customer
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_customer_order
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order`;
CREATE TABLE `wms_customer_order` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `auto_increase_sn` varchar(255) DEFAULT NULL,
  `cancel_description` varchar(255) DEFAULT NULL,
  `client_address` varchar(255) DEFAULT NULL,
  `client_name` varchar(255) NOT NULL,
  `client_operator` varchar(255) DEFAULT NULL,
  `client_order_sn` varchar(255) DEFAULT NULL,
  `client_order_sn2` varchar(255) DEFAULT NULL,
  `client_store` varchar(255) NOT NULL,
  `complete_description` varchar(255) DEFAULT NULL,
  `complete_price` decimal(19,2) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `expire_date_max` date DEFAULT NULL,
  `expire_date_min` date DEFAULT NULL,
  `fetch_all` bit(1) NOT NULL,
  `flow_sn` varchar(255) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_printed` bit(1) DEFAULT NULL,
  `is_satisfied` bit(1) DEFAULT NULL,
  `order_status` int(11) DEFAULT NULL,
  `target_ware_zones` varchar(255) DEFAULT NULL,
  `total_price` decimal(19,2) DEFAULT NULL,
  `use_pack_count` bit(1) DEFAULT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `pack_id` bigint(20) DEFAULT NULL,
  `user_creator_id` bigint(20) DEFAULT NULL,
  `user_gathering_id` bigint(20) DEFAULT NULL,
  `user_sending_id` bigint(20) DEFAULT NULL,
  `sign_time` datetime DEFAULT NULL,
  `print_title` varchar(255) DEFAULT NULL,
  `receive_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK87o5jxxtu5fj0oppo2pxvk23k` (`owner_id`),
  KEY `FKm8g4jh1p8tgbxj59vy5f6i7yn` (`pack_id`),
  KEY `FKj4t64s5hnf1obetdw0vsvpl86` (`user_creator_id`),
  KEY `FKenc9bneww5jo89i0fos6b4nx7` (`user_gathering_id`),
  KEY `FK8v9ld1xcf6sjuekxphylkdc22` (`user_sending_id`),
  CONSTRAINT `FK87o5jxxtu5fj0oppo2pxvk23k` FOREIGN KEY (`owner_id`) REFERENCES `wms_customer` (`id`),
  CONSTRAINT `FK8v9ld1xcf6sjuekxphylkdc22` FOREIGN KEY (`user_sending_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKenc9bneww5jo89i0fos6b4nx7` FOREIGN KEY (`user_gathering_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKj4t64s5hnf1obetdw0vsvpl86` FOREIGN KEY (`user_creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKm8g4jh1p8tgbxj59vy5f6i7yn` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_customer_order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_customer_order_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order_item`;
CREATE TABLE `wms_customer_order_item` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `pack_count` int(11) DEFAULT NULL,
  `price` decimal(19,2) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `quantity_initial` bigint(20) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `customer_order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcigudap8fdsaygbfgnnje4hfs` (`customer_order_id`),
  CONSTRAINT `FKcigudap8fdsaygbfgnnje4hfs` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_customer_order_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_customer_order_stock
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer_order_stock`;
CREATE TABLE `wms_customer_order_stock` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `price` decimal(19,2) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `quantity_initial` bigint(20) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `customer_order_id` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `ware_position_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnelosame93oc8dk3paj6s8xh1` (`customer_order_id`),
  KEY `FKobf4ws7hvxnl4xu9e53orq6h0` (`goods_id`),
  KEY `FK75nd8dwqxnhjky9x1s8j1fep0` (`ware_position_id`),
  CONSTRAINT `FK75nd8dwqxnhjky9x1s8j1fep0` FOREIGN KEY (`ware_position_id`) REFERENCES `wms_ware_position` (`id`),
  CONSTRAINT `FKnelosame93oc8dk3paj6s8xh1` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`),
  CONSTRAINT `FKobf4ws7hvxnl4xu9e53orq6h0` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_customer_order_stock
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_goods
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods`;
CREATE TABLE `wms_goods` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `months_of_warranty` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `pack_count` int(11) NOT NULL,
  `price` float NOT NULL,
  `return_price` float NOT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `unit` varchar(255) NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `goods_type_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKivxemy2vpkuws6w84xp8q5obh` (`customer_id`),
  KEY `FKeabmgyqha1j52id423urd1prb` (`goods_type_id`),
  CONSTRAINT `FKeabmgyqha1j52id423urd1prb` FOREIGN KEY (`goods_type_id`) REFERENCES `wms_goods_type` (`id`),
  CONSTRAINT `FKivxemy2vpkuws6w84xp8q5obh` FOREIGN KEY (`customer_id`) REFERENCES `wms_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_goods
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods_type`;
CREATE TABLE `wms_goods_type` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_goods_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_join_table_customers_users
-- ----------------------------
DROP TABLE IF EXISTS `wms_join_table_customers_users`;
CREATE TABLE `wms_join_table_customers_users` (
  `customers_id` bigint(20) NOT NULL,
  `users_id` bigint(20) NOT NULL,
  KEY `FKe986ai7mjfj66xgasvc2d97tc` (`users_id`),
  KEY `FKnhxi99588dm2fosv8ggav9y8f` (`customers_id`),
  CONSTRAINT `FKe986ai7mjfj66xgasvc2d97tc` FOREIGN KEY (`users_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKnhxi99588dm2fosv8ggav9y8f` FOREIGN KEY (`customers_id`) REFERENCES `wms_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_join_table_customers_users
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_operate_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `wms_operate_snapshot`;
CREATE TABLE `wms_operate_snapshot` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `customer_order_id` bigint(20) DEFAULT NULL,
  `pack_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9ap438kqyd85r2oi7x3q1drq6` (`customer_order_id`),
  KEY `FK3b1iiekyytkxekqwlbjnc5qwr` (`pack_id`),
  CONSTRAINT `FK3b1iiekyytkxekqwlbjnc5qwr` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`),
  CONSTRAINT `FK9ap438kqyd85r2oi7x3q1drq6` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_operate_snapshot
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_pack
-- ----------------------------
DROP TABLE IF EXISTS `wms_pack`;
CREATE TABLE `wms_pack` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `cancel_description` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `flow_sn` varchar(255) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_packaged` bit(1) DEFAULT NULL,
  `is_printed` bit(1) DEFAULT NULL,
  `pack_status` int(11) DEFAULT NULL,
  `pack_type` int(11) DEFAULT NULL,
  `packages` int(11) DEFAULT NULL,
  `signed_photo` varchar(255) DEFAULT NULL,
  `total_price` decimal(19,2) DEFAULT NULL,
  `tracking_number` varchar(255) DEFAULT NULL,
  `address_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `receive_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7v7oum3arwxl9du3vnoutdrfv` (`address_id`),
  KEY `FKrb2ekgr4me41uitq6vt67687` (`customer_id`),
  KEY `FKquvvxpiolia18jtbshgb9i35n` (`user_id`),
  CONSTRAINT `FK7v7oum3arwxl9du3vnoutdrfv` FOREIGN KEY (`address_id`) REFERENCES `wms_address` (`id`),
  CONSTRAINT `FKquvvxpiolia18jtbshgb9i35n` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKrb2ekgr4me41uitq6vt67687` FOREIGN KEY (`customer_id`) REFERENCES `wms_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_pack
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_pack_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_pack_item`;
CREATE TABLE `wms_pack_item` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `expire_date` date NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `quantity` bigint(20) NOT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `pack_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3wy5q1qnj3q1dgooxg15u3gfe` (`pack_id`),
  CONSTRAINT `FK3wy5q1qnj3q1dgooxg15u3gfe` FOREIGN KEY (`pack_id`) REFERENCES `wms_pack` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_pack_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_receive_goods
-- ----------------------------
DROP TABLE IF EXISTS `wms_receive_goods`;
CREATE TABLE `wms_receive_goods` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `audit_time` datetime DEFAULT NULL,
  `auditor` varchar(255) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `flow_sn` varchar(255) DEFAULT NULL,
  `is_audited` bit(1) DEFAULT NULL,
  `receive_goods_type` int(11) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKiy8xcjslvahnq2xej7yi3oyqb` (`customer_id`),
  CONSTRAINT `FKiy8xcjslvahnq2xej7yi3oyqb` FOREIGN KEY (`customer_id`) REFERENCES `wms_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_receive_goods
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_receive_goods_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_receive_goods_item`;
CREATE TABLE `wms_receive_goods_item` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `quantity_cancel_fetch` bigint(20) DEFAULT NULL,
  `quantity_initial` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `receive_goods_id` bigint(20) DEFAULT NULL,
  `ware_position_id` bigint(20) DEFAULT NULL,
  `price` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKixcxn54e16vqxnq743hgeuhxk` (`goods_id`),
  KEY `FK7myex2ugivdbt8x1nmruml7rn` (`receive_goods_id`),
  KEY `FKk03nijbthoq9fkn8q1kv75q7f` (`ware_position_id`),
  CONSTRAINT `FK7myex2ugivdbt8x1nmruml7rn` FOREIGN KEY (`receive_goods_id`) REFERENCES `wms_receive_goods` (`id`),
  CONSTRAINT `FKixcxn54e16vqxnq743hgeuhxk` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`),
  CONSTRAINT `FKk03nijbthoq9fkn8q1kv75q7f` FOREIGN KEY (`ware_position_id`) REFERENCES `wms_ware_position` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_receive_goods_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_stock
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock`;
CREATE TABLE `wms_stock` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `expire_date` date DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `ware_position_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKm7613w9xxy7inl6dpydf21svp` (`goods_id`),
  KEY `FKjabua3ntvqsrv9wwqyfspow6l` (`ware_position_id`),
  CONSTRAINT `FKjabua3ntvqsrv9wwqyfspow6l` FOREIGN KEY (`ware_position_id`) REFERENCES `wms_ware_position` (`id`),
  CONSTRAINT `FKm7613w9xxy7inl6dpydf21svp` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_stock
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_stock_flow
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_flow`;
CREATE TABLE `wms_stock_flow` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `expire_date` date DEFAULT NULL,
  `flow_operate_type` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `pack_count` int(11) DEFAULT NULL,
  `price` decimal(19,2) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `customer_order_id` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `receive_goods_id` bigint(20) DEFAULT NULL,
  `ware_position_in_id` bigint(20) DEFAULT NULL,
  `ware_position_out_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKje4cp70xrmm91t5xjttk15xyo` (`customer_order_id`),
  KEY `FKllp5wpv70hgvj1rxhq17p8wr` (`goods_id`),
  KEY `FK4ad7nvgjesgd8ufatljeufgq0` (`receive_goods_id`),
  KEY `FKpb1uji669s559903dnogbempq` (`ware_position_in_id`),
  KEY `FKef6lig6xjxaw34fq8dodaa6pt` (`ware_position_out_id`),
  CONSTRAINT `FK4ad7nvgjesgd8ufatljeufgq0` FOREIGN KEY (`receive_goods_id`) REFERENCES `wms_receive_goods` (`id`),
  CONSTRAINT `FKef6lig6xjxaw34fq8dodaa6pt` FOREIGN KEY (`ware_position_out_id`) REFERENCES `wms_ware_position` (`id`),
  CONSTRAINT `FKje4cp70xrmm91t5xjttk15xyo` FOREIGN KEY (`customer_order_id`) REFERENCES `wms_customer_order` (`id`),
  CONSTRAINT `FKllp5wpv70hgvj1rxhq17p8wr` FOREIGN KEY (`goods_id`) REFERENCES `wms_goods` (`id`),
  CONSTRAINT `FKpb1uji669s559903dnogbempq` FOREIGN KEY (`ware_position_in_id`) REFERENCES `wms_ware_position` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_stock_flow
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_store
-- ----------------------------
DROP TABLE IF EXISTS `wms_store`;
CREATE TABLE `wms_store` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_store
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_ware_position
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_position`;
CREATE TABLE `wms_ware_position` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `ware_zone_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt2vusqjgiepb9xbwjvbuspc4w` (`ware_zone_id`),
  CONSTRAINT `FKt2vusqjgiepb9xbwjvbuspc4w` FOREIGN KEY (`ware_zone_id`) REFERENCES `wms_ware_zone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_ware_position
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for wms_ware_zone
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_zone`;
CREATE TABLE `wms_ware_zone` (
  `id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_ware_zone
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
