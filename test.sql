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