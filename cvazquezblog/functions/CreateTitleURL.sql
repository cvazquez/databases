CREATE
	DEFINER = blog_func_user@localhost
	FUNCTION CreateTitleURL(title VARCHAR(250))
	RETURNS VARCHAR(250) DETERMINISTIC

	RETURN convert(PREG_REPLACE('/[ \t\.]+/', '-',
		PREG_REPLACE('/[^A-Za-z0-9 \t\.]+/', '' , trim(title))
	)
	USING UTF8)
;


GRANT execute ON FUNCTION cvazquezblog.CreateTitleURL  TO 'blog_func_user'@'localhost';
GRANT execute ON FUNCTION cvazquezblog.CreateTitleURL  TO 'blog_trig_user'@'localhost';
GRANT execute ON FUNCTION cvazquezblog.CreateTitleURL  TO 'lucee'@'localhost';

#GRANT execute ON FUNCTION cvazquezblog.PREG_REPLACE TO 'blog_func_user'@'localhost'