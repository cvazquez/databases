CREATE TABLE `flickrsetphotourls` (
	`flickrSetPhotoId` BIGINT(20) UNSIGNED NOT NULL,
	`name` VARCHAR(255) NOT NULL DEFAULT '',
	`isActive` TINYINT(1) NOT NULL DEFAULT '0',
	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`flickrSetPhotoId`, `name`),
	UNIQUE INDEX `nameIdx` (`name`),
	FOREIGN KEY (`flickrSetPhotoId`) REFERENCES flickrsetphotos(id)
)
COMMENT='User friendly Photo URLs for Flickr'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;


show engine innodb status;



INSERT INTO flickrsetphotourls (flickrSetPhotoId, name, isActive, createdAt)
SELECT id, CreateTitleURL(title), 1, now()
FROM flickrsetphotos
WHERE deletedAt IS NULL
ORDER BY id;

UPDATE flickrsetphotourls fspu
INNER JOIN flickrsetphotos fsp ON fsp.id = fspu.flickrSetPhotoId AND CreateTitleURL(fsp.title) <> fspu.name
SET fspu.isActive = 0;
			
			
GRANT INSERT, UPDATE ON cvazquezblog.flickrsetphotourls TO railo@localhost;