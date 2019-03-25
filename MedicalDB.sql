/*==============================================================*/
/* 医疗系统数据库                          						*/
/*==============================================================*/
drop database Medical;

create database Medical;
use Medical;

drop table  人员信息表;

drop table His病人信息表;

drop table 病人信息表;

drop table  住院信息表;

drop table  用户表;

drop table  科室表;

drop table  评估记录表;


/*==============================================================*/
/* Table: 人员信息表                                                 */
/*==============================================================*/
create table 人员信息表 
(
   ID                   varchar(36)                       not null,
   姓名                   varchar(16)                    null,
   性别                   int                            null,
   编码						varchar(32)					null,
   出生日期                 date                           null,
   身份证号                 varchar(20)                    null,
   联系方式                 varchar(12)                    null,
   住址                   varchar(1000)                  null,
   标识						int							null
   constraint PK_人员信息表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 病人信息表                                                 */
/*==============================================================*/
create table 病人信息表 
(
   [ID] [int] IDENTITY(1,1) NOT NULL,
	[姓名] [varchar](16) NULL,
	[性别] [int] NULL,
	[编码] [varchar](36) NULL,
	年龄 int NULL,
	[身份证号] [varchar](20) NULL,
	[联系方式] [varchar](12) NULL,
	[联系地址] [nvarchar](1000) NULL,
	[婚姻状况] [int] NULL,
	[户籍地址] [nvarchar](1000) NULL,
	[工作单位] [nvarchar](1000) NULL,
	[登记时间] [datetime] NULL,
	科室    varchar(100) null,
	科室Id  varchar(36) null,
	床位    varchar(36) null,
	[标识] [int] NULL,
   constraint PK_病人信息表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: His病人信息表                                                 */
/*==============================================================*/
create table His病人信息表(
ID int identity(1,1)               not null
      ,姓名 varchar(16) null
      ,性别 int null
      ,年龄 int null
      ,[身份证号] varchar(20) null
      ,[联系方式] varchar(12) null
      ,[联系地址] nvarchar(1000) null
      ,[婚姻状况] int null
      ,[户籍地址] nvarchar(1000) null
      ,[工作单位] nvarchar(1000) null
      ,[登记时间] date null
      ,[标识] int null
      ,[编码] varchar(36) null,
	  科室  varchar(100),
	  科室id varchar(36),
	  床位  varchar(36)
);

/*==============================================================*/
/* Table: 住院信息表                                                 */
/*==============================================================*/
create table 住院信息表 
(
   ID                   int             identity(1,1)               not null,
   科室ID                 int                            null,
   住院编码                 varchar(36)                    null,
   病人ID                 int                            null,
   constraint PK_住院信息表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 用户表                                                   */
/*==============================================================*/
create table 用户表 
(
   ID                   int               identity(1,1)             not null,
   用户名                  varchar(32)                    null,
   密码                   varchar(16)                    null,
   标识					int							null,
   内置管理员			int							null,
   constraint PK_用户表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 科室表                                                   */
/*==============================================================*/
create table 科室表 
(
   ID                   int              identity(1,1)              not null,
   名称                   nvarchar(36)                   null,
   编码                   varchar(36)                    null,
   描述                   nvarchar(1000)				 null,
   标识					  int							 null,
   constraint PK_科室表 primary key clustered (ID)
);


/*==============================================================*/
/* Table: 评估表评分记录表                                              */
/*==============================================================*/
create table 评估记录表 
(
   ID                   int                identity(1,1)            not null,
   病人Id					varchar(36)					null,
   评估项目                nvarchar(500)                            null,
   评估类别					int						null,
   评估总分                 float                            null,
   评估日期                 datetime                           null,
   等级						int								null,
   constraint PK_评估表评分记录表 primary key clustered (ID)
);

INSERT [dbo].[His病人信息表] ([姓名], [性别], [出生日期], [身份证号], [联系方式], [联系地址], [婚姻状况], [户籍地址], [工作单位], [登记时间], [标识], [编码], [科室], [科室id], [床位]) VALUES ('小李', 1, '1958-05-15', '48635132155412620', '15452154524', '没有', 1, '中国', '中国', '2018-01-01', 0, '12100', '外科', '12010', '15220');
INSERT [dbo].[His病人信息表] ([姓名], [性别], [出生日期], [身份证号], [联系方式], [联系地址], [婚姻状况], [户籍地址], [工作单位], [登记时间], [标识], [编码], [科室], [科室id], [床位]) VALUES ('花花', 0, '2008-11-08', '45135161322156132', '13515431352', '没有', 0, '中国', '中国', '2018-05-12', 0, '15202', '外科', '12010', '12412');
INSERT [dbo].[His病人信息表] ([姓名], [性别], [出生日期], [身份证号], [联系方式], [联系地址], [婚姻状况], [户籍地址], [工作单位], [登记时间], [标识], [编码], [科室], [科室id], [床位]) VALUES ('刘柳', 1, '1993-05-22', '48561351865132159', '18432351239', '没有', 1, '中国', '中国', '2018-10-20', 0, '12002', '内科', '12020', '15320');
INSERT [dbo].[His病人信息表] ([姓名], [性别], [出生日期], [身份证号], [联系方式], [联系地址], [婚姻状况], [户籍地址], [工作单位], [登记时间], [标识], [编码], [科室], [科室id], [床位]) VALUES ('芬芬', 0, '1990-01-08', '48531546853151341', '15386315652', '没有', 0, '中国', '中国', '2018-11-28', 0, '51121', '妇产科', '12030', '45122');
INSERT [dbo].[His病人信息表] ([姓名], [性别], [出生日期], [身份证号], [联系方式], [联系地址], [婚姻状况], [户籍地址], [工作单位], [登记时间], [标识], [编码], [科室], [科室id], [床位]) VALUES ('华润', 1, '1990-06-11', '54345212353121330', '16453485214', '没有', 0, '中国', '中国', '2018-11-28', 0, '24215', '神经内科', '12040', '135341');

insert into 人员信息表([ID] ,[姓名],[性别] ,[编码] ,[出生日期] ,[身份证号] ,[联系方式],[住址],[标识]) values('001',	'李医生',	1,	'10010',	'2018-01-01',	'370205197405213513',	'18349511234',	'没有',	0);

insert into 用户表([用户名],[密码] ,[标识] ,[内置管理员]) values('admin'	,'123',		0,	1);

