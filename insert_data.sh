#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOAL OPPONENT_GOAL
do
  if [[ ($WINNER != winner) && ($OPPONENT != opponent) ]]
  then
    TEAM1_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      if [[ -z $TEAM1_ID ]]
      then
        INSERT_TEAM1_RESULT=$($PSQL "INSERT INTO teams(name)VALUES('$WINNER')")
        echo winner
      fi
    TEAM2_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      if [[ -z $TEAM2_ID ]]
      then
        INSERT_TEAM1_RESULT=$($PSQL "INSERT INTO teams(name)VALUES('$OPPONENT')")
        echo opponent
      fi
  fi
done

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do 
    if [[ $WINNER != winner ]]
    then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals)VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
    echo $INSERT_GAMES_RESULT
    fi
  done
    

