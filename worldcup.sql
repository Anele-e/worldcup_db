DROP DATABASE IF EXISTS worldcup;

CREATE DATABASE worldcup;

DROP TABLE IF EXISTS games, teams;
CREATE TABLE teams(
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE games(
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR(50) NOT NULL,
  winner_id INT NOT NULL,
  opponent_id INT NOT NULL,
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL,
  FOREIGN KEY (opponent_id) REFERENCES teams(team_id),
  FOREIGN KEY (winner_id) REFERENCES teams(team_id)
);

