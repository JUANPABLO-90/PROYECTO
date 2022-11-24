--venta
select v.*, f.Fecha_Key, e.empleado_key, c.cliente_key, p.forma_pago_key 
from venta_stage as v
inner join BD_MART.dbo.DIM_FECHA as f
on f.fecha = CAST(v.fecha as date)
inner join BD_MART.dbo.empleado_dim as e
on e.empleado_id = v.empleado_stage_id
inner join BD_MART.dbo.cliente_dim as c
on c.cliente_id = v.cliente_stage_id
inner join BD_MART.dbo.forma_pago_dim as p
on p.forma_pago_id = v.forma_pago_id

--venta producto

select vp.*, v.venta_key, p.producto_key 
from venta_producto_stage as vp
inner join BD_MART.dbo.venta as v
on v.venta_id = vp.venta_stage_id
inner join BD_MART.dbo.producto_dim as p
on p.producto_id = vp.producto_stage_id

--cliente_dim

select c.*, d.direccion_key from cliente_stage  as c
inner join BD_MART.dbo.direccion_dim as d
on d.direccion_id = c.direccion_stage_id

--produccion

select pr.*, f.Fecha_Key, e.empleado_key, p.producto_key
from produccion_stage as pr
inner join BD_MART.dbo.DIM_FECHA as f
on f.fecha = CAST(pr.fecha as date)
inner join BD_MART.dbo.empleado_dim as e
on e.empleado_id = pr.empleado_stage_id
inner join BD_MART.dbo.producto_dim as p
on p.producto_id = pr.producto_stage_id

--compra

select co.*, f.Fecha_Key, pr.proveedor_key, fp.forma_pago_key
from compra_stage as co
inner join BD_MART.dbo.DIM_FECHA as f
on f.fecha = CAST(co.fecha as date)
inner join BD_MART.dbo.proveedor_dim as pr
on pr.proveedor_id = co.proveedor_stage_id
inner join BD_MART.dbo.forma_pago_dim as fp
on fp.forma_pago_id = co.forma_pago_stage_id

-- compra_producto


select cp.*, pr.producto_key, co.compra_key
from compra_producto_stage as cp
inner join BD_MART.dbo.producto_dim as pr
on pr.producto_id = cp.producto_stage_id
inner join BD_MART.dbo.compra as co
on co.compra_key = cp.compra_stage_id



