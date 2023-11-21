CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  source_id INT NOT NULL,
  genre_id INT NOT NULL,
  label_id INT NOT NULL,
  author_id INT NOT NULL,
  FOREIGN KEY (source_id) REFERENCES source(id)
  FOREIGN KEY (genre_id) REFERENCES genre(id)
  FOREIGN KEY (label_id) REFERENCES label(id)
  FOREIGN KEY (author_id) REFERENCES author(id)
  PRIMARY KEY (id)
);
