#http://www.flickr.com/services/api/explore/flickr.photosets.getPhotos

#DROP TABLE IF EXISTS entryflickrsets;
CREATE TABLE IF NOT EXISTS cvazquezblog.`entryflickrsets` (
	`entryId` MEDIUMINT UNSIGNED NOT NULL,
	`flickrSetId` BIGINT UNSIGNED NOT NULL DEFAULT '0',

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (entryId) REFERENCES entries(id),
	FOREIGN KEy (flickrSetId) REFERENCES flickrsets(id),
	PRIMARY KEY (entryId, flickrSetId)

) COMMENT = "Flickr Picture Set associated with an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

# http://www.flickr.com/services/api/flickr.photos.getSizes.html