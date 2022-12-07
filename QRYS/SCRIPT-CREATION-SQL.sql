--sql server
USE [master]
GO
CREATE DATABASE [BD_ORIGEN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_ORIGEN', FILENAME = N'C:\SQL2019\DATA\BD_ORIGEN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BD_ORIGEN_log', FILENAME = N'C:\SQL2019\DATA\BD_ORIGEN_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_ORIGEN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

USE [master]
GO
CREATE DATABASE [BD_STAGE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_STAGE', FILENAME = N'C:\SQL2019\DATA\BD_STAGE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BD_STAGE_log', FILENAME = N'C:\SQL2019\DATA\BD_STAGE_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_STAGE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

USE [master]
GO
CREATE DATABASE [BD_MART]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_MART', FILENAME = N'C:\SQL2019\DATA\BD_MART.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BD_MART_log', FILENAME = N'C:\SQL2019\DATA\BD_MART_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_MART].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO



 USE BD_ORIGEN
CREATE TABLE producto_origen
  (
    id INT  NOT NULL ,
    nombre VARCHAR (100) NOT NULL ,
    ancho          DECIMAL (9,2) ,
    alto           DECIMAL (9,2) ,
    profundo       DECIMAL (9,2) ,
    peso           DECIMAL (9,2) ,
    descripcion VARCHAR (750) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
CREATE INDEX producto_origen__IDX ON producto_origen
  (
    nombre ASC
  ) ;
ALTER TABLE producto_origen ADD CONSTRAINT producto_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE producto_origen ADD CONSTRAINT producto_origen_nombre_UN UNIQUE ( nombre ) ;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Valor de ancho del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'ancho'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Valor en altura del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'alto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Valor en profundo del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'profundo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Valor en peso del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'peso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripcion del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus del artículo' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'producto_origen', @level2type=N'COLUMN',@level2name=N'estatus'
GO

CREATE TABLE direccion_origen
  (
    id INT  NOT NULL ,
    calle VARCHAR (250) ,
    numero_exterior VARCHAR (15) ,
    numero_interior VARCHAR (15) ,
    localidad VARCHAR (250) ,
    codigo_postal VARCHAR (15)  ,
    colonia       VARCHAR (100)  ,
    municipio     VARCHAR (50)  ,
    estado        VARCHAR (50)  ,
    pais          VARCHAR (50) ,
    estatus           VARCHAR (15) 
  ) ;
CREATE INDEX direccion_origen__IDX ON direccion_origen
  ( id ASC
  ) ;
ALTER TABLE direccion_origen ADD CONSTRAINT direccion_origen_PK PRIMARY KEY ( id ) ;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Calle de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'calle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número exterior de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'numero_exterior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número interior de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'numero_interior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Localidad de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'localidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código postal de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'codigo_postal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Colonia de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'colonia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Municipio de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'municipio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estado de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'estado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Pais de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'pais'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus de la dirección' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'direccion_origen', @level2type=N'COLUMN',@level2name=N'estatus'
GO



CREATE TABLE empleado_origen
  (
    id INT  NOT NULL ,
    nombre VARCHAR (50) NOT NULL ,
    apellido_paterno VARCHAR (50) NOT NULL ,
    apellido_materno VARCHAR (50) NOT NULL ,
    contrasenia VARCHAR (50) NOT NULL ,
    fecha_nacimiento DATE NOT NULL ,
    nacionalidad VARCHAR (15) NOT NULL ,
    nss VARCHAR (11) ,
    curp VARCHAR (18) NOT NULL ,
    rfc VARCHAR (13) NOT NULL ,
    estado_civil VARCHAR (15) NOT NULL ,
    tipo_sangre VARCHAR (18) ,
    email_corporativo VARCHAR (50) ,
    email_personal VARCHAR (50) ,
    telefono VARCHAR (50) ,
    red_social VARCHAR (25) ,
    fecha_ingreso  DATE NOT NULL ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
CREATE INDEX empleado_origen_IDX ON empleado_origen
  ( 
  id ASC
  ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_nss_UN UNIQUE ( nss ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_curp_UN UNIQUE ( curp ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_rfc_UN UNIQUE ( rfc ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_contrasenia_UN UNIQUE ( contrasenia ) ;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Apellido paterno del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'apellido_paterno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Apellido materno del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'apellido_materno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contraseña del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'contrasenia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de nacimiento del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'fecha_nacimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nacionalidad del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'nacionalidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número de Seguro Social del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'nss'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Curp del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'curp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rfc del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'rfc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estado civil del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'estado_civil'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo sangre del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'tipo_sangre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email corporativo del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'email_corporativo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email personal del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'email_personal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Teléfono del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'telefono'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Red social del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'red_social'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha ingreso del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'fecha_ingreso'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus del Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'empleado_origen', @level2type=N'COLUMN',@level2name=N'estatus'
GO

CREATE TABLE forma_pago_origen
  (
    id INT  NOT NULL ,
    nombre VARCHAR (15) NOT NULL ,
    descripcion VARCHAR (750) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
ALTER TABLE forma_pago_origen ADD CONSTRAINT forma_pago_origen__PK PRIMARY KEY ( id ) ;
ALTER TABLE forma_pago_origen ADD CONSTRAINT forma_pago_origen_nombre_UN UNIQUE ( nombre ) ;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la Forma de Pago' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'forma_pago_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la Forma de Pago' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'forma_pago_origen', @level2type=N'COLUMN',@level2name=N'nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripcion de la Forma de Pago' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'forma_pago_origen', @level2type=N'COLUMN',@level2name=N'descripcion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus de la Forma de Pago' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'forma_pago_origen', @level2type=N'COLUMN',@level2name=N'estatus'
GO

CREATE TABLE cliente_origen
  (
    id INT  NOT NULL ,
    direccion_origen_id INT NOT NULL ,
    rfc VARCHAR (13) ,
    razon_social VARCHAR (150) ,
    nombre_comercial VARCHAR (150),
    estatus VARCHAR (15) NOT NULL
  ) ;
CREATE INDEX cliente_origen__IDX ON cliente_origen
  (
    id ASC
  ) ;
CREATE INDEX cliente_origen_IDX2 ON cliente_origen
  (
    rfc ASC ,
    nombre_comercial ASC ,
    razon_social ASC
  ) ;
ALTER TABLE cliente_origen ADD CONSTRAINT cliente_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE cliente_origen ADD CONSTRAINT cliente_origen__UN UNIQUE ( rfc ) ;
ALTER TABLE cliente_origen ADD CONSTRAINT cliente_origen_direccion_origen_FK FOREIGN KEY ( direccion_origen_id ) REFERENCES direccion_origen ( id ) ON
UPDATE CASCADE 


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'cliente_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la dirección del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'cliente_origen', @level2type=N'COLUMN',@level2name=N'direccion_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rfc del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'cliente_origen', @level2type=N'COLUMN',@level2name=N'rfc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Razon social del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'cliente_origen', @level2type=N'COLUMN',@level2name=N'razon_social'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre comercial del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'cliente_origen', @level2type=N'COLUMN',@level2name=N'nombre_comercial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'cliente_origen', @level2type=N'COLUMN',@level2name=N'estatus'
GO

CREATE TABLE estatus_orden_compra_origen
  (
    id INT  NOT NULL ,
    nombre VARCHAR (25) NOT NULL ,
    estatus       VARCHAR (15) NOT NULL
  ) ;
ALTER TABLE estatus_orden_compra_origen ADD CONSTRAINT estatus_orden_compra_origen_PK PRIMARY KEY ( id ) ;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del Estatus de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'estatus_orden_compra_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del Estatus de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'estatus_orden_compra_origen', @level2type=N'COLUMN',@level2name=N'nombre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus del Estatus de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'estatus_orden_compra_origen', @level2type=N'COLUMN',@level2name=N'estatus'
GO


CREATE TABLE compra_origen
  (
    id INT  NOT NULL ,
    direccion_entrega VARCHAR (750) NOT NULL ,
    codigo_seguridad VARCHAR (20) NOT NULL ,    
    proveedor_origen_id            INT NOT NULL ,
    fecha                   DATE NOT NULL ,
    hora                    TIME NOT NULL ,
    fecha_comprometida      DATE NOT NULL ,
    forma_pago_origen_id           INT NOT NULL ,
    estatus_orden_compra_origen_id INT NOT NULL ,
    subtotal DECIMAL (15,4) NOT NULL ,
    iva DECIMAL (15,4) NOT NULL ,
    total DECIMAL (15,4) NOT NULL ,
    ieps DECIMAL (9,2) NOT NULL 
  ) ;
ALTER TABLE compra_origen ADD CONSTRAINT compra_origen_empleado_origen_PK PRIMARY KEY ( id) ;
ALTER TABLE compra_origen ADD CONSTRAINT compra_origen_codigo_seguridad_UN UNIQUE ( codigo_seguridad ) ;
ALTER TABLE compra_origen ADD CONSTRAINT compra_origena_estatus_orden_compra_origen_FK FOREIGN KEY ( estatus_orden_compra_origen_id ) REFERENCES estatus_orden_compra_origen ( id ) ON
UPDATE CASCADE ;
ALTER TABLE compra_origen ADD CONSTRAINT compra_origena_forma_pago_origen_FK FOREIGN KEY ( forma_pago_origen_id ) REFERENCES forma_pago_origen ( id ) ON
UPDATE CASCADE ;

CREATE INDEX compra_origen__IDX ON compra_origen
  (
    hora ASC ,
    fecha ASC
  ) ;

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Direccion de entrega de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'direccion_entrega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código seguridad de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'codigo_seguridad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Proveedor de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'proveedor_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hora de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha comprometida de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'fecha_comprometida'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Forma de Pago de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'forma_pago_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Estatus de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'estatus_orden_compra_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subtotal de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'subtotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Iva de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'iva'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ieps de Orden de Compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_origen', @level2type=N'COLUMN',@level2name=N'ieps'
GO
  
  CREATE TABLE compra_producto_origen
  (
    id INT  NOT NULL ,
    producto_origen_id          INT ,
    compra_origen_id            INT NOT NULL , 
    cantidad             DECIMAL (9,2) NOT NULL ,
    entrada              DECIMAL (9,2) ,
    no_incluido          DECIMAL (9,2) ,
    subtotal DECIMAL (15,4) NOT NULL ,
    iva DECIMAL (15,4) NOT NULL ,
    total DECIMAL (15,4) ,
    ieps numeric(9,2) 
  ) ;
ALTER TABLE compra_producto_origen ADD CONSTRAINT compra_producto_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE compra_producto_origen ADD CONSTRAINT compra_producto_compra_origen_FK FOREIGN KEY ( compra_origen_id ) REFERENCES compra_origen ( id ) ON
UPDATE CASCADE ;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Producto de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'producto_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Compra en Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'compra_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad de Producto de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad en entrada de Producto de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'entrada'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad no incluida de Producto de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'no_incluido'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subtotal de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'subtotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Iva de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'iva'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ieps de Compra Producto' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'compra_producto_origen', @level2type=N'COLUMN',@level2name=N'ieps'
GO
  

 CREATE TABLE venta_origen
  (
    id INT  NOT NULL ,
    empleado_origen_id      INT NOT NULL ,
    cliente_origen_id       INT ,
    fecha            DATE NOT NULL ,
    hora             TIME NOT NULL ,
    fecha_cerrado            DATE ,
    hora_cerrado             TIME ,
    serie VARCHAR (20) NOT NULL ,
    forma_pago_origen_id INT NOT NULL ,
    cuenta VARCHAR (4) ,
    subtotal      DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    iva           DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    total         DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    facturado     VARCHAR (15) ,
    cancelado     VARCHAR (15) NOT NULL 
  ) ;
CREATE INDEX venta_origen__IDX ON venta_origen
  (
    id ASC
  ) ;

CREATE INDEX venta_origen_IDX ON venta_origen
  (
    fecha ASC ,
    hora ASC
  ) ;


ALTER TABLE venta_origen ADD CONSTRAINT venta_origen_serie_UN UNIQUE ( serie ) ;
ALTER TABLE venta_origen ADD CONSTRAINT venta_origen_PK PRIMARY KEY ( id ) ;

ALTER TABLE venta_origen ADD CONSTRAINT venta_origen_empleado_origen_FK FOREIGN KEY ( empleado_origen_id ) REFERENCES empleado_origen ( id ) ON
UPDATE CASCADE ;
ALTER TABLE venta_origen ADD CONSTRAINT venta_origen_cliente_origen_FK FOREIGN KEY ( cliente_origen_id ) REFERENCES cliente_origen ( id ) ON
UPDATE CASCADE ;
ALTER TABLE venta_origen ADD CONSTRAINT venta_origen_forma_pago_origen_FK FOREIGN KEY ( forma_pago_origen_id ) REFERENCES forma_pago_origen ( id ) ON
UPDATE CASCADE ;

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de Venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del empleado_origen' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'empleado_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del cliente quien realizó la compra' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'cliente_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hora de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que se cerró la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'fecha_cerrado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hora en que se cerró la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'hora_cerrado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Serie de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'serie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la forma de pago en la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'forma_pago_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Últmos 4 dígitos de la cuenta de pago en la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'cuenta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subtotal de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'subtotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Iva de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'iva'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus de factura en la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'facturado'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus de canleado en la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_origen', @level2type=N'COLUMN',@level2name=N'cancelado'
GO

CREATE TABLE venta_producto_origen
  (
    id INT  NOT NULL ,
    venta_origen_id    INT NOT NULL ,
    producto_origen_id INT NOT NULL ,
    fecha            DATE NOT NULL ,
    hora             TIME NOT NULL ,
    cantidad    DECIMAL (9,2) DEFAULT 1 NOT NULL ,
    precio_unitario DECIMAL (11,4) NOT NULL ,
    subtotal DECIMAL (11,4) NOT NULL ,
    iva DECIMAL (11,4) NOT NULL ,
    total DECIMAL (11,4) NOT NULL ,
    cancelado    VARCHAR (15) NOT NULL 
  ) ;
  
  CREATE INDEX venta_producto__IDX1 ON venta_producto_origen
  (
    id ASC
  ) ;

CREATE INDEX venta_producto_IDX2 ON venta_producto_origen
  (
    fecha ASC ,
    hora ASC 
  ) ;
ALTER TABLE venta_producto_origen ADD CONSTRAINT venta_producto__PK PRIMARY KEY ( id   ) ;
ALTER TABLE venta_producto_origen ADD CONSTRAINT venta_producto_origen_venta_origen_FK FOREIGN KEY ( venta_origen_id ) REFERENCES venta_origen ( id ) ON
UPDATE CASCADE ;
ALTER TABLE venta_producto_origen ADD CONSTRAINT venta_producto_origen_producto_origen_FK FOREIGN KEY ( producto_origen_id ) REFERENCES producto_origen ( id ) ON
UPDATE CASCADE ;

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'venta_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del producto en el detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'producto_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hora del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'cantidad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Precio unitario del producto del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'precio_unitario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subtotal del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'subtotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Iva del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'iva'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estatus de canleado del detalle de la venta' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'venta_producto_origen', @level2type=N'COLUMN',@level2name=N'cancelado'
GO

CREATE TABLE produccion_origen
  (
    id INT  NOT NULL ,
    producto_origen_id        INTEGER NOT NULL ,
    empleado_origen_id        INTEGER NOT NULL ,
    fecha              DATE NOT NULL ,
    hora               TIME NOT NULL ,
    cantidad_producida DECIMAL (9,2) NOT NULL
  ) ;
CREATE INDEX produccion_origen__IDX ON produccion_origen
  (
    id ASC
  ) ;
ALTER TABLE produccion_origen ADD CONSTRAINT produccion_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE produccion_origen ADD CONSTRAINT produccion_origen_produccion_origen_FK FOREIGN KEY ( producto_origen_id ) REFERENCES producto_origen ( id ) ON
UPDATE CASCADE ;
ALTER TABLE produccion_origen ADD CONSTRAINT produccion_origen_empleado_origen_FK FOREIGN KEY ( empleado_origen_id ) REFERENCES empleado_origen ( id ) ON
UPDATE CASCADE ;

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id de la producción' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'produccion_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del producto producido' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'produccion_origen', @level2type=N'COLUMN',@level2name=N'producto_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del empleado quien realizó la producción' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'produccion_origen', @level2type=N'COLUMN',@level2name=N'empleado_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de la producción' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'produccion_origen', @level2type=N'COLUMN',@level2name=N'fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hora de la producción' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'produccion_origen', @level2type=N'COLUMN',@level2name=N'hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad de mercancía producida' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'produccion_origen', @level2type=N'COLUMN',@level2name=N'cantidad_producida'
GO

CREATE TABLE movimiento_caja_origen
  (
    id INT  NOT NULL ,
    empleado_origen_id        INTEGER NOT NULL ,
    fecha              DATE NOT NULL ,
    hora               TIME NOT NULL, 
    tipo_movimiento VARCHAR (25) NOT NULL ,
    monto DECIMAL (9,2) NOT NULL   ,
    observaciones  VARCHAR (750)     
  ) ;
CREATE INDEX movimiento_caja_origenn__IDX ON movimiento_caja_origen
  (
    id ASC
  ) ;
ALTER TABLE movimiento_caja_origen ADD CONSTRAINT movimiento_caja_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE movimiento_caja_origen ADD CONSTRAINT movimiento_caja_origen_empleado_origen_FK FOREIGN KEY ( empleado_origen_id ) REFERENCES empleado_origen ( id ) ON
UPDATE CASCADE ;

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id del empleado quien realizó el movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'empleado_origen_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha del movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hora del movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'hora'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo del movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'tipo_movimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto total del movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'monto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Observaciones del movimiento de caja' , @level0type=N'SCHEMA',@level0name=N'dbo',
 @level1type=N'TABLE',@level1name=N'movimiento_caja_origen', @level2type=N'COLUMN',@level2name=N'observaciones'
GO

 USE BD_STAGE 
CREATE TABLE producto_stage
  (
    id INT NOT NULL ,
    nombre VARCHAR (100) NOT NULL ,
    ancho          DECIMAL (9,2) ,
    alto           DECIMAL (9,2) ,
    profundo       DECIMAL (9,2) ,
    peso           DECIMAL (9,2) ,
    descripcion VARCHAR (750) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
CREATE INDEX producto_stage__IDX ON producto_stage
  (
    nombre ASC
  ) ;
ALTER TABLE producto_stage ADD CONSTRAINT producto_stage_PK PRIMARY KEY ( id ) ;
ALTER TABLE producto_stage ADD CONSTRAINT producto_stage_nombre_UN UNIQUE ( nombre ) ;

CREATE TABLE direccion_stage
  (
    id INT NOT NULL ,
    calle VARCHAR (250) ,
    numero_exterior VARCHAR (15) ,
    numero_interior VARCHAR (15) ,
    localidad VARCHAR (250) ,
    codigo_postal VARCHAR (15)  ,
    colonia       VARCHAR (100)  ,
    municipio     VARCHAR (50)  ,
    estado        VARCHAR (50)  ,
    pais          VARCHAR (50) ,
    estatus           VARCHAR (15)  ,
    status           VARCHAR (1) 
  ) ;
CREATE INDEX direccion_stage__IDX ON direccion_stage
  ( id ASC
  ) ;
ALTER TABLE direccion_stage ADD CONSTRAINT direccion_stage_PK PRIMARY KEY ( id ) ;


CREATE TABLE empleado_stage
  (
    id INT NOT NULL ,
    nombre VARCHAR (50) NOT NULL ,
    apellido_paterno VARCHAR (50) NOT NULL ,
    apellido_materno VARCHAR (50) NOT NULL ,
    contrasenia VARCHAR (50) NOT NULL ,
    fecha_nacimiento DATE NOT NULL ,
    nacionalidad VARCHAR (15) NOT NULL ,
    nss VARCHAR (11) ,
    curp VARCHAR (18) NOT NULL ,
    rfc VARCHAR (13) NOT NULL ,
    estado_civil VARCHAR (15) NOT NULL ,
    tipo_sangre VARCHAR (18) ,
    email_corporativo VARCHAR (50) ,
    email_personal VARCHAR (50) ,
    telefono VARCHAR (50) ,
    red_social VARCHAR (25) ,
    fecha_ingreso  DATE NOT NULL ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
CREATE INDEX empleado_stage_IDX ON empleado_stage
  ( 
  id ASC
  ) ;
ALTER TABLE empleado_stage ADD CONSTRAINT empleado_stage_PK PRIMARY KEY ( id ) ;
ALTER TABLE empleado_stage ADD CONSTRAINT empleado_stage_nss_UN UNIQUE ( nss ) ;
ALTER TABLE empleado_stage ADD CONSTRAINT empleado_stage_curp_UN UNIQUE ( curp ) ;
ALTER TABLE empleado_stage ADD CONSTRAINT empleado_stage_rfc_UN UNIQUE ( rfc ) ;
ALTER TABLE empleado_stage ADD CONSTRAINT empleado_stage_contrasenia_UN UNIQUE ( contrasenia ) ;

CREATE TABLE forma_pago_stage
  (
    id INT NOT NULL ,
    nombre VARCHAR (15) NOT NULL ,
    descripcion VARCHAR (750) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
ALTER TABLE forma_pago_stage ADD CONSTRAINT forma_pago_stage__PK PRIMARY KEY ( id ) ;
ALTER TABLE forma_pago_stage ADD CONSTRAINT forma_pago_stage_nombre_UN UNIQUE ( nombre ) ;

CREATE TABLE cliente_stage1
  (
    id INT NOT NULL ,
    direccion_stage_id INT NOT NULL , 
    rfc VARCHAR (13) ,
    razon_social VARCHAR (150) ,
    nombre_comercial VARCHAR (150),
    estatus VARCHAR (15) NOT NULL
  ) ;
CREATE INDEX cliente_stage1__IDX ON cliente_stage1
  (
    id ASC
  ) ;
CREATE INDEX cliente_stage1_IDX2 ON cliente_stage1
  (
    rfc ASC ,
    nombre_comercial ASC ,
    razon_social ASC
  ) ;
ALTER TABLE cliente_stage1 ADD CONSTRAINT cliente_stage1_PK PRIMARY KEY ( id ) ;
ALTER TABLE cliente_stage1 ADD CONSTRAINT cliente_stage1__UN UNIQUE ( rfc ) ;
ALTER TABLE cliente_stage1 ADD CONSTRAINT cliente_stage1_direccion_stage_FK FOREIGN KEY ( direccion_stage_id ) REFERENCES direccion_stage ( id ) ON
UPDATE CASCADE ;


CREATE TABLE cliente_stage
  (
    id INT NOT NULL ,
    direccion_stage_id INT NOT NULL , 
    rfc VARCHAR (13) ,
    razon_social VARCHAR (150) ,
    nombre_comercial VARCHAR (150),
    estatus VARCHAR (15) NOT NULL,
    email VARCHAR(150),
    telefono VARCHAR(50)
  ) ;
CREATE INDEX cliente_stage__IDX ON cliente_stage
  (
    id ASC
  ) ;
CREATE INDEX cliente_stage_IDX2 ON cliente_stage
  (
    rfc ASC ,
    nombre_comercial ASC ,
    razon_social ASC
  ) ;
ALTER TABLE cliente_stage ADD CONSTRAINT cliente_stage_PK PRIMARY KEY ( id ) ;
ALTER TABLE cliente_stage ADD CONSTRAINT cliente_stage__UN UNIQUE ( rfc ) ;
ALTER TABLE cliente_stage ADD CONSTRAINT cliente_stage_direccion_stage_FK FOREIGN KEY ( direccion_stage_id ) REFERENCES direccion_stage ( id ) ON
UPDATE CASCADE ;


CREATE TABLE cliente_detalle_stage
  (
    id INT NOT NULL ,
    cliente_stage_id INT NOT NULL , 
    total_hijos INT ,
    fecha_nacimiento DATE ,
    educacion VARCHAR (40),
    ocupacion VARCHAR (100) NOT NULL,
    genero VARCHAR(1)
  ) ;
CREATE INDEX cliente_detalle_stage__IDX ON cliente_detalle_stage
  (
    id ASC
  ) ;
ALTER TABLE cliente_detalle_stage ADD CONSTRAINT cliente_detalle_stage_PK PRIMARY KEY ( id ) ;
ALTER TABLE cliente_detalle_stage ADD CONSTRAINT cliente_detalle_stage_cliente_stage_FK FOREIGN KEY ( cliente_stage_id ) REFERENCES cliente_stage ( id ) ON
UPDATE CASCADE ;

CREATE TABLE proveedor_stage
  (
    id INT NOT NULL ,
    rfc VARCHAR (13) NOT NULL ,
    razon_social VARCHAR (50) NOT NULL ,
    nombre_comercial VARCHAR (50) NOT NULL ,
    email VARCHAR (50) ,
    telefono_1 VARCHAR (50) ,
    telefono_2 VARCHAR (50) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
CREATE UNIQUE INDEX proveedor_stage_IDX ON proveedor_stage
  (
    nombre_comercial ASC
  )
  ;
ALTER TABLE proveedor_stage ADD CONSTRAINT proveedor_stage_PK PRIMARY KEY ( id ) ;
ALTER TABLE proveedor_stage ADD CONSTRAINT proveedor_stage_rfc_UN UNIQUE ( rfc ) ;
ALTER TABLE proveedor_stage ADD CONSTRAINT proveedor_stage_razon_social_UN UNIQUE ( razon_social ) ;

CREATE TABLE estatus_orden_compra_stage
  (
    id INT NOT NULL ,
    nombre VARCHAR (25) NOT NULL ,
    estatus       VARCHAR (15) NOT NULL
  ) ;
ALTER TABLE estatus_orden_compra_stage ADD CONSTRAINT estatus_orden_compra_stage_PK PRIMARY KEY ( id ) ;


CREATE TABLE compra_stage
  (
    id INT NOT NULL ,
    direccion_entrega VARCHAR (750) NOT NULL ,
    codigo_seguridad VARCHAR (20) NOT NULL ,    
    proveedor_stage_id            INT NOT NULL ,
    fecha                   DATE NOT NULL ,
    hora                    TIME NOT NULL ,
    fecha_comprometida      DATE NOT NULL ,
    forma_pago_stage_id           INT NOT NULL ,
    estatus_orden_compra_stage_id INT NOT NULL ,
    subtotal DECIMAL (15,4) NOT NULL ,
    iva DECIMAL (15,4) NOT NULL ,
    total DECIMAL (15,4) NOT NULL ,
    ieps DECIMAL (9,2) NOT NULL 
  ) ;
ALTER TABLE compra_stage ADD CONSTRAINT compra_stage_empleado_stage_PK PRIMARY KEY ( id) ;
ALTER TABLE compra_stage ADD CONSTRAINT compra_stage_codigo_seguridad_UN UNIQUE ( codigo_seguridad ) ;
ALTER TABLE compra_stage ADD CONSTRAINT compr_stagea_estatus_orden_compra_stage_FK FOREIGN KEY ( estatus_orden_compra_stage_id ) REFERENCES estatus_orden_compra_stage ( id ) ON
UPDATE CASCADE ;

CREATE INDEX compra_stage__IDX ON compra_stage
  (
    hora ASC ,
    fecha ASC
  ) ;
  
  CREATE TABLE compra_producto_stage
  (
    id INT NOT NULL ,
    producto_stage_id          INT ,
    compra_stage_id            INT NOT NULL , 
    cantidad             DECIMAL (9,2) NOT NULL ,
    entrada              DECIMAL (9,2) ,
    no_incluido          DECIMAL (9,2) ,
    subtotal DECIMAL (15,4) NOT NULL ,
    iva DECIMAL (15,4) NOT NULL ,
    total DECIMAL (15,4) ,
    ieps numeric(9,2) 
  ) ;
ALTER TABLE compra_producto_stage ADD CONSTRAINT compra_producto_stage_PK PRIMARY KEY ( id ) ;
ALTER TABLE compra_producto_stage ADD CONSTRAINT compra_producto_compra_stage_FK FOREIGN KEY ( compra_stage_id ) REFERENCES compra_stage ( id ) ON
UPDATE CASCADE ;

  

 CREATE TABLE venta_stage
  (
    id               INT NOT NULL ,
    empleado_stage_id      INT NOT NULL ,
    cliente_stage_id       INT ,
    fecha            DATE NOT NULL ,
    hora             TIME NOT NULL ,
    fecha_cerrado            DATE ,
    hora_cerrado             TIME ,
    serie VARCHAR (20) NOT NULL ,
    forma_pago_id INT NOT NULL ,
    cuenta VARCHAR (4) ,
    subtotal      DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    iva           DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    total         DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    facturado     VARCHAR (15) ,
    cancelado     VARCHAR (15) NOT NULL 
  ) ;
CREATE INDEX venta_stage__IDX ON venta_stage
  (
    id ASC
  ) ;

CREATE INDEX venta_stage_IDX ON venta_stage
  (
    fecha ASC ,
    hora ASC
  ) ;


ALTER TABLE venta_stage ADD CONSTRAINT venta_stage_serie_UN UNIQUE ( serie ) ;
ALTER TABLE venta_stage ADD CONSTRAINT venta_stage_PK PRIMARY KEY ( id ) ;

ALTER TABLE venta_stage ADD CONSTRAINT venta_stage_empleado_stage_FK FOREIGN KEY ( empleado_stage_id ) REFERENCES empleado_stage ( id ) ON
UPDATE CASCADE ;
ALTER TABLE venta_stage ADD CONSTRAINT venta_stage_cliente_stage_FK FOREIGN KEY ( cliente_stage_id ) REFERENCES cliente_stage ( id ) ON
UPDATE CASCADE ;

CREATE TABLE venta_producto_stage
  (
    id INT NOT NULL ,
    venta_stage_id    INT NOT NULL ,
    producto_stage_id INT NOT NULL ,
    fecha            DATE NOT NULL ,
    hora             TIME NOT NULL ,
    cantidad    DECIMAL (9,2) DEFAULT 1 NOT NULL ,
    precio_unitario DECIMAL (11,4) NOT NULL ,
    subtotal DECIMAL (11,4) NOT NULL ,
    iva DECIMAL (11,4) NOT NULL ,
    total DECIMAL (11,4) NOT NULL ,
    cancelado    VARCHAR (15) NOT NULL 
  ) ;
  
  CREATE INDEX venta_producto__IDX1 ON venta_producto_stage
  (
    id ASC
  ) ;

CREATE INDEX venta_producto_IDX2 ON venta_producto_stage
  (
    fecha ASC ,
    hora ASC 
  ) ;
ALTER TABLE venta_producto_stage ADD CONSTRAINT venta_producto__PK PRIMARY KEY ( id   ) ;
ALTER TABLE venta_producto_stage ADD CONSTRAINT venta_producto_stage_venta_stage_FK FOREIGN KEY ( venta_stage_id ) REFERENCES venta_stage ( id ) ON
UPDATE CASCADE ;
ALTER TABLE venta_producto_stage ADD CONSTRAINT venta_producto_stage_producto_stage_FK FOREIGN KEY ( producto_stage_id ) REFERENCES producto_stage ( id ) ON
UPDATE CASCADE ;

CREATE TABLE produccion_stage
  (
    id INT NOT NULL ,
    producto_stage_id        INTEGER NOT NULL ,
    empleado_stage_id        INTEGER NOT NULL ,
    fecha              DATE NOT NULL ,
    hora               TIME NOT NULL ,
    cantidad_producida DECIMAL (9,2) NOT NULL
  ) ;
CREATE INDEX produccion_stage__IDX ON produccion_stage
  (
    id ASC
  ) ;
ALTER TABLE produccion_stage ADD CONSTRAINT produccion_stage_PK PRIMARY KEY ( id ) ;

CREATE TABLE movimiento_caja_stage
  (
    id INT NOT NULL ,
    empleado_stage_id        INTEGER NOT NULL ,
    fecha              DATE NOT NULL ,
    hora               TIME NOT NULL, 
    tipo_movimiento VARCHAR (25) NOT NULL ,
    monto DECIMAL (9,2) NOT NULL   ,
    observaciones  VARCHAR (750)     
  ) ;
CREATE INDEX movimiento_caja_stagen__IDX ON movimiento_caja_stage
  (
    id ASC
  ) ;
ALTER TABLE movimiento_caja_stage ADD CONSTRAINT movimiento_caja_stage_PK PRIMARY KEY ( id ) ;


 USE BD_MART
CREATE TABLE producto_dim
  (
    producto_key INT IDENTITY(1,1) NOT NULL ,
    producto_id INT NOT NULL ,
    producto_nombre VARCHAR (100) NOT NULL ,
    producto_descripcion VARCHAR (750)
  ) ;
ALTER TABLE producto_dim ADD CONSTRAINT producto_dim_PK PRIMARY KEY ( producto_key ) ;

CREATE TABLE direccion_dim
  (
    direccion_key INT IDENTITY(1,1) NOT NULL ,
    direccion_id INT NOT NULL ,
    direccion_calle VARCHAR (250), 
    direccion_codigo_postal VARCHAR (15)  ,
    direccion_municipio     VARCHAR (50)  ,
    direccion_estado        VARCHAR (50)  ,
    direccion_pais          VARCHAR (50) 
  ) ;
ALTER TABLE direccion_dim ADD CONSTRAINT direccion_dim_PK PRIMARY KEY ( direccion_key ) ;


CREATE TABLE empleado_dim
  (
    empleado_key INT IDENTITY(1,1) NOT NULL ,
    empleado_id INT NOT NULL ,
    empleado_nombre VARCHAR (50) NOT NULL ,
    empleado_nombre_completo VARCHAR (200) NOT NULL ,
    empleado_apellido_paterno VARCHAR (50) NOT NULL ,
    empleado_apellido_materno VARCHAR (50) NOT NULL ,
    empleado_nacionalidad VARCHAR (15) NOT NULL ,
    empleado_estado_civil VARCHAR (15) NOT NULL ,
    empleado_fecha_ingreso  DATE NOT NULL
  ) ;
ALTER TABLE empleado_dim ADD CONSTRAINT empleado_dim_PK PRIMARY KEY ( empleado_key ) ;

CREATE TABLE proveedor_dim
  (
    proveedor_key INT IDENTITY(1,1) NOT NULL ,
    proveedor_id INT NOT NULL ,
    proveedor_rfc VARCHAR (13) NOT NULL ,
    proveedor_razon_social VARCHAR (50) NOT NULL ,
    proveedor_nombre_comercial VARCHAR (50) NOT NULL ,
    proveedor_email VARCHAR (50) ,
    proveedor_telefono_1 VARCHAR (50)
  ) ;
ALTER TABLE proveedor_dim ADD CONSTRAINT proveedor_dime_PK PRIMARY KEY ( proveedor_key ) ;

CREATE TABLE forma_pago_dim
  (
    forma_pago_key INT IDENTITY(1,1) NOT NULL ,
    forma_pago_id INT NOT NULL ,
    forma_pago_nombre VARCHAR (15) NOT NULL ,
    forma_pago_descripcion VARCHAR (750)
  ) ;
ALTER TABLE forma_pago_dim ADD CONSTRAINT forma_pago_dim__PK PRIMARY KEY ( forma_pago_key ) ;


CREATE TABLE cliente_dim
  (
    cliente_key INT IDENTITY(1,1) NOT NULL ,
    cliente_id INT NOT NULL ,
    direccion_key INT NOT NULL , 
    direccion_id INT NOT NULL , 
    cliente_rfc VARCHAR (13) ,
    cliente_razon_social VARCHAR (150) 
  ) ;
ALTER TABLE cliente_dim ADD CONSTRAINT cliente_dim_PK PRIMARY KEY ( cliente_key ) ;
ALTER TABLE cliente_dim ADD CONSTRAINT cliente_dim_direccion_dim_FK FOREIGN KEY ( direccion_key ) REFERENCES direccion_dim ( direccion_key ) ON
UPDATE CASCADE ;

CREATE TABLE cliente_detalle_dim
  (
    cliente_detalle_key INT IDENTITY(1,1) NOT NULL ,
    cliente_detalle_id INT NOT NULL ,
    cliente_key       INT ,
    cliente_id       INT ,
    total_hijos INT ,
    fecha_nacimiento DATE ,
    educacion VARCHAR (40),
    ocupacion VARCHAR (100) NOT NULL,
    genero VARCHAR(1)
  ) ;
ALTER TABLE cliente_detalle_dim ADD CONSTRAINT cliente_detalle_dim_PK PRIMARY KEY ( cliente_detalle_key ) ;
ALTER TABLE cliente_detalle_dim ADD CONSTRAINT cliente_detalle_dim_cliente_dim_FK FOREIGN KEY ( cliente_key ) REFERENCES cliente_dim ( cliente_key ) ON
UPDATE CASCADE ;

 CREATE TABLE venta
  (
    venta_key               INT IDENTITY(1,1) NOT NULL ,
    venta_id               INT NOT NULL ,
    empleado_key      INT NOT NULL ,
    empleado_id      INT NOT NULL ,
    cliente_key       INT ,
    cliente_id       INT ,
    fecha_key INT NOT NULL ,
    producto_key INT NOT NULL ,
    producto_id INT NOT NULL ,
    venta_fecha            DATE NOT NULL ,
    venta_hora             TIME NOT NULL ,
    venta_serie VARCHAR (20) NOT NULL ,
    forma_pago_key INT NOT NULL ,
    forma_pago_id INT NOT NULL ,
    venta_producto_cantidad    DECIMAL (9,2) DEFAULT 1 NOT NULL ,
    venta_producto_precio_unitario DECIMAL (11,4) NOT NULL ,
    cuenta VARCHAR (4) ,
    subtotal      DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    iva           DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    total         DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    facturado     VARCHAR (15) ,
    cancelado     VARCHAR (15) NOT NULL 
  ) ;
ALTER TABLE venta ADD CONSTRAINT venta_PK PRIMARY KEY ( venta_key ) ;

ALTER TABLE venta ADD CONSTRAINT venta_empleado_dim_FK FOREIGN KEY ( empleado_key ) REFERENCES empleado_dim ( empleado_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_cliente_dim_FK FOREIGN KEY ( cliente_key ) REFERENCES cliente_dim ( cliente_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_forma_pago_dim_FK FOREIGN KEY ( forma_pago_key ) REFERENCES forma_pago_dim ( forma_pago_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_fecha_dim_FK FOREIGN KEY ( fecha_key ) REFERENCES DIM_FECHA ( Fecha_KEY ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_producto_dim_FK FOREIGN KEY ( producto_key ) REFERENCES producto_dim ( producto_key ) ON
UPDATE CASCADE ;


CREATE TABLE produccion
  (
    produccion_key INT IDENTITY(1,1)  NOT NULL ,
    produccion_id INT  NOT NULL ,
    producto_key        INTEGER NOT NULL ,
    producto_id       INTEGER NOT NULL ,
    empleado_key        INTEGER NOT NULL ,
    empleado_id        INTEGER NOT NULL ,
    fecha_key INT NOT NULL ,
    produccion_fecha              DATE NOT NULL ,
    produccion_hora               TIME NOT NULL ,
    produccion_cantidad_producida DECIMAL (9,2) NOT NULL
  ) ;
ALTER TABLE produccion ADD CONSTRAINT produccion_PK PRIMARY KEY ( produccion_key ) ;
ALTER TABLE produccion ADD CONSTRAINT produccion_produccion_dim_FK FOREIGN KEY ( producto_key ) REFERENCES producto_dim ( producto_key ) ON
UPDATE CASCADE ;
ALTER TABLE produccion ADD CONSTRAINT produccion_empleado_dim_FK FOREIGN KEY ( empleado_key ) REFERENCES empleado_dim ( empleado_key ) ON
UPDATE CASCADE ;
ALTER TABLE produccion ADD CONSTRAINT produccion_fecha_dim_FK FOREIGN KEY ( fecha_key ) REFERENCES DIM_FECHA ( Fecha_KEY ) ON
UPDATE CASCADE ;

CREATE TABLE compra
  (
    compra_key INT IDENTITY(1,1) NOT NULL ,
    compra_id INT NOT NULL ,
    producto_key          INT ,
    producto_id          INT ,
    compra_producto_cantidad             DECIMAL (9,2) NOT NULL ,
    compra_producto_entrada              DECIMAL (9,2) ,
    compra_producto_no_incluido          DECIMAL (9,2) ,
    compra_direccion_entrega VARCHAR (750) NOT NULL ,
    compra_codigo_seguridad VARCHAR (20) NOT NULL ,    
    proveedor_key            INT NOT NULL ,   
    proveedor_id            INT NOT NULL ,
    compra_fecha                   DATE NOT NULL ,
    compra_hora                    TIME NOT NULL ,
    forma_pago_key           INT NOT NULL ,
    forma_pago_id           INT NOT NULL ,
    fecha_key INT NOT NULL ,
    compra_estatus INT NOT NULL ,
    compra_subtotal DECIMAL (15,4) NOT NULL ,
    compra_iva DECIMAL (15,4) NOT NULL ,
    compra_total DECIMAL (15,4) NOT NULL 
  ) ;
ALTER TABLE compra ADD CONSTRAINT compra_PK PRIMARY KEY ( compra_key) ;
ALTER TABLE compra ADD CONSTRAINT compra_proveedor_dim_FK FOREIGN KEY ( proveedor_key ) REFERENCES proveedor_dim ( proveedor_key ) ON
UPDATE CASCADE ;
ALTER TABLE compra ADD CONSTRAINT compra_fecha_dim_FK FOREIGN KEY ( fecha_key ) REFERENCES DIM_FECHA ( Fecha_KEY ) ON
UPDATE CASCADE ;
ALTER TABLE compra ADD CONSTRAINT compra_producto_dim_FK FOREIGN KEY ( producto_key ) REFERENCES producto_dim ( producto_key ) ON
UPDATE CASCADE ;
  


--Configuración Inicial

SET DATEFORMAT dmy
SET DATEFIRST 1
SET LANGUAGE SPANISH 

/*Base de datos destino*/
use BD_MART
GO

/*Creación de la tabla*/
create table DIM_FECHA
(
    Fecha_KEY int not null,
    Fecha date not null, 
    Anio smallint not null,
    Trimestre smallint not null,
    Mes smallint not null,
    Semana smallint not null,
    Dia smallint not null,
    DiaSemana smallint not null,
    NTrimestre char(7) not null,
    NMes char(15) not null,
    NMes3L char(3) not null,
    NSemana char(10) not null,
    NDia char(6) not null,
    NDiaSemana char(10) not null,
	DiaAnio smallint not null,
	Semestre tinyint not null
    constraint PK_DIM_FECHA PRIMARY KEY CLUSTERED
    (
        Fecha_KEY asc
    )
)

/*Script de carga*/
DECLARE @FechaDesde as smalldatetime, @FechaHasta as smalldatetime
DECLARE @FechaAAAAMMDD int
DECLARE @Anio as smallint, @Trimestre char(2), @Mes smallint
DECLARE @Semana smallint, @Dia smallint, @DiaSemana smallint
DECLARE @NTrimestre char(7), @NMes char(15)
DECLARE @NMes3l char(3)
DECLARE @NSemana char(10), @NDia char(6), @NDiaSemana char(10)
DECLARE @DiaAnio as smallint
DECLARE @Semestre as tinyint


BEGIN TRANSACTION
    --Borrar datos actuales
    --TRUNCATE TABLE DIM_FECHA
   
    --Rango de fechas a generar: del 01/01/2018 al 31 de dic de dos años siguientes a la fecha actual

    SELECT @FechaDesde = CAST('20180101' AS smalldatetime)
    SELECT @FechaHasta = CAST(CAST(YEAR(GETDATE())+2 AS CHAR(4)) + '1231' AS smalldatetime)
   
    WHILE (@FechaDesde <= @FechaHasta) BEGIN
		SELECT @FechaAAAAMMDD = YEAR(@FechaDesde)*10000+
								MONTH(@FechaDesde)*100+
								DATEPART(dd, @FechaDesde)
		SELECT @Anio = DATEPART(yy, @FechaDesde)                   -- 2017
		SELECT @Trimestre = DATEPART(qq, @FechaDesde)              -- 1
		SELECT @Mes = DATEPART(m, @FechaDesde)                     -- 1
		SELECT @Semana = DATEPART(wk, @FechaDesde)                 -- 1
		SELECT @Dia = RIGHT('0' + DATEPART(dd, @FechaDesde),2)    
		SELECT @DiaSemana = DATEPART(DW, @FechaDesde)
		SELECT @NMes = DATENAME(mm, @FechaDesde)                   -- Enero
		SELECT @NMes3l = LEFT(@NMes, 3)                            -- Ene
		SELECT @NTrimestre = 'T' + CAST(@Trimestre as CHAR(1)) + '/' + RIGHT(@Anio, 2)  -- T1/07
		SELECT @NSemana = 'Sem ' +CAST(@Semana AS CHAR(2)) + '/' + RIGHT(RTRIM(CAST(@Anio as CHAR(4))),2)    
		SELECT @NDia = CAST(@Dia as CHAR(2)) + ' ' + RTRIM(@NMes)                       -- 1 Enero
		SELECT @NDiaSemana = DATENAME(dw, @FechaDesde)                                  -- Lunes
		SELECT @DiaAnio = DATEPART(dy,@FechaDesde)
		SELECT @Semestre = ((DATEPART(month,@FechaDesde)-1)/6)+1
		INSERT INTO BD_MART.dbo.DIM_FECHA
		(
			Fecha_Key,
			Fecha,
			Anio,
			Trimestre,
			Mes,
			Semana,
			Dia,
			DiaSemana,
			NTrimestre,
			NMes,
			NMes3L,
			NSemana,
			NDia,
			NDiaSemana,
			DiaAnio,
			Semestre
		) VALUES
		(
			@FechaAAAAMMDD,
			@FechaDesde,
			@Anio,
			@Trimestre,
			@Mes,
			@Semana,
			@Dia,
			@DiaSemana,
			@NTrimestre,
			@NMes,
			@NMes3l,
			@NSemana,
			@NDia,
			@NDiaSemana,
			@DiaAnio,
			@Semestre
		)
   
		--Incremento del ciclo
		SELECT @FechaDesde = DATEADD(DAY, 1, @FechaDesde)
    END
    COMMIT 



    
-- vTargetMail supports targeted mailing data model
-- Uses vDMPrep to determine if a customer buys a bike and joins to DimCustomer
CREATE VIEW [dbo].[vClientDetVenta] 
AS
    SELECT
        c.cliente_key, c.cliente_rfc,c.cliente_razon_social, d.direccion_calle, d.direccion_codigo_postal, d.direccion_municipio, d.direccion_estado, d.direccion_pais,
        CASE (select COUNT(venta_key) 
        from venta where cliente_key = c.cliente_key) 
            WHEN 0 THEN 0 
            ELSE 1 
        END AS Comprador, cd.total_hijos, cd.fecha_nacimiento, cd.educacion, cd.ocupacion, cd.genero
    FROM
        cliente_dim c 
        inner join direccion_dim as d
        on d.direccion_key = c.direccion_key
        inner join cliente_detalle_dim as cd
        on cd.cliente_key = c.cliente_key
         GROUP BY
            c.cliente_key, c.cliente_rfc, c.cliente_razon_social, d.direccion_calle, 
            d.direccion_codigo_postal, d.direccion_municipio, d.direccion_estado, d.direccion_pais,
            cd.total_hijos, cd.fecha_nacimiento, cd.educacion, cd.ocupacion, cd.genero
;

GO