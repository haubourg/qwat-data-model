/*
	qWat - QGIS Water Module

	SQL file :: hydrant view
*/


CREATE VIEW qwat_od.vw_hydrant AS
	SELECT
		hydrant.id             ,
		hydrant.identification ,
		hydrant.fk_distributor ,
		hydrant.fk_status      ,
		hydrant.fk_provider    ,
		hydrant.altitude       ,
		hydrant.year           ,
		hydrant.model          ,
		hydrant.underground    ,
		hydrant.marked         ,
		hydrant.remark         ,
		hydrant.pressure_static   ,
		hydrant.pressure_dynamic  ,
		hydrant.flow              ,
		hydrant.observation_date  ,
		hydrant.observation_source,
		hydrant.fk_district    ,
		hydrant.fk_pressurezone,
		hydrant.fk_printmap    ,
		hydrant._printmaps     ,
		hydrant.geometry::geometry(Point,:SRID),
		distributor.name       AS _distributor,
		status.value_fr        AS _status,
		status.active          AS _status_active,
		hydrant_provider.value_fr  AS _provider,
		district.name          AS _district,
		district.shortname     AS _district_shortname,
		pressurezone.name      AS _pressurezone,
		pressurezone.colorcode AS _pressurezone_colorcode
		FROM qwat_od.vw_element_hydrant hydrant
		INNER JOIN qwat_od.distributor           ON hydrant.fk_distributor  = distributor.id
		INNER JOIN qwat_vl.status                ON hydrant.fk_status       = status.id
		LEFT OUTER JOIN qwat_vl.hydrant_provider ON hydrant.fk_provider     = hydrant_provider.id
		LEFT OUTER JOIN qwat_od.district         ON hydrant.fk_district     = district.id
		LEFT OUTER JOIN qwat_od.pressurezone     ON hydrant.fk_pressurezone = pressurezone.id;
/*----------------!!!---!!!----------------*/
/* Comment */
COMMENT ON VIEW qwat_od.vw_hydrant IS 'View for hydrant. This view is editable (a rule exists to forward changes to the table).';
