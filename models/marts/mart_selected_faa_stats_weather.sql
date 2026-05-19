WITH flights AS (

    SELECT *
    FROM {{ ref('prep_flights') }}

),

airports AS (

    SELECT *
    FROM {{ ref('prep_airports') }}

),

weather_daily AS (

    SELECT *
    FROM {{ ref('prep_weather_daily') }}

),

airport_day_events AS (

    SELECT
        origin AS faa,
        flight_date,
        cancelled,
        diverted,
        tail_number,
        airline
    FROM flights

    UNION ALL

    SELECT
        dest AS faa,
        flight_date,
        cancelled,
        diverted,
        tail_number,
        airline
    FROM flights

),

airport_day_stats as (

    SELECT faa,
            flight_date,
        COUNT(DISTINCT tail_number) AS unique_airplanes,
        COUNT(DISTINCT airline) AS unique_airlines,
        COUNT(*) AS total_flights,
        SUM(cancelled) as cancelled_flights,
        SUM(diverted) as diverted_flights,
        SUM(
            CASE
                WHEN cancelled = 0 AND diverted = 0 THEN 1
                ELSE 0
            END
) AS occurred_flights
    FROM airport_day_events
    GROUP BY faa, flight_date
)

SELECT
    ads.faa,
    ads.flight_date,
    ads.total_flights,
    a.name,
    a.city,
    a.country,
    ads.cancelled_flights,
    ads.diverted_flights,
    ads.occurred_flights,
    ads.unique_airplanes,
    ads.unique_airlines,
    w.min_temp_c,
    w.max_temp_c,
    w.precipitation_mm,
    w.max_snow_mm,
    w.avg_wind_direction,
    w.avg_wind_speed_kmh,
    w.wind_peakgust_kmh

FROM airport_day_stats ads
LEFT JOIN weather_daily w
    ON ads.faa = w.airport_code
    AND ads.flight_date = w.date
LEFT JOIN airports a
    ON ads.faa = a.faa
