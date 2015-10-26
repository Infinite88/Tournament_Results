-- Table definitions for the tournament project.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

CREATE TABLE players (
		id SERIAL PRIMARY KEY,
		name TEXT NOT NULL);


CREATE TABLE matches (
  		match_id SERIAL PRIMARY KEY,
  		p1 INT REFERENCES Players (id),
  		p2 INT REFERENCES Players (id),
  		winner_id INT REFERENCES Players (id)
  		CHECK (p1<>p2)
  		CHECK (p1 = winner_id OR p2=winner_id)
);

CREATE VIEW standings(id, name, wins, matches) AS
		SELECT players.id AS id,
		 players.name AS name,
		(SELECT count(*) FROM matches WHERE players.id = matches.winner_id) as wins,
		(SELECT count(*) FROM matches WHERE players.id = matches.p1 OR players.id = matches.p2) as matches
		FROM players
		ORDER BY wins DESC;