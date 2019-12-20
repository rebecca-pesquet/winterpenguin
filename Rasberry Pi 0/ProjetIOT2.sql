/*==============================================================*/
/* Nom de SGBD :  Sybase SQL Anywhere 11                        */
/* Date de création :  17/12/2019 13:49:17                      */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_T_DONNEE_RECUPERER_T_SONDE') then
    alter table T_DONNEES
       delete foreign key FK_T_DONNEE_RECUPERER_T_SONDE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_T_UTILIS_GERER_T_SONDE') then
    alter table T_UTILISATEUR
       delete foreign key FK_T_UTILIS_GERER_T_SONDE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RECUPERER_FK'
     and t.table_name='T_DONNEES'
) then
   drop index T_DONNEES.RECUPERER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='T_DONNEES_PK'
     and t.table_name='T_DONNEES'
) then
   drop index T_DONNEES.T_DONNEES_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='T_DONNEES'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table T_DONNEES
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='T_SONDE_PK'
     and t.table_name='T_SONDE'
) then
   drop index T_SONDE.T_SONDE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='T_SONDE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table T_SONDE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='GERER_FK'
     and t.table_name='T_UTILISATEUR'
) then
   drop index T_UTILISATEUR.GERER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='T_UTILISATEUR_PK'
     and t.table_name='T_UTILISATEUR'
) then
   drop index T_UTILISATEUR.T_UTILISATEUR_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='T_UTILISATEUR'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table T_UTILISATEUR
end if;

/*==============================================================*/
/* Table : T_DONNEES                                            */
/*==============================================================*/
create table T_DONNEES 
(
   ID_DONN              integer                        not null default autoincrement,
   ID_SOND              integer                        not null,
   DONN_TEMP            varchar(5)                     null,
   DONN_HUMI            varchar(5)                     null,
   constraint PK_T_DONNEES primary key (ID_DONN)
);

/*==============================================================*/
/* Index : T_DONNEES_PK                                         */
/*==============================================================*/
create unique index T_DONNEES_PK on T_DONNEES (
ID_DONN ASC
);

/*==============================================================*/
/* Index : RECUPERER_FK                                         */
/*==============================================================*/
create index RECUPERER_FK on T_DONNEES (
ID_SOND ASC
);

/*==============================================================*/
/* Table : T_SONDE                                              */
/*==============================================================*/
create table T_SONDE 
(
   ID_SOND              integer                        not null default autoincrement,
   SOND_NOM             varchar(50)                    null,
   SOND_LOCA            varchar(200)                   null,
   constraint PK_T_SONDE primary key (ID_SOND)
);

/*==============================================================*/
/* Index : T_SONDE_PK                                           */
/*==============================================================*/
create unique index T_SONDE_PK on T_SONDE (
ID_SOND ASC
);

/*==============================================================*/
/* Table : T_UTILISATEUR                                        */
/*==============================================================*/
create table T_UTILISATEUR 
(
   ID_UTILI             integer                        not null default autoincrement,
   ID_SOND              integer                        not null,
   UTILI_NOM            varchar(50)                    null,
   UTILI_PRENOM         varchar(50)                    null,
   UTILI_TEL            varchar(16)                    null,
   constraint PK_T_UTILISATEUR primary key (ID_UTILI)
);

/*==============================================================*/
/* Index : T_UTILISATEUR_PK                                     */
/*==============================================================*/
create unique index T_UTILISATEUR_PK on T_UTILISATEUR (
ID_UTILI ASC
);

/*==============================================================*/
/* Index : GERER_FK                                             */
/*==============================================================*/
create index GERER_FK on T_UTILISATEUR (
ID_SOND ASC
);

alter table T_DONNEES
   add constraint FK_T_DONNEE_RECUPERER_T_SONDE foreign key (ID_SOND)
      references T_SONDE (ID_SOND)
      on update restrict
      on delete restrict;

alter table T_UTILISATEUR
   add constraint FK_T_UTILIS_GERER_T_SONDE foreign key (ID_SOND)
      references T_SONDE (ID_SOND)
      on update restrict
      on delete restrict;

