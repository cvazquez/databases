# Select Table
# Select Data tab
# Select a row
# Right click row
# Export Grid Rows -> Copy to Clip Board -> Delimted Texts -> Field Separator - , (Follow comman by a space) -> enclose with ` (backtick) -> Row Selections - Selection 1 -> ok
# OR
# Export Grid Rows -> Copy to Clip Board ->  SQL INSERTS -> Row Selections - Selection 1 -> ok
# Exporting as SQL INSERTS is better because it backticks and puts spaces in between fields
# Past into SQL Editor. Delete Values and Keep field names

# SET FOREIGN_KEY_CHECKS = 0;
# TRUNCATE TABLE cvazquezblog.`entries`;

INSERT INTO cvazquezblog.`entries` (id, title, content, publishAt, deletedAt, createdAt, updatedAt)
select `blog_id`, `blog_title`, `blog_text`, 
	IF (`blog_date` = 0, NULL, blog_date), 
	CASE `is_active`
	WHEN 0 THEN
		IF (`date_updated` IS NOT NULL AND `date_updated` > 0, `date_updated`, NOW())
	ELSE NULL
	END,
	`date_entered`, `date_updated`
from cvazquezold.`blogs`
ORDER BY blog_id;

#Create entry teasers
UPDATE cvazquezblog.entries
SET teaser = CutText(content, 500, '...')
WHERE teaser = "";


# seriesentries
# INSERT INTO `blogs_related` (`related_id`, `blog_id`, `order_id`, `date_entered`, `date_updated`, `date_timestamped`) VALUES (1, 1, 2, '2006-10-15 10:40:16', NULL, '2006-10-15 15:20:34');
# TRUNCATE TABLE cvazquezblog.`seriesentries`;

INSERT INTO cvazquezblog.`seriesentries` (seriesId, entryId, sequence, createdAt, updatedAt)
SELECT `related_id`, `blog_id`, `order_id`, `date_entered`, `date_updated`
FROM cvazquezold.`blogs_related`
ORDER BY related_id, blog_id;


# categories
INSERT INTO cvazquezblog.categories (id, name, deletedAt, createdAt, updatedAt)
SELECT category_id,category_name,
	CASE `is_active`
	WHEN 0 THEN
		IF (`date_updated` IS NOT NULL AND `date_updated` > 0, `date_updated`, NOW())
	ELSE NULL
	END,
	date_entered,date_updated
FROM cvazquezold.blog_categories
ORDER BY category_id;

# category entry mapping
INSERT INTO cvazquezblog.entrycategories (entryId, categoryId, deletedAt, createdAt, updatedAt)
SELECT blog_id,category_id,
	CASE `is_active`
	WHEN 0 THEN
		IF (`date_updated` IS NOT NULL AND `date_updated` > 0, `date_updated`, NOW())
	ELSE NULL
	END,
	date_entered,date_updated
FROM cvazquezold.blogs
ORDER BY blog_id, category_id;

# discussions - See ConvertLoop


# pictures
INSERT INTO cvazquezblog.entrypictures (id, entryId, title, description, sequence, extension, takenAt, createdAt, deletedAt)
SELECT `pic_id`, `blog_id`, `pic_title`, `pic_description`, `pic_order`, `pic_ext`, `pic_datetime`, `date_entered`,
	CASE `is_active`
	WHEN 0 THEN
		IF (`date_updated` IS NOT NULL AND `date_updated` > 0, `date_updated`, NOW())
	ELSE NULL
	END
FROM cvazquezold.blog_pics
ORDER BY pic_id;


