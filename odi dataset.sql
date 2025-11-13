-- CREATE THE DATABASE (IF NOT EXISTS)
CREATE DATABASE IF NOT EXISTS retail_db;

-- USE THE DATABASE
USE retail_db;
-- CREATE THE odi_cricket TABLE
create table odi_cricket_data (
player_name varchar(100),
role varchar (50),
total_runs int,
strike_rate varchar(50) , -- kept varchar due to inconsistent formatting
total_balls_faced int,
total_wickets_taken int,
total_runs_conceded int,
total_overs_bowled int,
total_matches_played int,
matches_played_as_batter int,
matches_played_as_bowler int,
matches_won int,
matches_lost int,
player_of_match_awards int,
team varchar(100),
average varchar(50), -- kept varchar due to inconsistent formatting
percentage varchar(255) -- kept varchar due to inconsistent formatting
);
select * from odi_cricket_data;
desc table odi_cricket_data;

show variables like 'local_infile';
set global local_infile=1;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ODI_data.csv'
into table odi_cricket_data
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;

select * from odi_cricket_data;

-- CATEGORIZING PLAYERS BY ROLE
select player_name, role,
CASE
when role = 'BATTER' then 'BATSMAN'
when role = 'BOWLER' then 'BOWLER'
else 'ALL-ROUNDER'
end as player_category
from odi_cricket_data;

-- CLASSIFYING PLAYERS BASED ON RUNS SCORED
select player_name, total_runs,
 CASE
 when total_runs >=10000 then 'LEGEND'
 when total_runs BETWEEN 5000 AND 9999 THEN 'GREAT PLAYER'
 when total_runs BETWEEN 1000 AND 4999 THEN 'AVERAGE PLAYER'
 ELSE 'NEWCOMER'
 END AS player_class
from odi_cricket_data;

-- EVALUATING BOWLING PERFORMANCE (WICKETS TAKEN)
select player_name, totaL_wickets_taken,
CASE
 when total_wickets_taken >=300 then 'ELITE BOWLER'
 when total_wickets_taken BETWEEN 100 AND 299 THEN 'EXPERIENCED BOWLER'
 when total_wickets_taken BETWEEN 50 AND 99 THEN 'DEVELOPING BOWLER'
 ELSE 'PART-TIME BOWLER'
END AS bowling_category
from odi_cricket_data;

-- CLASSIFYING PLAYERS BY MATCHES WON
select player_name, matches_won,
CASE
when matches_won >=300 then 'Match_Winner'
when matches_won BETWEEN 200 and 299 then 'Consistent Performer'
when matches_won BETWEEN 100 and 199 then 'Contributor'
ELSE 'LESS IMPACTFUL'
END AS match_impact
from odi_cricket_data;

-- CATEGORIZING PLAYER OF THE MATCH AWARDS
select player_name, player_of_match_awards,
CASE
   when player_of_match_awards >=30 then 'Superstar'
   when player_of_match_awards BETWEEN 15 AND 29 THEN 'Key Player'
   when player_of_match_awards BETWEEN 5 AND 14 THEN 'Occasional Star'
   ELSE 'RARE WINNER'
END AS award_category
from odi_cricket_data;   

update odi_cricket_data
set strike_rate = substring_index(strike_rate,".",2);

update odi_cricket_data
set average = substring_index(average,".",2);

-- Get top 10 batsmen by runs
Select player_name, team, total_runs, strike_rate FROM odi_cricket_data WHERE role='Batter' 
order by total_runs DESC LIMIT 10;

-- Get top 10 bowlers by wickets
select player_name, team, total_wickets_taken, total_runs_conceded, total_overs_bowled FROM odi_cricket_data
WHERE total_wickets_taken>0 order by total_wickets_taken DESC LIMIT 10;

-- Insert a new player record 
insert into odi_cricket_data(player_name, role, total_runs, strike_rate, total_balls_faced,
total_wickets_taken, total_runs_conceded, total_overs_bowled,
total_matches_played, matches_played_as_batter, matches_played_as_bowler,
matches_won, matches_lost, player_of_match_awards, team, average, percentage)
VALUES ('NewPlayer' ,'Batter',5000, 85.50, 6000, 0, 0, 0, 200, 200, 0, 120, 80, 15, 'India', 45.5, 50.75);

-- Update strike_rate for a specific player
UPdate odi_cricket_data SET strike_rate = 90.25 WHERE player_name = 'V Kohli';

-- Delete records of retired players
Delete from odi_cricket_data WHERE total_matches_played<50;

-- Increase the total runs of a player after a recent match
UPDATE odi_cricket_data SET total_runs = total_runs+75, total_balls_faced=total_balls_faced+80 
WHERE player_name ='RG Sharma';

-- Set Role as 'All Rounder' for players with both runs and wickets
UPDATE odi_cricket_data SET role = 'All-Rounder' Where total_runs>1000 AND total_wickets_taken>50;

-- Reset strike_rate and average for players with incorrect values 
UPDATE odi_cricket_data SET strike_rate = NULL, average = NULL WHERE strike_rate<0 OR average < 0;

-- Remove players who have never won a match
delete from odi_cricket_data where matches_won = 0;

-- Set average to 0 fro players with zero matches played
Update odi_cricket_data Set average = 0 WHERE total_matches_played = 0;

-- Increase total wickets taken by 5 for bowlers from a specific team
Update odi_cricket_data Set total_wickets_taken = total_wickets_taken+5 Where role= 'Bowler' AND team = 'Australia';