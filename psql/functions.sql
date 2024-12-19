DROP FUNCTION IF EXISTS public.tiff_ottawa_gatineau_zxy_query;

CREATE OR REPLACE 
	FUNCTION public.tiff_ottawa_gatineau_zxy_query(z integer, x integer, y integer)
	RETURNS bytea AS $$
DECLARE
	tile bytea;
BEGIN
	SELECT ST_AsPNG(rast)
	INTO tile
	FROM public.tiff_ottawa_gatineau
	WHERE z = z AND x = x AND y = y;

	IF tile IS NULL THEN
		RAISE NOTICE 'Tile (z: %, x: %, y: %) not found', z, x, y;
		RETURN NULL;
	ELSE
		RETURN tile;
	END IF;

END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE;

/*
DROP FUNCTION IF EXISTS public.tiff_ottawa_gatineau_zxy_query;

CREATE OR REPLACE
	FUNCTION public.tiff_ottawa_gatineau_zxy_query(z integer, x integer, y integer)
	RETURNS bytea AS $$
DECLARE
	img bytea;
BEGIN
	SELECT
	ST_Intersection(rast,ST_TileEnvelope(z,x,y))
	FROM public.tiff_ottawa_gatineau
	AS inter;

	SELECT INTO img
		ST_AsPNG(
			ST_AsRaster(
			  inter.geom,
			  256,
			  256, 
			  ARRAY['8BUI', '8BUI', '8BUI'], 
			  ARRAY[100, 100, 100],
			  ARRAY[0,0,0]
			)
		);
	
	RETURN img;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE;
*/

/*
DROP FUNCTION IF EXISTS public.tiff_ottawa_gatineau_zxy_query;

CREATE OR REPLACE
	FUNCTION public.tiff_ottawa_gatineau_zxy_query(z integer, x integer, y integer) RETURNS bytea AS $$
DECLARE
	img bytea;
BEGIN
	SELECT INTO img ST_AsPNG(
	  ST_AsRaster(
	      ST_collect(Array(
	          SELECT ST_Intersection(rast,ST_TileEnvelope(z,x,y)) FROM public.tiff_ottawa_gatineau UNION
	          SELECT ST_boundary(ST_TileEnvelope(z,x,y))
	      )
	  ), 256, 256, ARRAY['8BUI', '8BUI', '8BUI'], ARRAY[100,100,100], ARRAY[0,0,0])
	);
	RETURN img;
END
$$ LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE;
*/