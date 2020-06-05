CREATE
	DEFINER = blog_func_user@localhost
	FUNCTION CreateTitleURL(title VARCHAR(250))
	RETURNS VARCHAR(250) DETERMINISTIC

	RETURN convert(REGEXP_REPLACE(REGEXP_REPLACE(trim(title), '[^A-Za-z0-9 \t\.]+', ''), '[ \t\.]+', '-')
	USING UTF8)
;

GRANT EXECUTE ON FUNCTION cvazquezblog.CreateTitleURL  TO 'blog_func_user'@'localhost';
GRANT EXECUTE ON FUNCTION cvazquezblog.CreateTitleURL  TO 'blog_trig_user'@'localhost';
GRANT EXECUTE ON FUNCTION cvazquezblog.CreateTitleURL  TO 'nodeuser'@'localhost';