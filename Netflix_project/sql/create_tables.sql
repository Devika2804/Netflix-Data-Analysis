--netflix table
CREATE TABLE IF NOT EXISTS netflix (
    show_id VARCHAR(10) PRIMARY KEY,
    type VARCHAR(20),
    title VARCHAR(255),
    director VARCHAR(255),
    cast TEXT,
    country VARCHAR(255),
    release_date DATE,
    rating VARCHAR(10),
    duration VARCHAR(50),
    genre TEXT,
    description TEXT
);



-- Directors Table
CREATE TABLE if not exists directors (
    director_id INT AUTO_INCREMENT PRIMARY KEY,
    director_name VARCHAR(255) UNIQUE
);

-- Countries Table
CREATE TABLE if not exists countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) UNIQUE
);

-- Genres Table
CREATE TABLE if not exists  genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) UNIQUE
);

--Main Netflix Shows Table
CREATE TABLE netflix_shows (
    show_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255),
    type VARCHAR(50),
    director_id INT,
    country_id INT,
    release_date DATE,
    rating VARCHAR(50),
    duration VARCHAR(50),
    description TEXT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);
