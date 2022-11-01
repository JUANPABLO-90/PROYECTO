 USE BD_STAGE 
 CREATE TABLE venta_stage
  (
    id               INT NOT NULL ,
    empleado_id      INT NOT NULL ,
    cliente_id       INT ,
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
CREATE INDEX venta__IDX ON venta_stage
  (
    id ASC
  ) ;

CREATE INDEX venta_IDX ON venta_stage
  (
    fecha ASC ,
    hora ASC
  ) ;


ALTER TABLE venta_stage ADD CONSTRAINT venta_serie_UN UNIQUE ( serie ) ;
ALTER TABLE venta_stage ADD CONSTRAINT venta_PK PRIMARY KEY ( id ) ;

CREATE TABLE venta_producto_stage
  (
    id INT NOT NULL ,
    venta_id    INT NOT NULL ,
    producto_id INT NOT NULL ,
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