delimiter $$

DROP FUNCTION IF EXISTS cvazquezblog.StripHTML$$

CREATE FUNCTION cvazquezblog.StripHTML( Dirty text )
RETURNS text
DETERMINISTIC
SQL SECURITY DEFINER
BEGIN
  DECLARE iStart, iEnd, iLength int;
    WHILE Locate( '<', Dirty ) > 0 And Locate( '>', Dirty, Locate( '<', Dirty )) > 0 DO
      BEGIN
        SET iStart = Locate( '<', Dirty ), iEnd = Locate( '>', Dirty, Locate('<', Dirty ));
        SET iLength = ( iEnd - iStart) + 1;
        IF iLength > 0 THEN
          BEGIN
            SET Dirty = Insert( Dirty, iStart, iLength, '');
          END;
        END IF;
      END;
    END WHILE;
    RETURN Dirty;
END;

$$

GRANT EXECUTE ON FUNCTION cvazquezblog.StripHTML TO 'lucee'@'localhost';