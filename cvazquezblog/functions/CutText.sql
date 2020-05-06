delimiter $$

DROP FUNCTION IF EXISTS cvazquezblog.CutText$$

CREATE FUNCTION cvazquezblog.CutText( myText varchar(4000), cutOffLength INT, trailingText varchar(10))
RETURNS varchar(4000)
DETERMINISTIC
BEGIN
  DECLARE newText VARCHAR(5000);
  DECLARE x INT;
  DECLARE thisChar CHAR(1);

	SET newText = myText;
	SET x = cutOffLength;

	SET newText = TRIM(REPLACE(REPLACE(REPLACE(StripHTML(newText), char(13), ""), char(10), ""), char(9), " "));

	IF (length(newText) > cutOffLength) THEN
	    thisLoop: WHILE (x < length(myText)) DO
	      BEGIN
	      	SET thisChar = trim(substring(newText, x, 1));
	        IF (thisChar = '') THEN
	        	SET newText = concat(trim(left(newText, x)), trailingText);
	        	LEAVE thisLoop;
	        END IF;

			SET x = x + 1;
	      END;
	    END WHILE thisLoop;
	END IF;

    RETURN newText;
END;

$$

GRANT EXECUTE ON FUNCTION cvazquezblog.CutText TO 'lucee'@'localhost';
GRANT EXECUTE ON FUNCTION cvazquezblog.CutText TO 'lucee_i'@'localhost';
