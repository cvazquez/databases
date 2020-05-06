# DROP TABLE IF EXISTS cvazquezblog.`entrypictures`;
CREATE TABLE cvazquezblog.`entrypictures` (
	`id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`entryId` MEDIUMINT UNSIGNED NOT NULL,
	`title` VARCHAR(250) NOT NULL,
	`description` TEXT NULL,
	`link100x75` VARCHAR(100) NOT NULL DEFAULT '',
	`link640x480` VARCHAR(100) NOT NULL DEFAULT '',
	`sequence` TINYINT UNSIGNED NOT NULL DEFAULT '0',
	`extension` VARCHAR(4) NOT NULL,
	
	`takenAt` DATETIME NULL DEFAULT NULL,
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
  
) comment = "Pictures associated with an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;    

#update entrypictures
#set deletedAt = now();

Thumbnail 100x75
select length("http://farm4.staticflickr.com/3712/9049358173_98e6087bf5_t.jpg");

Medium 640x480
http://farm4.staticflickr.com/3712/9049358173_98e6087bf5_z.jpg

500x375
http://farm4.staticflickr.com/3712/9049358173_98e6087bf5.jpg

http://farm3.staticflickr.com/2845/9051587436_303e0c0935.jpg
http://farm3.staticflickr.com/2845/9051587436_303e0c0935_s.jpg


alter table entrypictures
add 	`link100x75` VARCHAR(100) NOT NULL DEFAULT '' after description,
add	`link640x480` VARCHAR(100) NOT NULL DEFAULT '' after link100x75,
add	`link500x375` VARCHAR(100) NOT NULL DEFAULT '' after link640x480;

select * from entrypictures
where entryId = 19;

select * from pictureurls;

#/images/Cañon-Del-Colca.jpg
ReWriteRule ^/images/([a-z0-9\-_]+)\.jpg /blog/PictureRedirect/$1 [L,NC]