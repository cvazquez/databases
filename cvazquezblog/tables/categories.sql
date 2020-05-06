CREATE TABLE cvazquezblog.`categories` (
	`id` SMALLINT(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`categoryId`  SMALLINT(9) UNSIGNED NULL DEFAULT NULL COMMENT 'SubCategory of this category',

	`name` VARCHAR(250) NOT NULL DEFAULT '',
	`description` TEXT NOT NULL,
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	FOREIGN KEY (categoryId) REFERENCES categories(id)
  
) comment = "Categories for an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER categories_bi BEFORE INSERT
    ON categories FOR EACH ROW
	
	BEGIN

	IF categoryId = 0 THEN
		SET NEW.categoryId = NULL;
	END IF;

	END;



delimiter |
CREATE 	DEFINER=`blog_trig_user`@`localhost` 
			TRIGGER `categories_ai` 
			AFTER INSERT ON `categories` 
			FOR EACH ROW 
	BEGIN

		INSERT INTO categoryurls (categoryId, name, isActive, createdAt, createdBy)
		SELECT NEW.id, CreateTitleURL(NEW.name), 1, now(), NEW.createdBy;

	END;
|
delimiter ;


GRANT TRIGGER ON `cvazquezblog`.`categories` TO 'blog_trig_user'@'127.0.0.1';

/* INSERT command denied to user 'blog_trig_user'@'localhost' for table 'categoryurls' */
GRANT INSERT ON `cvazquezblog`.`categoryurls` TO 'blog_trig_user'@'localhost';

alter table categories
add `description` TEXT NOT NULL after name;