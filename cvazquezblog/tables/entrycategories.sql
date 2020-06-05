CREATE TABLE IF NOT EXISTS cvazquezblog.`entrycategories` (
    `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL AUTO_INCREMENT,
	`categoryId`  SMALLINT(9) UNSIGNED NOT NULL DEFAULT NULL,

	UNIQUE KEY (entryId, categoryId),

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (entryId) REFERENCES entries(id),
	FOREIGN KEY (categoryId) REFERENCES categories(id)

) COMMENT = "Maps 1 or more categories to an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

  ALTER TABLE entrycategories
  add unique index (entryId, categoryId);

  ALTER TABLE entrycategories add
	FOREIGN KEY (entryId) REFERENCES entries(id),
add	FOREIGN KEY (categoryId) REFERENCES categories(id),
add  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY first;