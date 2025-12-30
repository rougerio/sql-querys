select *
  from otm_carriers_new cn
  left join (
   select substr(
      new_id,
      5,
      length(new_id) - 4
   ) as new_id,
          old_id
     from otm_carriers_old_new
) con
on cn.servprov = con.new_id
 where tarifa_activa = 'Y'
 order by cn.servprov;



select *
  from otm_carriers_new
 where servprov like '%FLETE%';

select substr(
   new_id,
   5,
   length(new_id) - 4
) as new_id,
       old_id
  from otm_carriers_old_new
 where new_id like '%FLETE%';


select *
  from (
   select servprov,
          razon_social,
          scac,
          new_id,
          tarifa_activa
     from otm_carriers ca
     left join (
      select substr(
         old_id,
         5,
         length(old_id) - 4
      ) as old_id,
             new_id
        from otm_carriers_old_new
   ) con
   on ca.servprov = con.old_id
    --WHERE TARIFA_ACTIVA = 'N'
    order by ca.servprov
) t
 where 1 = 1
   and t.new_id is null
   and t.tarifa_activa = 'Y'
   and t.servprov in ( 'CAR-4674332',
    --'CAR-3771504',
    --'CAR-4703769',
    --'CAR-3127499',
                       'CAR-2205296'
    --'CAR-4795172'
                        );


select servprov_gid,
       count(shipment_gid)
  from shipment
 where domain_name = 'NBL/MX'
   and insert_date >= to_date('2025-01-01','YYYY-MM-DD')
   and servprov_gid in ( 'NBL.CAR-2196573',
                         'NBL.CAR-2205296',
                         'NBL.CAR-2427889',
                         'NBL.CAR-2695283',
                         'NBL.CAR-2816412',
                         'NBL.CAR-2956542',
                         'NBL.CAR-2981500',
                         'NBL.CAR-3127499',
                         'NBL.CAR-3771504',
                         'NBL.CAR-4674332',
                         'NBL.CAR-4675327',
                         'NBL.CAR-4681844',
                         'NBL.CAR-4703769',
                         'NBL.CAR-4795172' )
 group by servprov_gid;




select *
  from otm_carriers;

select *
  from otm_carriers_new;

select *
  from otm_carriers_old_new;