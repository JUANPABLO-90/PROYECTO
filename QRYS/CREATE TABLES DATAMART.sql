 USE BD_MART 
CREATE TABLE producto_dim
  (
    producto_key INT NOT NULL ,
    producto_id INT NOT NULL ,
    producto_nombre VARCHAR (100) NOT NULL ,
    producto_descripcion VARCHAR (750)
  ) ;
ALTER TABLE producto_dim ADD CONSTRAINT producto_dim_PK PRIMARY KEY ( producto_key ) ;

CREATE TABLE direccion_dim
  (
    direccion_key INT NOT NULL ,
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
    empleado_key INT NOT NULL ,
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

CREATE TABLE forma_pago_dim
  (
    forma_pago_key INT NOT NULL ,
    forma_pago_id INT NOT NULL ,
    forma_pago_nombre VARCHAR (15) NOT NULL ,
    forma_pago_descripcion VARCHAR (750)
  ) ;
ALTER TABLE forma_pago_dim ADD CONSTRAINT forma_pago_dim__PK PRIMARY KEY ( forma_pago_key ) ;


CREATE TABLE cliente_dim
  (
    cliente_key INT NOT NULL ,
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
    venta_key               INT NOT NULL ,
    venta_id               INT NOT NULL ,
    empleado_dim_key      INT NOT NULL ,
    cliente_dim_key       INT ,
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

CREATE TABLE venta_producto
  (
    venta_producto_key INT NOT NULL ,
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
