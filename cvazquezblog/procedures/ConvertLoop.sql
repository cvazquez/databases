delimiter //

DROP PROCEDURE IF EXISTS cvazquezblog.`ConvertLoop`//

CREATE PROCEDURE cvazquezblog.`ConvertLoop`()
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT 'Old to New Blog Conversions'
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE lId INT; 
	DECLARE lEntryId INT; 
	DECLARE lContent TEXT;
	DECLARE lFirstName VARCHAR(255); 
	DECLARE lLastName VARCHAR(255); 
	DECLARE lCity VARCHAR(255);
	DECLARE lStateId INT;
	DECLARE lHandle VARCHAR(255);
	DECLARE lPasswd VARCHAR(255);
	DECLARE lCreatedAt DATETIME DEFAULT NULL;
	DECLARE lUpdatedAt DATETIME DEFAULT NULL;
	DECLARE lDeletedAt DATETIME DEFAULT NULL;

	DECLARE curComments CURSOR FOR 
		SELECT `comment_id`, `blog_id`, `blog_comment`,
			`firstname`, `lastname`, `city`, `state_id`, `username`, `password`,
			`date_entered`, `date_updated`, 
			CASE `is_active`
			WHEN 0 THEN
				IF (`date_updated` IS NOT NULL AND `date_updated` > 0, `date_updated`, NOW())
			ELSE NULL
			END
		FROM cvazquezold.blog_comments
		ORDER BY comment_id;
	
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	SET FOREIGN_KEY_CHECKS = 0;
	TRUNCATE TABLE cvazquezblog.`users`;
	TRUNCATE TABLE cvazquezblog.`entrydiscussions`;

	OPEN curComments;
	
		loopComments: LOOP
			FETCH curComments INTO lId, lEntryId, lContent, lFirstName, lLastName, lCity, lStateId, lHandle, lPasswd, lCreatedAt, lUpdatedAt, lDeletedAt;
		
			IF done THEN 
				LEAVE loopComments;
			END IF;
			
			START TRANSACTION;
		
				# Users
				INSERT IGNORE INTO cvazquezblog.`users` (stateId, firstName, lastName, email, handle, passwd, `city`, createdAt, updatedAt, deletedAt)
				VALUES (lStateId, lFirstName, lLastName, lHandle, lHandle, lPasswd, lCity, lCreatedAt, lUpdatedAt, lDeletedAt);
			
				# discussions
				INSERT IGNORE INTO cvazquezblog.`entrydiscussions` (id, entryId, userId, content, createdAt, updatedAt, deletedAt)
				VALUES (lId, lEntryId, last_insert_id(), lContent, lCreatedAt, lUpdatedAt, lDeletedAt);
					
			COMMIT;	
				
		END LOOP;

	CLOSE curComments;


END//