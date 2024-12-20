-- SELECT * FROM raster_columns;
-- SELECT * FROM raster_overview;

SELECT ST_Clip(
	rast,
	ST_TileEnvelope(14,4750,5875)
)
FROM public.tiff_ottawa_gatineau;