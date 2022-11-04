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
    colonia       VARCHAR (50)  ,
    municipio     VARCHAR (50)  ,
    estado        VARCHAR (50)  ,
    pais          VARCHAR (50) ,
    estatus           VARCHAR (15) 
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

CREATE TABLE cliente_stage
  (
    id INT NOT NULL ,
    rfc VARCHAR (13) ,
    razon_social VARCHAR (150) ,
    nombre_comercial VARCHAR (150),
    estatus VARCHAR (15) NOT NULL
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
