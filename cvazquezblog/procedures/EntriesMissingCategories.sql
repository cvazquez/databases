DELIMITER $

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