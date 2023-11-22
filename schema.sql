CREATE DATABASE catalog_of_things;

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE sources (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  source_id INT NOT NULL,
  genre_id INT NOT NULL,
  label_id INT NOT NULL,
  author_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genre(id)
  FOREIGN KEY (label_id) REFERENCES label(id)
  FOREIGN KEY (author_id) REFERENCES author(id)
  PRIMARY KEY (id)
);

CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  source_id INT NOT NULL,
  genre_id INT NOT NULL,
  label_id INT NOT NULL,
  author_id INT NOT NULL,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE,
  FOREIGN KEY (genre_id) REFERENCES genre(id)
  FOREIGN KEY (label_id) REFERENCES label(id)
  FOREIGN KEY (author_id) REFERENCES author(id)
);

CREATE TABLE genre
(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(100),
    items TEXT
    []
);
    
    CREATE TABLE music_album
    (
        id INT PRIMARY KEY NOT NULL,
        on_spotify BOOLEAN,
        publish_date DATE,
        archived BOOLEAN,
        genre_id INT REFERENCES genre(id)
    );