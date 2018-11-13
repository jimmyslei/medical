/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2018/10/13 12:40:59                          */
/*==============================================================*/
create database Medical;
use Medical;

drop table if exists 人员信息表;

drop table if exists 住院信息表;

drop table if exists 用户表;

drop table if exists 科室表;

drop table if exists 评估表;

drop table if exists 评估表评分记录表;

drop table if exists 首页高危展示表;

/*==============================================================*/
/* Table: 人员信息表                                                 */
/*==============================================================*/
create table 人员信息表 
(
   ID                   int                            not null,
   姓名                   varchar(16)                    null,
   性别                   int                            null,
   出生日期                 date                           null,
   身份证号                 varchar(20)                    null,
   联系方式                 varchar(12)                    null,
   住址                   varchar(1000)                  null,
   constraint PK_人员信息表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 住院信息表                                                 */
/*==============================================================*/
create table 住院信息表 
(
   ID                   int                            not null,
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
   ID                   int                            not null,
   用户名                  varchar(32)                    null,
   密码                   varchar(16)                    null,
   人员ID                 int                            null,
   constraint PK_用户表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 科室表                                                   */
/*==============================================================*/
create table 科室表 
(
   ID                   int                            not null,
   名称                   nvarchar(36)                   null,
   编码                   varchar(36)                    null,
   constraint PK_科室表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 评估表                                                   */
/*==============================================================*/
create table 评估表 
(
   ID                   int                            not null,
   名称                   varchar(100)                   null,
   constraint PK_评估表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 评估表评分记录表                                              */
/*==============================================================*/
create table 评估表评分记录表 
(
   ID                   int                            not null,
   评估表ID                int                            null,
   评估总分                 int                            null,
   评估日期                 date                           null,
   constraint PK_评估表评分记录表 primary key clustered (ID)
);

/*==============================================================*/
/* Table: 首页高危展示表                                               */
/*==============================================================*/
create table 首页高危展示表 
(
   ID                   int                            not null,
   评估ID                 int                            null,
   constraint PK_首页高危展示表 primary key clustered (ID)
);

