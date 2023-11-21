CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE,
  item_id INT NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
);