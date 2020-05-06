delimiter $

DROP PROCEDURE `EntriesMissingCategories`$

CREATE PROCEDURE `EntriesMissingCategories`()
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT 'Return entries missing categories'
BEGIN

	SELECT e.id, e.title
	FROM entries e
	LEFT JOIN entrycategories ec ON ec.entryId = e.id
	WHERE ec.entryId IS NULL;


END

/*
INSERT INTO entrycategories (entryId, categoryId, createdAt)
VALUES (168, 8, now()), (168, 9, now());


INSERT INTO entrycategories (entryId, categoryId, createdAt)
VALUES (180, 3, now());



INSERT INTO entrycategories (entryId, categoryId, createdAt)
VALUES (172, 26, now()),
		(172, 24, now());
		

INSERT INTO entrycategories (entryId, categoryId, createdAt)
VALUES (170, 11, now()),
		(170, 16, now()),
		(170, 17, now()),
		(170, 18, now()),
		(170, 24, now());
		

INSERT INTO entrycategories (entryId, categoryId, createdAt)
VALUES (169, 7, now());
*/