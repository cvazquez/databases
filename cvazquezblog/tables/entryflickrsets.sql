#http://www.flickr.com/services/api/explore/flickr.photosets.getPhotos

#DROP TABLE IF EXISTS entryflickrsets;
CREATE TABLE cvazquezblog.`entryflickrsets` ( 
	`entryId` MEDIUMINT UNSIGNED NOT NULL,
	`flickrSetId` BIGINT UNSIGNED NOT NULL DEFAULT '0',
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	FOREIGN KEY (entryId) REFERENCES entries(id),
	FOREIGN KEy (flickrSetId) REFERENCES flickrsets(id),
	PRIMARY KEY (entryId, flickrSetId)
  
) comment = "Flickr Picture Set associated with an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  
# http://www.flickr.com/services/api/flickr.photos.getSizes.html

INSERT INTO `entryflickrsets` (`entryId`, `flickrSetId`, `createdAt`) 
VALUES (#, #, now());
