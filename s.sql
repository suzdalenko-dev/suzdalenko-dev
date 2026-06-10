select unidad,
       codigo_articulo,
       d_codigo_articulo,
       codigo_presentacion,
       version_estru,
       situ_estru,
       fase_consumo,
       cantidad_tecnica,
       version_compo,
       tipo_material,
       codigo_articulo_compo,
       codigo_presentacion_compo,
       codigo_org_planta,
       codigo_empresa,
       num_linea,
       codigo_articulo_cab,
       d_codigo_articulo_cab,
       presentacion_cab,
       baja
  from (
   select v.version_compo,
          v.codigo_presentacion_compo,
          v.codigo_articulo_compo,
          v.codigo_org_planta,
          v.codigo_empresa,
          v.num_linea,
          v.fase_consumo,
          ( decode(
             nvl(
                (
                   select u.tipo_desc_art
                     from usuarios u
                    where u.usuario = pkpantallas.usuario_validado
                ),
                'V'
             ),
             'C',
             a.descrip_compra,
             'T',
             a.descrip_tecnica,
             a.descrip_comercial
          ) ) d_codigo_articulo,
          v.codigo_articulo,
          v.codigo_presentacion,
          v.version_estru,
          v.situ_estru,
          v.cantidad_tecnica,
          v.tipo_material,
          v.codigo_articulo_cab,
          (
             select ( decode(
                nvl(
                   (
                      select u.tipo_desc_art
                        from usuarios u
                       where u.usuario = pkpantallas.usuario_validado
                   ),
                   'V'
                ),
                'C',
                art.descrip_compra,
                'T',
                art.descrip_tecnica,
                art.descrip_comercial
             ) )
               from articulos art
              where art.codigo_articulo = v.codigo_articulo_cab
                and art.codigo_empresa = v.codigo_empresa
          ) d_codigo_articulo_cab,
          v.presentacion_cab,
          (
             select a.unidad_codigo1
               from articulos a
              where a.codigo_articulo = v.codigo_articulo
                and a.codigo_empresa = v.codigo_empresa
          ) unidad,
          decode(
             a.fecha_baja,
             null,
             'N',
             'S'
          ) baja
     from v_estructuras_compo_mult v,
          articulos a
    where v.codigo_empresa = '001'
							    --nuevas condiciones
      and v.retorno <> 'S'
      and v.subproducto <> 'S'
							    --join con articulos
      and a.codigo_articulo = v.codigo_articulo
      and a.codigo_empresa = v.codigo_empresa
    order by v.codigo_articulo
)
 where ( '' is null
    or situ_estru = '' )
   and ( version_compo = '001' )
   and ( codigo_articulo_compo = '40759' )
   and ( codigo_presentacion_compo = 'KG' )
   and ( codigo_org_planta = '0' )
   and ( codigo_empresa = '001' );


-- 40759 TIRA POTON GLASEO

select *
from v_estructuras_compo_mult
where codigo_articulo_compo = '40759'
;