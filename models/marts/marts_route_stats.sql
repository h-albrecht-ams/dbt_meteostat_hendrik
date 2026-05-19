WITH flights AS (

    SELECT *
    FROM {{ ref('prep_flights') }}

),

airports AS (

    SELECT *
    FROM {{ ref('prep_airports') }}

),

