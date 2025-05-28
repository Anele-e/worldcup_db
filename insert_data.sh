#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

tail -n +2 games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  team_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
  if [[ -z $team_id ]]; then
    $PSQL "INSERT INTO teams(name) VALUES('$winner')"
  fi

  team_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
  if [[ -z $team_id ]]; then
    $PSQL "INSERT INTO teams(name) VALUES('$opponent')"
  fi
done

tail -n +2 games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")
  winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")
  $PSQL "INSERT INTO games(year, round, opponent_id, winner_id, winner_goals, opponent_goals) VALUES($year, '$round', $opponent_id, $winner_id, $winner_goals, $opponent_goals)"
done
