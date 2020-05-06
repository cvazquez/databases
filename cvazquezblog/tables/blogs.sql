# Single User Blog (A multiple user blog will probably have user ids associated with Blog entries.)

CREATE DATABASE cvazquezblog CHARACTER SET utf8 COLLATE 'utf8_general_ci;

CREATE TABLE cvazquezblog.`countries` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	
	`name` VARCHAR(50) NOT NULL,
	`abbreviation` VARCHAR(3) NOT NULL, 
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
  
) comment = "A list of countries"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;


DROP TRIGGER IF EXISTS countries_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER countries_bi BEFORE INSERT
    ON countries FOR EACH ROW
	
	BEGIN

	SET NEW.name = trim(NEW.name);
	SET NEW.abbreviation = trim(NEW.abbreviation);

	END;
|
delimiter ;


CREATE TABLE cvazquezblog.`states` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`countryId` SMALLINT UNSIGNED NOT NULL, 	
	
	`name` VARCHAR(50) NOT NULL,
	`abbreviation` VARCHAR(3) NOT NULL, 
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	FOREIGN KEY (countryId) references countries(id)
  
) comment = "A list of states"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;

-- http://weburge.com/build/states.php
-- http://drupal.org/node/332575

DROP TRIGGER IF EXISTS states_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER states_bi BEFORE INSERT
    ON states FOR EACH ROW
	
	BEGIN

	SET NEW.name = trim(NEW.name);
	SET NEW.abbreviation = trim(NEW.abbreviation);

	END;
|
delimiter ;


CREATE TABLE cvazquezblog.`cities` (
	`id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`stateId` SMALLINT UNSIGNED NOT NULL, 	
	
	`name` VARCHAR(50) NOT NULL,
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	FOREIGN KEY (stateId) references states(id),
	
	UNIQUE INDEX stateNameIdx (stateId, name)	
  
) comment = "A list of cities/state combinations"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  
  
DROP TRIGGER IF EXISTS cities_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER cities_bi BEFORE INSERT
    ON cities FOR EACH ROW
	
	BEGIN

	SET NEW.name = trim(NEW.name);

	END;
|
delimiter ;
  








CREATE TABLE cf_client_data 
(	
	expires VARCHAR(64) NOT NULL, 
	cfid VARCHAR(64) NOT NULL, 
	name VARCHAR(255) NOT NULL, 
	DATA TEXT NOT NULL
);

GRANT EXECUTE ON FUNCTION cvazquezblog.CutText TO  'railo'@'127.0.0.1';
GRANT EXECUTE ON FUNCTION cvazquezblog.CutText TO  blog_func_user@127.0.0.1;
GRANT EXECUTE ON FUNCTION cvazquezblog.StripHTML TO  blog_func_user@127.0.0.1;

GRANT SELECT ON cvazquezblog.* TO railo@localhost;
GRANT SELECT ON cvazquezblog.* TO railo@127.0.0.1;
GRANT TRIGGER, SELECT, UPDATE ON cvazquezblog.logvisits to blog_trig_user@127.0.0.1;
GRANT TRIGGER, SELECT, UPDATE ON cvazquezblog.entrydiscussions to blog_trig_user@127.0.0.1;
GRANT TRIGGER, SELECT, UPDATE ON cvazquezblog.users to blog_trig_user@127.0.0.1;

GRANT EXECUTE ON FUNCTION cvazquezblog.CreateTitleURL to blog_func_user@localhost;

#GRANT UPDATE, INSERT ON cvazquezblog.entrydiscussions to railo@localhost;
GRANT UPDATE, INSERT ON cvazquezblog.entrydiscussions to railo@127.0.0.1;
GRANT INSERT ON cvazquezblog.logvisits to railo@127.0.0.1;
GRANT INSERT ON cvazquezblog.logvisitdata to railo@127.0.0.1;

GRANT SELECT, INSERT, UPDATE ON cvazquezblog.cf_client_data to railo@127.0.0.1;