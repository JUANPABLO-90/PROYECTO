
--mysl
CREATE DATABASE ORIGEN

--MYSQL
CREATE TABLE proveedor_origen
  (
    id INT ,
    rfc VARCHAR (13) NOT NULL ,
    razon_social VARCHAR (50) NOT NULL ,
    nombre_comercial VARCHAR (50) NOT NULL ,
    email VARCHAR (50) ,
    telefono_1 VARCHAR (50) ,
    telefono_2 VARCHAR (50) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
CREATE UNIQUE INDEX proveedor_origen_IDX ON proveedor_origen
  (
    nombre_comercial ASC
  )
  ;
ALTER TABLE proveedor_origen ADD CONSTRAINT proveedor_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE proveedor_origen ADD CONSTRAINT proveedor_origen_rfc_UN UNIQUE ( rfc ) ;
ALTER TABLE proveedor_origen ADD CONSTRAINT proveedor_origen_razon_social_UN UNIQUE ( razon_social ) ;

