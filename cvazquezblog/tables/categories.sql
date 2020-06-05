CREATE TABLE IF NOT EXISTS cvazquezblog.`categories` (
	`id` SMALLINT(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`categoryId`  SMALLINT(9) UNSIGNED NULL DEFAULT NULL COMMENT 'SubCategory of this category',

	`name` VARCHAR(250) NOT NULL DEFAULT '',
	`description` TEXT NOT NULL,
	`teaser` MEDIUMTEXT NULL DEFAULT NULL,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (categoryId) REFERENCES categories(id)

) COMMENT = "Categories for an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER categories_bi BEFORE INSERT
    ON categories FOR EACH ROW

	BEGIN

	IF categoryId = 0 THEN
		SET NEW.categoryId = NULL;
	END IF;

	END;



DELIMITER |
CREATE 	DEFINER=`blog_trig_user`@`localhost`
			TRIGGER `categories_ai`
			AFTER INSERT ON `categories`
			FOR EACH ROW
	BEGIN

		INSERT INTO categoryurls (categoryId, name, isActive, createdAt, createdBy)
		SELECT NEW.id, CreateTitleURL(NEW.name), 1, now(), NEW.createdBy;

	END;
|
DELIMITER ;


GRANT TRIGGER ON `cvazquezblog`.`categories` TO 'blog_trig_user'@'127.0.0.1';

/* INSERT command denied to user 'blog_trig_user'@'localhost' for table 'categoryurls' */
GRANT INSERT ON `cvazquezblog`.`categoryurls` TO 'blog_trig_user'@'localhost';

ALTER TABLE categories
add `description` TEXT NOT NULL after name;