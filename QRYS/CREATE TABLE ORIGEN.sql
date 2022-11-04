 USE BD_ORIGEN
CREATE TABLE producto_origen
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
CREATE INDEX producto_origen__IDX ON producto_origen
  (
    nombre ASC
  ) ;
ALTER TABLE producto_origen ADD CONSTRAINT producto_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE producto_origen ADD CONSTRAINT producto_origen_nombre_UN UNIQUE ( nombre ) ;

CREATE TABLE direccion_origen
  (
    id INT NOT NULL ,
    calle VARCHAR (250) ,
    numero_exterior VARCHAR (15) ,
    numero_interior VARCHAR (15) ,
    localidad VARCHAR (250) ,
    codigo_postal VARCHAR (15)  ,
    colonia       VARCHAR (50)  ,
    municipio     VARCHAR (50)  ,
    estado        VARCHAR (50)  ,
    pais          VARCHAR (50) ,
    estatus           VARCHAR (15) 
  ) ;
CREATE INDEX direccion_origen__IDX ON direccion_origen
  ( id ASC
  ) ;
ALTER TABLE direccion_origen ADD CONSTRAINT direccion_origen_PK PRIMARY KEY ( id ) ;


CREATE TABLE empleado_origen
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
CREATE INDEX empleado_origen_IDX ON empleado_origen
  ( 
  id ASC
  ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_nss_UN UNIQUE ( nss ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_curp_UN UNIQUE ( curp ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_rfc_UN UNIQUE ( rfc ) ;
ALTER TABLE empleado_origen ADD CONSTRAINT empleado_origen_contrasenia_UN UNIQUE ( contrasenia ) ;

CREATE TABLE forma_pago_origen
  (
    id INT NOT NULL ,
    nombre VARCHAR (15) NOT NULL ,
    descripcion VARCHAR (750) ,
    estatus       VARCHAR (15) NOT NULL 
  ) ;
ALTER TABLE forma_pago_origen ADD CONSTRAINT forma_pago_origen__PK PRIMARY KEY ( id ) ;
ALTER TABLE forma_pago_origen ADD CONSTRAINT forma_pago_origen_nombre_UN UNIQUE ( nombre ) ;

CREATE TABLE cliente_origen
  (
    id INT NOT NULL ,
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


CREATE TABLE proveedor_origen
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
CREATE UNIQUE INDEX proveedor_origen_IDX ON proveedor_origen
  (
    nombre_comercial ASC
  )
  ;
ALTER TABLE proveedor_origen ADD CONSTRAINT proveedor_origen_PK PRIMARY KEY ( id ) ;
ALTER TABLE proveedor_origen ADD CONSTRAINT proveedor_origen_rfc_UN UNIQUE ( rfc ) ;
ALTER TABLE proveedor_origen ADD CONSTRAINT proveedor_origen_razon_social_UN UNIQUE ( razon_social ) ;

CREATE TABLE estatus_orden_compra_origen
  (
    id INT NOT NULL ,
    nombre VARCHAR (25) NOT NULL ,
    estatus       VARCHAR (15) NOT NULL
  ) ;
ALTER TABLE estatus_orden_compra_origen ADD CONSTRAINT estatus_orden_compra_origen_PK PRIMARY KEY ( id ) ;


CREATE TABLE compra_origen
  (
    id INT NOT NULL ,
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
ALTER TABLE compra_origen ADD CONSTRAINT compr_origena_estatus_orden_compra_origen_FK FOREIGN KEY ( estatus_orden_compra_origen_id ) REFERENCES estatus_orden_compra_origen ( id ) ON
UPDATE CASCADE ;

CREATE INDEX compra_origen__IDX ON compra_origen
  (
    hora ASC ,
    fecha ASC
  ) ;
  
  CREATE TABLE compra_producto_origen
  (
    id INT NOT NULL ,
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

  

 CREATE TABLE venta_origen
  (
    id               INT NOT NULL ,
    empleado_origen_id      INT NOT NULL ,
    cliente_origen_id       INT ,
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

CREATE TABLE venta_producto_origen
  (
    id INT NOT NULL ,
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
