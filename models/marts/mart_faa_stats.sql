WITH flights AS (

    SELECT *
    FROM {{ ref('prep_flights') }}

),

airports AS (

    SELECT *
    FROM {{ ref('prep_airports') }}

),

departure_stats AS (

    SELECT
        origin AS faa,
        COUNT(DISTINCT dest) AS unique_departure_connections
    FROM flights
    GROUP BY origin

),

arrival_stats AS (

    SELECT
        dest AS faa,
        COUNT(DISTINCT origin) AS unique_arrival_connections
    FROM flights
    GROUP BY dest

),

airport_flight_events AS (

    SELECT
        origin AS faa,
        cancelled,
        diverted
    FROM flights

    UNION ALL

    SELECT
        dest AS faa,
        cancelled,
        diverted
    FROM flights

),

flight_totals AS (

    SELECT
        faa,
    COUNT(*) as planned_flights,
    SUM(cancelled) as cancelled_flights,
    sum(diverted) as diverted_flights,
    SUM(
    CASE
        WHEN cancelled = 0 AND diverted = 0 THEN 1
        ELSE 0
    END
) as occurred_flights
    FROM airport_flight_events
    GROUP BY faa

),

SELECT
    a.faa,
    a.name,
    a.city,
    a.country,
    d.unique_departure_connections,
    ar.unique_arrival_connections,
    f.planned_flights,
    f.cancelled_flights,
    f.diverted_flights,
    f.occurred_flights
FROM airports a
LEFT JOIN departure_stats d
    ON a.faa = d.faa
LEFT JOIN arrival_stats ar
    ON a.faa = ar.faa
LEFT JOIN flight_totals f
    ON a.faa = f.faa