-- Active: 1783386727664@@127.0.0.1@5432@football_ticket_db@public
CREATE TABLE
    IF NOT EXISTS users (
        user_id SERIAL PRIMARY KEY,
        full_name VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        role VARCHAR(20) NOT NULL DEFAULT 'Football Fan' CHECK (role IN ('Ticket Manager', 'Football Fan')),
        phone_number VARCHAR(15) UNIQUE,
        created_at TIMESTAMP DEFAULT NOW (),
        updated_at TIMESTAMP DEFAULT NOW ()
    );

CREATE TABLE
    IF NOT EXISTS matches (
        match_id SERIAL PRIMARY KEY,
        fixture VARCHAR(100) NOT NULL,
        tournament_category VARCHAR(100) NOT NULL,
        base_ticket_price NUMERIC(10, 2) NOT NULL,
        match_status VARCHAR(20) NOT NULL DEFAULT 'Available' CHECK (
            match_status IN (
                'Available',
                'Selling Fast',
                'Sold Out',
                'Postponed'
            )
        ),
        created_at TIMESTAMP DEFAULT NOW (),
        updated_at TIMESTAMP DEFAULT NOW ()
    );

CREATE TABLE
    IF NOT EXISTS bookings (
        booking_id SERIAL PRIMARY KEY,
        user_id INT REFERENCES users (user_id) ON DELETE SET NULL,
        match_id INT REFERENCES matches (match_id) ON DELETE SET NULL,
        seat_number VARCHAR(10),
        payment_status VARCHAR(20) CHECK (
            payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
        ),
        total_cost NUMERIC(10, 2) NOT NULL,
        created_at TIMESTAMP DEFAULT NOW (),
        updated_at TIMESTAMP DEFAULT NOW ()
    );

-- ! retrieve matches which status available
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM
    matches
WHERE
    match_status = 'Available'
    AND tournament_category = 'Champions League';

-- ! retrieve user
SELECT
    user_id,
    full_name,
    email
FROM
    users
WHERE
    full_name ILIKE 'tanvir%'
    OR full_name ILIKE '%Haque';

-- ! retrieve booking
SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM
    bookings
WHERE
    payment_status IS NULL;

-- ! Retrieve match booking details 
SELECT 
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id
INNER JOIN 
    matches m ON b.match_id = m.match_id;


-- ! display list of all user
SELECT 
    u.user_id,
    u.full_name,
    b.booking_id
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id
ORDER BY 
    u.user_id ASC;


-- ! higher cost booking
SELECT 
    booking_id,
    match_id,
    total_cost
FROM 
    bookings
WHERE 
    total_cost > (SELECT AVG(total_cost) FROM bookings);


-- ! expensive match
SELECT 
    match_id,
    fixture,
    base_ticket_price
FROM 
    matches
ORDER BY 
    base_ticket_price DESC
LIMIT 2 OFFSET 1;