--TABLES DEFINITIONS

CREATE TYPE USER_ROLES AS ENUM('admin', 'regular');

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    profile_picture VARCHAR(500) DEFAULT '',
    password VARCHAR(300) NOT NULL,
    role USER_ROLES NOT NULL DEFAULT 'regular'
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    icon JSONB
);

CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL UNIQUE,
    icon JSONB,
    category_id INT REFERENCES categories(id) ON DELETE CASCADE,
    introduction TEXT NOT NULL,
    introduction_image VARCHAR(300) NOT NULL,
    lesson_data JSONB,
    visualization_data JSONB
);

CREATE TYPE DIFFICULTY_LEVELS AS ENUM('easy', 'normal', 'hard');

CREATE TABLE challenges (
    id SERIAL PRIMARY KEY,
    topic_id INT REFERENCES topics(id) ON DELETE CASCADE,
    title VARCHAR(50),
    difficulty_level DIFFICULTY_LEVELS NOT NULL DEFAULT 'easy',
    heading VARCHAR(500) NOT NULL,
    function_name VARCHAR(100) NOT NULL
);

CREATE TABLE tests (
    id SERIAL PRIMARY KEY,
    input_values JSONB,
    expected_result JSONB,
    id_challenge INT REFERENCES challenges(id) ON DELETE CASCADE
);

CREATE TABLE challenges_solved (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    challenge_id INT REFERENCES challenges(id) ON DELETE CASCADE,
    try_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CREATE VIEW getTestData 
-- AS 
-- SELECT 
-- 	challenges.id AS challengeId,
-- 	tests.id AS testId,
-- 	title,
-- 	functionName,
-- 	input_values,
-- 	expected_result 
-- FROM challenges JOIN tests 
-- ON challenges.id = tests.id_challenge;

CREATE OR REPLACE VIEW getTestData 
AS 
    SELECT challenges.id AS challengeid,
    tests.id AS testid,
    challenges.title,
    challenges.heading,
    challenges.difficulty_level,
    challenges.function_name,
    tests.input_values,
    tests.expected_result
FROM challenges
JOIN tests ON challenges.id = tests.id_challenge;