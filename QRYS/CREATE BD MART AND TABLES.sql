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
---------------------------------------------------------------

--Configuración Inicial

SET DATEFORMAT dmy
SET DATEFIRST 1
SET LANGUAGE SPANISH 

--/Base de datos destino/
use BD_MART
GO

--/Creación de la tabla/
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

--/Script de carga/
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

--------------------------------------------------------------
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
    proveedor_key INT NOT NULL ,
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
    direccion_dim_key INT NOT NULL , 
    cliente_rfc VARCHAR (13) ,
    cliente_razon_social VARCHAR (150) 
  ) ;
ALTER TABLE cliente_dim ADD CONSTRAINT cliente_dim_PK PRIMARY KEY ( cliente_key ) ;
ALTER TABLE cliente_dim ADD CONSTRAINT cliente_dim_direccion_dim_FK FOREIGN KEY ( direccion_dim_key ) REFERENCES direccion_dim ( direccion_key ) ON
UPDATE CASCADE ;


 CREATE TABLE venta
  (
    venta_key               INT IDENTITY(1,1) NOT NULL ,
    venta_id               INT NOT NULL ,
    empleado_dim_key      INT NOT NULL ,
    cliente_dim_key       INT ,
    fecha_dim_key INT NOT NULL ,
    venta_fecha            DATE NOT NULL ,
    venta_hora             TIME NOT NULL ,
    venta_serie VARCHAR (20) NOT NULL ,
    forma_pago_dim_key INT NOT NULL ,
    cuenta VARCHAR (4) ,
    subtotal      DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    iva           DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    total         DECIMAL (11,4) DEFAULT 0 NOT NULL ,
    facturado     VARCHAR (15) ,
    cancelado     VARCHAR (15) NOT NULL 
  ) ;
ALTER TABLE venta ADD CONSTRAINT venta_PK PRIMARY KEY ( venta_key ) ;

ALTER TABLE venta ADD CONSTRAINT venta_empleado_dim_FK FOREIGN KEY ( empleado_dim_key ) REFERENCES empleado_dim ( empleado_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_cliente_dim_FK FOREIGN KEY ( cliente_dim_key ) REFERENCES cliente_dim ( cliente_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_forma_pago_dim_FK FOREIGN KEY ( forma_pago_dim_key ) REFERENCES forma_pago_dim ( forma_pago_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta ADD CONSTRAINT venta_fecha_dim_FK FOREIGN KEY ( fecha_dim_key ) REFERENCES DIM_FECHA ( Fecha_KEY ) ON
UPDATE CASCADE ;

CREATE TABLE venta_producto
  (
    venta_producto_key INT IDENTITY(1,1) NOT NULL ,
    venta_producto_id INT NOT NULL ,
    venta_key    INT NOT NULL ,
    producto_dim_key INT NOT NULL ,
    venta_producto_fecha            DATE NOT NULL ,
    venta_producto_hora             TIME NOT NULL ,
    venta_producto_cantidad    DECIMAL (9,2) DEFAULT 1 NOT NULL ,
    venta_producto_precio_unitario DECIMAL (11,4) NOT NULL ,
    venta_producto_subtotal DECIMAL (11,4) NOT NULL ,
    venta_producto_iva DECIMAL (11,4) NOT NULL ,
    venta_producto_total DECIMAL (11,4) NOT NULL 
  ) ;
ALTER TABLE venta_producto ADD CONSTRAINT venta_producto__PK PRIMARY KEY ( venta_producto_key   ) ;
ALTER TABLE venta_producto ADD CONSTRAINT venta_producto_venta_FK FOREIGN KEY ( venta_key ) REFERENCES venta ( venta_key ) ON
UPDATE CASCADE ;
ALTER TABLE venta_producto ADD CONSTRAINT venta_producto_producto_dim_FK FOREIGN KEY ( producto_dim_key ) REFERENCES producto_dim ( producto_key ) ON
UPDATE CASCADE ;


CREATE TABLE produccion
  (
    produccion_key INT IDENTITY(1,1)  NOT NULL ,
    produccion_id INT  NOT NULL ,
    producto_dim_key        INTEGER NOT NULL ,
    empleado_dim_key        INTEGER NOT NULL ,
    fecha_dim_key INT NOT NULL ,
    produccion_fecha              DATE NOT NULL ,
    produccion_hora               TIME NOT NULL ,
    produccion_cantidad_producida DECIMAL (9,2) NOT NULL
  ) ;
ALTER TABLE produccion ADD CONSTRAINT produccion_PK PRIMARY KEY ( produccion_key ) ;
ALTER TABLE produccion ADD CONSTRAINT produccion_produccion_dim_FK FOREIGN KEY ( producto_dim_key ) REFERENCES producto_dim ( producto_key ) ON
UPDATE CASCADE ;
ALTER TABLE produccion ADD CONSTRAINT produccion_empleado_dim_FK FOREIGN KEY ( empleado_dim_key ) REFERENCES empleado_dim ( empleado_key ) ON
UPDATE CASCADE ;
ALTER TABLE produccion ADD CONSTRAINT produccion_fecha_dim_FK FOREIGN KEY ( fecha_dim_key ) REFERENCES DIM_FECHA ( Fecha_KEY ) ON
UPDATE CASCADE ;

CREATE TABLE compra
  (
    compra_key INT NOT NULL ,
    compra_id INT NOT NULL ,
    compra_direccion_entrega VARCHAR (750) NOT NULL ,
    compra_codigo_seguridad VARCHAR (20) NOT NULL ,    
    proveedor_dim_key            INT NOT NULL ,
    compra_fecha                   DATE NOT NULL ,
    compra_hora                    TIME NOT NULL ,
    forma_pago_dim_key           INT NOT NULL ,
    fecha_dim_key INT NOT NULL ,
    compra_estatus INT NOT NULL ,
    compra_subtotal DECIMAL (15,4) NOT NULL ,
    compra_iva DECIMAL (15,4) NOT NULL ,
    compra_total DECIMAL (15,4) NOT NULL 
  ) ;
ALTER TABLE compra ADD CONSTRAINT compra_PK PRIMARY KEY ( compra_key) ;
ALTER TABLE compra ADD CONSTRAINT compra_proveedor_dim_FK FOREIGN KEY ( proveedor_dim_key ) REFERENCES proveedor_dim ( proveedor_key ) ON
UPDATE CASCADE ;
ALTER TABLE compra ADD CONSTRAINT compra_fecha_dim_FK FOREIGN KEY ( fecha_dim_key ) REFERENCES DIM_FECHA ( Fecha_KEY ) ON
UPDATE CASCADE ;
  
  CREATE TABLE compra_producto
  (
    compra_producto_key INT NOT NULL ,
    compra_producto_id INT NOT NULL ,
    producto_dim_key          INT ,
    compra_key            INT NOT NULL , 
    compra_producto_cantidad             DECIMAL (9,2) NOT NULL ,
    compra_producto_entrada              DECIMAL (9,2) ,
    compra_producto_no_incluido          DECIMAL (9,2) ,
    compra_producto_subtotal DECIMAL (15,4) NOT NULL ,
    compra_producto_iva DECIMAL (15,4) NOT NULL ,
    compra_producto_total DECIMAL (15,4) 
  ) ;
ALTER TABLE compra_producto ADD CONSTRAINT compra_producto_PK PRIMARY KEY ( compra_producto_key ) ;
ALTER TABLE compra_producto ADD CONSTRAINT compra_producto_compra_FK FOREIGN KEY ( compra_key ) REFERENCES compra ( compra_key ) ON
UPDATE CASCADE ;
ALTER TABLE compra_producto ADD CONSTRAINT compra_producto_producto_dim_FK FOREIGN KEY ( producto_dim_key ) REFERENCES producto_dim ( producto_key ) ON
UPDATE CASCADE ;