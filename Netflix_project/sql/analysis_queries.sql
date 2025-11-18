--1️⃣ Top 10 Most Popular Genres by Number of Shows
SELECT 
    g.genre_name,
    COUNT(sg.show_id) AS total_titles
FROM show_genres sg
JOIN genres g ON sg.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY total_titles DESC
LIMIT 10;

--2️⃣ Directors Who Have Worked in Multiple Genres
SELECT 
    d.director_name,
    COUNT(DISTINCT sg.genre_id) AS total_genres
FROM netflix_shows ns
JOIN directors d ON ns.director_id = d.director_id
JOIN show_genres sg ON ns.show_id = sg.show_id
GROUP BY d.director_name
HAVING total_genres > 3
ORDER BY total_genres DESC;

--Top 5 Countries with the Most Content Variety
SELECT 
    c.country_name,
    COUNT(DISTINCT sg.genre_id) AS genre_variety
FROM netflix_shows ns
JOIN countries c ON ns.country_id = c.country_id
JOIN show_genres sg ON ns.show_id = sg.show_id
GROUP BY c.country_name
ORDER BY genre_variety DESC
LIMIT 5;

--4️⃣ Most Common Rating for Each Genre
SELECT 
    g.genre_name,
    ns.rating,
    COUNT(*) AS total,
    RANK() OVER (PARTITION BY g.genre_name ORDER BY COUNT(*) DESC) AS rnk
FROM netflix_shows ns
JOIN show_genres sg ON ns.show_id = sg.show_id
JOIN genres g ON sg.genre_id = g.genre_id
GROUP BY g.genre_name, ns.rating
HAVING rnk = 1
ORDER BY g.genre_name;

--5️⃣ Find Directors with the Highest Average Movie Duration
SELECT 
    d.director_name,
    ROUND(AVG(CAST(SUBSTRING_INDEX(ns.duration, ' ', 1) AS UNSIGNED)), 2) AS avg_duration
FROM netflix_shows ns
JOIN directors d ON ns.director_id = d.director_id
WHERE ns.type = 'Movie'
GROUP BY d.director_name
HAVING COUNT(*) >= 3
ORDER BY avg_duration DESC
LIMIT 10;


---Advance Analysis
-- 1️⃣ Content Growth Trend per Year
SELECT 
    release_date,
    COUNT(show_id) AS total_titles,
    ROUND(
        (COUNT(show_id) / SUM(COUNT(show_id)) OVER()) * 100, 2
    ) AS percentage_share
FROM netflix_shows
GROUP BY release_date
ORDER BY release_date;


-- 2️⃣ Top 10 Countries Producing the Most Content
SELECT 
    c.country_name,
    COUNT(ns.show_id) AS total_titles
FROM netflix_shows ns
JOIN countries c ON ns.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_titles DESC
LIMIT 10;


-- 3️⃣ Top Directors by Number of Shows
SELECT 
    d.director_name,
    COUNT(ns.show_id) AS total_shows,
    GROUP_CONCAT(DISTINCT ns.type ORDER BY ns.type SEPARATOR ', ') AS categories
FROM netflix_shows ns
JOIN directors d ON ns.director_id = d.director_id
GROUP BY d.director_name
ORDER BY total_shows DESC
LIMIT 10;


-- 4️⃣ Adult Content Ratio by Country
SELECT 
    c.country_name,
    COUNT(CASE WHEN ns.rating IN ('TV-MA', 'R', 'NC-17') THEN 1 END) AS adult_titles,
    COUNT(*) AS total_titles,
    ROUND(
        (COUNT(CASE WHEN ns.rating IN ('TV-MA', 'R', 'NC-17') THEN 1 END) / COUNT(*)) * 100, 
        2
    ) AS adult_content_ratio
FROM netflix_shows ns
JOIN countries c ON ns.country_id = c.country_id
GROUP BY c.country_name
HAVING total_titles > 20
ORDER BY adult_content_ratio DESC
LIMIT 10;


-- 5️⃣ Most Popular Genres by Year
with cte as(SELECT 
    ns.release_date,
    g.genre_name,
    COUNT(*) AS total_titles,
    RANK() OVER (PARTITION BY ns.release_date ORDER BY COUNT(*) DESC) AS genre_rank
FROM netflix_shows ns
JOIN show_genres sg ON ns.show_id = sg.show_id
JOIN genres g ON sg.genre_id = g.genre_id
WHERE ns.release_date IS NOT NULL
GROUP BY ns.release_date, g.genre_name
HAVING total_titles > 5
ORDER BY ns.release_date, genre_rank)
select * from cte
where genre_rank=1;
