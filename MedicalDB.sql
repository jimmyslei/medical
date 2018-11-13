/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2018/10/13 12:40:59                          */
/*==============================================================*/
create database Medical;
use Medical;

drop table if exists ��Ա��Ϣ��;

drop table if exists סԺ��Ϣ��;

drop table if exists �û���;

drop table if exists ���ұ�;

drop table if exists ������;

drop table if exists ���������ּ�¼��;

drop table if exists ��ҳ��Σչʾ��;

/*==============================================================*/
/* Table: ��Ա��Ϣ��                                                 */
/*==============================================================*/
create table ��Ա��Ϣ�� 
(
   ID                   int                            not null,
   ����                   varchar(16)                    null,
   �Ա�                   int                            null,
   ��������                 date                           null,
   ���֤��                 varchar(20)                    null,
   ��ϵ��ʽ                 varchar(12)                    null,
   סַ                   varchar(1000)                  null,
   constraint PK_��Ա��Ϣ�� primary key clustered (ID)
);

/*==============================================================*/
/* Table: סԺ��Ϣ��                                                 */
/*==============================================================*/
create table סԺ��Ϣ�� 
(
   ID                   int                            not null,
   ����ID                 int                            null,
   סԺ����                 varchar(36)                    null,
   ����ID                 int                            null,
   constraint PK_סԺ��Ϣ�� primary key clustered (ID)
);

/*==============================================================*/
/* Table: �û���                                                   */
/*==============================================================*/
create table �û��� 
(
   ID                   int                            not null,
   �û���                  varchar(32)                    null,
   ����                   varchar(16)                    null,
   ��ԱID                 int                            null,
   constraint PK_�û��� primary key clustered (ID)
);

/*==============================================================*/
/* Table: ���ұ�                                                   */
/*==============================================================*/
create table ���ұ� 
(
   ID                   int                            not null,
   ����                   nvarchar(36)                   null,
   ����                   varchar(36)                    null,
   constraint PK_���ұ� primary key clustered (ID)
);

/*==============================================================*/
/* Table: ������                                                   */
/*==============================================================*/
create table ������ 
(
   ID                   int                            not null,
   ����                   varchar(100)                   null,
   constraint PK_������ primary key clustered (ID)
);

/*==============================================================*/
/* Table: ���������ּ�¼��                                              */
/*==============================================================*/
create table ���������ּ�¼�� 
(
   ID                   int                            not null,
   ������ID                int                            null,
   �����ܷ�                 int                            null,
   ��������                 date                           null,
   constraint PK_���������ּ�¼�� primary key clustered (ID)
);

/*==============================================================*/
/* Table: ��ҳ��Σչʾ��                                               */
/*==============================================================*/
create table ��ҳ��Σչʾ�� 
(
   ID                   int                            not null,
   ����ID                 int                            null,
   constraint PK_��ҳ��Σչʾ�� primary key clustered (ID)
);

