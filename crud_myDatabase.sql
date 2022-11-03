use videogames;

select * 
from player;

select * 
from genre;

select * 
from platform;

select * 
from game;

select *
from game_has_platform;

select *
from game_has_player;



# Check genre of games 
select game.game_name as "Game Title", genre.genre_type as "Genre"
from game join genre
on game.Genre_id = genre.id;


# What players are playing (incorrect)
select game.game_name as "Game Title", player.player_name as "Player's Name"
from game join player
on game.id = player_id;



# In which platfors are the games? (incorrect, can not connect the many to many tables)
select game.game_name as "Game Title", platform.platform_name as "Platform"
from game join platform
#on game.id = platform.id;
on game.id = game_has_platform.platform_id;



# Which platforms the players have?
select player.player_name, platform.platform_name
from player join platform
on player.id = platform.player_id;


-- now Filippos has also a Playstation
insert into platform (platform_name, player_id)
values ("Playstation", 1);



# What is the average age of players?
select floor(avg(player_age)) AS "Average age of players"
from player;



-- -------------------------------------------------------------TRANSACTION-----------------------------------------------------------------------------------
-- Transaction is a group of sql statements. in this example we change the name of the persons whose age < 25 and then we add a new player.
-- then we can check if we like the changes made from this group. if we aggree on the changes we run commit to stop the transaction with the changes.
-- if we don't want to keep the changes we run rollback instead of commit and the changes will be reverted.
-- In my opinion transaction is a great tool in order to use it in big databases. Anyone can make changes and see the effect and if there is something wrong
-- we can always rollback.  We also have to be careful because not all changes can be reverted. for e.g. drop scheme.
-- for more advanced use we can have savepoints between the statements and rollback to each savepoint instead of the whole group.
SET autocommit = OFF;
start transaction;
update player
set player_name = concat(player_name, " is young!")
where player_age < 25;
insert into player (player_name, player_age)
values ("Old Helder" , 80);
commit;
rollback;

select *
from player;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- -------------------------------------------------------------SUBQUERY-----------------------------------------------------------------------------------

-- is a statement inside a statement.  e.g. select player name inside the player table where the player_age = 32.  
-- of course we can write this specific statement without a subquery.

select player_name
from player
where player_name in
	(select player_name 
	from player
	where player_age = 32);
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------



