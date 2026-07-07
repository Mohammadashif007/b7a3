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


CREATE TABLE IF NOT EXISTS matches (
    match_id            SERIAL PRIMARY KEY,
    fixture             VARCHAR(100)    NOT NULL,
    tournament_category VARCHAR(100)    NOT NULL,
    base_ticket_price   NUMERIC(10,2)   NOT NULL,
    match_status        VARCHAR(20)     NOT NULL DEFAULT 'Available' CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed')),
    created_at          TIMESTAMP       DEFAULT NOW(),
    updated_at          TIMESTAMP       DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS bookings (
    booking_id      SERIAL PRIMARY KEY,
    user_id         INT             REFERENCES users(user_id) ON DELETE SET NULL,
    match_id        INT             REFERENCES matches(match_id) ON DELETE SET NULL,
    seat_number     VARCHAR(10),
    payment_status  VARCHAR(20)     CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost      NUMERIC(10,2)   NOT NULL,
    created_at      TIMESTAMP       DEFAULT NOW(),
    updated_at      TIMESTAMP       DEFAULT NOW()
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