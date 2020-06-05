CREATE TABLE IF NOT EXISTS cvazquezblog.`series` (
	`id` MEDIUMINT(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(255) NOT NULL DEFAULT '',
	`contentTeaser` SMALLTEXT NULL DEFAULT NULL,
	`publishAt` DATETIME NULL DEFAULT NULL,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	UNIQUE INDEX nameIdx (name)

) COMMENT = "A series of related entries"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

  ALTER TABLE series
  ADD `publishAt` DATETIME NULL DEFAULT NULL AFTER name,
  ADD `contentTeaser` MEDIUMTEXT NULL DEFAULT NULL AFTER name;

DROP TRIGGER IF EXISTS seriesurls_bi;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER series_bi BEFORE INSERT
    ON series FOR EACH ROW

	BEGIN

	SET NEW.name = trim(NEW.name);

	END;
|
DELIMITER ;


DROP TRIGGER IF EXISTS series_ai;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER series_ai AFTER INSERT
    ON series FOR EACH ROW

	BEGIN

	INSERT INTO seriesurls (seriesId, titleURL, isActive, createdAt, createdBy)
	SELECT NEW.id, CreateTitleURL(NEW.title), 1, now(), NEW.createdBy;

	END;
|
DELIMITER ;


DROP TRIGGER IF EXISTS series_au;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER series_au AFTER UPDATE
    ON series FOR EACH ROW

	BEGIN

	DECLARE titleExists TINYINT DEFAULT 0;

	/* Check if the title has been updated. */
	IF (NEW.title <> OLD.title) THEN

		/* Check if the updated title already exists from the past and re-active it */
		SELECT count(*) INTO titleExists
		FROM seriesurls
		WHERE seriesId = OLD.id AND titleURL = NEW.title;

		SET @updated_title = CreateTitleURL(NEW.title);

		IF (titleExists > 0) THEN
			/* The title existed in the past, so reactivate it and deactivate others for this entry id */
			UPDATE seriesurls
			SET isActive = 1,
				updatedAt = now(),
				updatedBy = NEW.updatedBy,
				deletedAt = NULL,
				deletedBy = NULL
			WHERE seriesId = OLD.id AND titleURL = @updated_title AND isActive = 0;

		ELSE
			/* The title doesn't exist. Create it new */
			INSERT IGNORE INTO seriesurls (seriesId, titleURL, isActive, createdAt, createdBy)
			SELECT OLD.id, CreateTitleURL(NEW.title), 1, now(), NEW.createdBy;
		END IF;

		/* Deactivate the previous active title */
		UPDATE seriesurls
			SET isActive = 0,
				updatedAt = now(),
				updatedBy = NEW.updatedBy,
				deletedAt = now(),
				deletedBy = NEW.updatedBy
			WHERE seriesId = OLD.id AND titleURL <> @updated_title AND isActive = 1;
	END IF;
	END;
|
DELIMITER ;

GRANT EXECUTE ON FUNCTION cvazquezblog.CreateTitleURL  TO 'blog_trig_user'@'localhost';
GRANT SELECT, UPDATE, INSERT, TRIGGER ON `cvazquezblog`.`seriesurls` TO 'blog_trig_user'@'localhost';
GRANT SELECT, UPDATE, TRIGGER ON series TO 'blog_trig_user'@'127.0.0.1';