

DROP TABLE IF EXISTS movie_roles;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS studios;

-- Create studios table
CREATE TABLE studios (
    studio_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Create movies table
CREATE TABLE movies (
    movie_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    year_released INTEGER NOT NULL,
    mpaa_rating TEXT NOT NULL,
    studio_id INTEGER NOT NULL,
    FOREIGN KEY (studio_id) REFERENCES studios(studio_id)
);

-- Create actors table
CREATE TABLE actors (
    actor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Create movie_roles table to handle many-to-many relationship
CREATE TABLE movie_roles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    character_name TEXT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

-- Insert studio data
INSERT INTO studios (name) VALUES ('Warner Bros.');

-- Insert movies data
INSERT INTO movies (title, year_released, mpaa_rating, studio_id)
VALUES ('Batman Begins', 2005, 'PG-13', 1),
       ('The Dark Knight', 2008, 'PG-13', 1),
       ('The Dark Knight Rises', 2012, 'PG-13', 1);

-- Insert actors data
INSERT INTO actors (name) VALUES
    ('Christian Bale'), ('Michael Caine'), ('Liam Neeson'), ('Katie Holmes'), ('Gary Oldman'),
    ('Heath Ledger'), ('Aaron Eckhart'), ('Maggie Gyllenhaal'), ('Tom Hardy'), ('Joseph Gordon-Levitt'),
    ('Anne Hathaway');

-- Insert movie roles data
INSERT INTO movie_roles (movie_id, actor_id, character_name) VALUES
    (1, 1, 'Bruce Wayne'),
    (1, 2, 'Alfred'),
    (1, 3, 'Ra''s Al Ghul'),
    (1, 4, 'Rachel Dawes'),
    (1, 5, 'Commissioner Gordon'),
    (2, 1, 'Bruce Wayne'),
    (2, 6, 'Joker'),
    (2, 7, 'Harvey Dent'),
    (2, 2, 'Alfred'),
    (2, 8, 'Rachel Dawes'),
    (3, 1, 'Bruce Wayne'),
    (3, 5, 'Commissioner Gordon'),
    (3, 9, 'Bane'),
    (3, 10, 'John Blake'),
    (3, 11, 'Selina Kyle');

-- Print movies header
.print "Movies"
.print "======"
.print ""

-- Select movies report
SELECT m.title, m.year_released, m.mpaa_rating, s.name 
FROM movies m
JOIN studios s ON m.studio_id = s.studio_id;

-- Print cast header
.print ""
.print "Top Cast"
.print "========"
.print ""

-- Select cast report
SELECT m.title, a.name, r.character_name 
FROM movie_roles r
JOIN movies m ON r.movie_id = m.movie_id
JOIN actors a ON r.actor_id = a.actor_id
ORDER BY m.year_released, r.role_id;
