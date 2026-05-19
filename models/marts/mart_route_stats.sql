WITH flights AS (

    SELECT *
    FROM {{ ref('prep_flights') }}

),

airports AS (

    SELECT *
    FROM {{ ref('prep_airports') }}

),

route_stats AS (

    SELECT
        origin,
        dest,
        COUNT(DISTINCT tail_number) AS unique_airplanes,
        COUNT(DISTINCT airline) AS unique_airlines,
        COUNT(*) AS total_flights,
        AVG(actual_elapsed_time) AS avg_elapsed_time,
        AVG(arr_delay) AS avg_arrival_delay,
        MAX(arr_delay) AS max_arrival_delay,
        MIN(arr_delay) AS min_arrival_delay,
        SUM(cancelled) AS total_cancelled,
        SUM(diverted) AS total_diverted
    FROM flights
    GROUP BY origin, dest

)

SELECT
    r.origin,
    r.dest,
    r.total_flights,
    r.unique_airplanes,
    r.unique_airlines,
    r.avg_elapsed_time,
    r.avg_arrival_delay,
    r.max_arrival_delay,
    r.min_arrival_delay,
    r.total_cancelled,
    r.total_diverted,
    origin_airport.name AS origin_airport_name,
    origin_airport.city AS origin_city,
    origin_airport.country AS origin_country,
    dest_airport.name AS destination_airport_name,
    dest_airport.city AS destination_city,
    dest_airport.country AS destination_country

FROM route_stats r
LEFT JOIN airports origin_airport
    ON r.origin = origin_airport.faa

LEFT JOIN airports dest_airport
    ON r.dest = dest_airport.faa