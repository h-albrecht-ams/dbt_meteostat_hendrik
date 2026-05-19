WITH weather_daily AS (

    SELECT *
    FROM {{ ref('prep_weather_daily') }}

),

weekly_weather AS (

    SELECT
        airport_code,
        date_year,
        cw,
        AVG(avg_temp_c) AS avg_temp_c,
        MIN(min_temp_c) AS min_temp_c,
        MAX(max_temp_c) AS max_temp_c,
        SUM(precipitation_mm) AS precipitation_mm,
        MAX(max_snow_mm) AS max_snow_mm,
        AVG(avg_wind_direction) AS avg_wind_direction,
        AVG(avg_wind_speed_kmh) AS avg_wind_speed_kmh,
        MAX(wind_peakgust_kmh) AS wind_peakgust_kmh,
        AVG(avg_pressure_hpa) AS avg_pressure_hpa,
        SUM(sun_minutes) AS sun_minutes,
        MAX(season) AS season
    FROM weather_daily
    GROUP BY airport_code, date_year, cw

)

SELECT *
FROM weekly_weather
