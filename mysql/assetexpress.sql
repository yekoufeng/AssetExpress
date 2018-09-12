/*
Navicat MySQL Data Transfer

Source Server         : 192.168.93.183
Source Server Version : 50722
Source Host           : 192.168.93.183:3306
Source Database       : assetexpress_mjc

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-09-06 09:58:52
*/
-- CREATE USER 'assetexpress'@'%' IDENTIFIED BY '123456';
-- use assetexpress;
-- GRANT all privileges ON assetexpress TO 'assetexpress'@'%';
-- flush privileges;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Procedure structure for CHECK_VERSION_VALID
-- ----------------------------
DROP PROCEDURE IF EXISTS `CHECK_VERSION_VALID`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CHECK_VERSION_VALID`(IN p_versionno varchar(50), IN p_pid int, IN p_channel int)
BEGIN
	declare p_maxversionno varchar(50);
  
	select max(versionno) into p_maxversionno from version where version.projectid=p_pid and version.channelid=p_channel;
	if p_maxversionno is null then
		select "" into p_maxversionno;
	end if;
	if p_versionno > p_maxversionno then 
		SELECT 1;
	ELSE
		SELECT 0;
	end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for INSERT_FILEINFO
-- ----------------------------
DROP PROCEDURE IF EXISTS `INSERT_FILEINFO`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `INSERT_FILEINFO`(IN _projectid bigint, IN _path varchar(250))
BEGIN
	DECLARE p_fileID BIGINT DEFAULT 0;
	select fileinfo.id into p_fileID from fileinfo where fileinfo.path= _path and fileinfo.projectid=_projectid;
	if p_fileID =0  then
		INSERT INTO fileinfo(projectid, path, create_time) VALUES(_projectid, _path, NOW());
		SELECT @Result:=LAST_INSERT_ID();
		SELECT @Result;	
	ELSE
		SELECT p_fileID;
	end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for P_ADD_MEMBER_TO_GROUP
-- ----------------------------
DROP PROCEDURE IF EXISTS `P_ADD_MEMBER_TO_GROUP`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `P_ADD_MEMBER_TO_GROUP`(IN p_username varchar(50), IN p_groupid int, IN p_privilege int)
BEGIN
	declare p_uid int default 0;
	declare p_gid  int default 0;
	select id into p_uid from `user` where `user`.username = p_username;
	select id into p_gid from `group` where `group`.id = p_groupid;
	if p_uid !=0 and p_gid !=0 then
		if not exists (select 1 from group_user where group_user.group_id = p_gid and group_user.user_i_d=p_uid) then 
			insert into group_user( group_id,  user_i_d, privli, operate_time ) values(p_gid, p_uid, p_privilege, NOW());
			select 0;
		ELSE
			select 1;

		end if;
	ELSE
		select 2;
	end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for P_ADD_MEMBER_TO_PROJECT
-- ----------------------------
DROP PROCEDURE IF EXISTS `P_ADD_MEMBER_TO_PROJECT`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `P_ADD_MEMBER_TO_PROJECT`(IN p_username varchar(50), IN p_projectid int, IN p_privilege int)
BEGIN
	declare p_uid int default 0;
	declare p_pid  int default 0;
	select id into p_uid from `user` where `user`.username = p_username;
	select id into p_pid from `project` where `project`.id = p_projectid;
	if p_uid !=0 and p_pid !=0 then
		if not exists (select 1 from project_user where project_user.project_i_d = p_pid and project_user.user_i_d=p_uid) then 
			insert into project_user( project_i_d,  user_i_d, privli, operate_time ) values(p_pid, p_uid, p_privilege, now());
			select 0;
		ELSE
			select 1;
		end if;
	ELSE
		select 2;
	end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for P_GET_USER_PROJECT_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `P_GET_USER_PROJECT_LIST`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `P_GET_USER_PROJECT_LIST`(IN p_userID int)
BEGIN
	 select /*project_user.user_i_d,*/ project.id, project.name, project.description , project.create_time from project_user right join project on project_user.project_i_d=project.id where project_user.user_i_d=p_userID;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for release_publish
-- ----------------------------
DROP PROCEDURE IF EXISTS `release_publish`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `release_publish`(in p_pid bigint, in p_cid bigint)
BEGIN
	#Routine body goes here...
	declare sid BIGINT;
	declare vid BIGINT;
	declare vdesc VARCHAR(100);
	declare stype TINYINT;

	declare flag int;

	-- 遍历数据结束标志
	DECLARE done INT DEFAULT FALSE;

	
	DECLARE cur_pub cursor for select versiondesc,strategy_type,strategy_id, version_id from version_publish inner join version on version_publish.version_id=version.id where type=0 and version.projectid=p_pid and version.channelid=p_cid;

	-- 将结束标志绑定到游标
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	open cur_pub;
	-- 遍历
	read_loop: LOOP
		fetch next from cur_pub into vdesc, stype, sid, vid;
		if done THEN
			leave read_loop;
		end if;

		if exists(select 1 from version_publish where version_id = vid and type = 1) then 
			update version_publish set versiondesc=vdesc,strategy_type=stype,strategy_id=sid where version_id = vid and type = 1;
		else
			insert into version_publish(type,versiondesc,strategy_type,strategy_id,version_id) values(1, vdesc, stype, sid, vid);
		end if;
		
	end loop;

	close cur_pub;
END
;;
DELIMITER ;
