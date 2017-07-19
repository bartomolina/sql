SELECT name, year FROM movies WHERE year=1983;
SELECT COUNT(*) FROM movies WHERE year=1982;
SELECT first_name, last_name, gender FROM actors WHERE last_name lIKE '%stack%';

SELECT first_name, COUNT(*) AS total FROM actors GROUP BY first_name ORDER BY total DESC LIMIT 10;
SELECT last_name, COUNT(*) AS total FROM actors GROUP BY last_name ORDER BY total DESC LIMIT 10;
SELECT first_name || " " || last_name AS full_name, COUNT(*) AS total FROM actors GROUP BY full_name ORDER BY total DESC LIMIT 10;

SELECT first_name, last_name, COUNT(movie_id) AS movies, (SELECT COUNT(*) FROM roles WHERE actor_id = id GROUP BY role ) AS roles
    FROM actors JOIN roles ON actors.id = roles.actor_id
    GROUP BY first_name, last_name
    ORDER BY movies DESC
    LIMIT 100;

SELECT movie_id, movies.id AS movieId FROM movies_genres LEFT JOIN movies ON movies_genres.movie_id = movies.id
    WHERE movieId IS NULL LIMIT 10;
SELECT genre, COUNT(id) AS total FROM movies JOIN movies_genres ON movies.id = movies_genres.movie_id GROUP BY genre ORDER BY total;

SELECT first_name, last_name FROM actors
    JOIN roles ON actors.id = roles.actor_id
    JOIN movies ON roles.movie_id = movies.id
    WHERE movies.name = "Braveheart" AND movies.year = 1995
    ORDER BY last_name;

SELECT first_name, last_name, movies.name, movies.year FROM directors
    JOIN movies_directors ON directors.id = movies_directors.director_id
    JOIN movies_genres ON movies_directors.movie_id = movies_genres.movie_id
    JOIN movies ON movies_genres.movie_id = movies.id
    WHERE movies_genres.genre = 'Film-Noir' AND movies.year % 4 = 0;

SELECT movies.name, first_name, last_name FROM actors
    JOIN roles ON actors.id = roles.actor_id
    JOIN movies ON roles.movie_id = movies.id
    WHERE movies.id IN (
        SELECT movies_genres.movie_id FROM roles
            JOIN actors ON roles.actor_id = actors.id
            JOIN movies_genres ON roles.movie_id = movies_genres.movie_id
            WHERE first_name = 'Kevin' AND last_name = 'Bacon' AND movies_genres.genre = 'Drama')
    AND first_name <> 'Kevin' AND last_name <> 'Bacon'
    ORDER BY movies.name;

DROP INDEX "actors_idx_first_name";
DROP INDEX "actors_idx_last_name";

Run Time: real 13.169 user 6.819456 sys 5.317886

CREATE INDEX "actors_idx_first_name" ON "actors" ("first_name");
CREATE INDEX "actors_idx_last_name" ON "actors" ("last_name");

Run Time: real 13.594 user 6.902938 sys 5.489153