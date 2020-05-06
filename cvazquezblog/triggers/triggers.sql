DELIMITER $$

CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `entries_au` AFTER UPDATE ON `entries` FOR EACH ROW BEGIN
	
	DECLARE titleExists TINYINT DEFAULT 0;
	
	/* Check if the title has been updated. */
	IF (NEW.title <> OLD.title) THEN
		
		/* Check if the updated title already exists from the past and re-active it */
		SELECT count(*) INTO titleExists
		FROM entryurls
		WHERE entryId = OLD.id AND titleURL = NEW.title;
		
		SET @updated_title = CreateTitleURL(NEW.title);
		
		IF (titleExists > 0) THEN
			/* The title existed in the past, so reactivate it and deactivate others for this entry id */
			UPDATE entryurls
			SET isActive = 1,
				updatedAt = now(),
				updatedBy = NEW.updatedBy,
				deletedAt = NULL,
				deletedBy = NULL
			WHERE entryId = OLD.id AND titleURL = @updated_title AND isActive = 0;
			
		ELSE
			/* The title doesn't exist. Create it new */
			INSERT IGNORE INTO entryurls (entryId, titleURL, isActive, createdAt, createdBy)
			SELECT OLD.id, CreateTitleURL(NEW.title), 1, now(), NEW.createdBy;
		END IF;
		
		/* Deactivate the previous active title */
		UPDATE entryurls
			SET isActive = 0,
				updatedAt = now(),
				updatedBy = NEW.updatedBy,
				deletedAt = now(),
				deletedBy = NEW.updatedBy
			WHERE entryId = OLD.id AND titleURL <> @updated_title AND isActive = 1;
	END IF;

	END$$



CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `entries_bi` BEFORE INSERT ON `entries` FOR EACH ROW BEGIN

	IF NEW.entryId = 0 THEN
		SET NEW.entryId = NULL;
	END IF;

	SET NEW.title = trim(NEW.title);
	SET NEW.teaser = trim(NEW.teaser);
	SET NEW.content = trim(NEW.content);
	SET NEW.metaDescription = trim(NEW.metaDescription);
	SET NEW.metaKeyWords = trim(NEW.metaKeyWords);

	END$$
	


CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `categories_bi` BEFORE INSERT ON `categories` FOR EACH ROW BEGIN

	IF categoryId = 0 THEN
		SET NEW.categoryId = NULL;
	END IF;

	END$$
	
	

CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `logvisits_bi` BEFORE INSERT ON `logvisits` FOR EACH ROW BEGIN

	IF IS_IPV4(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET_ATON(NEW.ipAddress);
	ELSEIF IS_IPV6(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET6_ATON(NEW.ipAddress);
	ELSE 
	SET NEW.ipAddress = NULL;
	END IF;

	END$$
	


CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `users_bi` BEFORE INSERT ON `users` FOR EACH ROW BEGIN

	IF IS_IPV4(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET_ATON(NEW.ipAddress);
	ELSEIF IS_IPV6(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET6_ATON(NEW.ipAddress);
	ELSE 
		SET NEW.ipAddress = NULL;
	END IF;
	
	IF NEW.stateId = 0 THEN
		SET NEW.stateId = NULL;
	END IF;
	
	IF NEW.cityId = 0 THEN
		SET NEW.cityId = NULL;
	END IF;
	
	SET NEW.firstName = trim(NEW.firstName);
	SET NEW.lastName = trim(NEW.lastName);
	SET NEW.email = trim(NEW.email);
	SET NEW.handle = trim(NEW.handle);
	SET NEW.passwd = trim(NEW.passwd);
	SET NEW.websiteURL = trim(NEW.websiteURL);
	SET NEW.city = trim(NEW.city);
	SET NEW.pathInfo = trim(NEW.pathInfo);	

	END$$


	
CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `categoryurls_bi` BEFORE INSERT ON `categoryurls` FOR EACH ROW BEGIN

	SET NEW.name = trim(NEW.name);

	END$$
	
	
	
CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `cities_bi` BEFORE INSERT ON `cities` FOR EACH ROW BEGIN

	SET NEW.name = trim(NEW.name);

	END$$
	

	
CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `countries_bi` BEFORE INSERT ON `countries` FOR EACH ROW BEGIN

	SET NEW.name = trim(NEW.name);
	SET NEW.abbreviation = trim(NEW.abbreviation);

	END$$
	
	
	
CREATE DEFINER=`blog_trig_user`@`localhost` TRIGGER `countries_bi` BEFORE INSERT ON `countries` FOR EACH ROW BEGIN

	SET NEW.name = trim(NEW.name);
	SET NEW.abbreviation = trim(NEW.abbreviation);

	END$$