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