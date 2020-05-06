/*
Filename: ...\[Database Name]\table.sql
Date: mm/dd/yyyy
Last Updated: mm/dd/yyyy
DB Developer: Firstname Lastname (name@yourdomain.com)
Purpose: [Add to table comment]
Notes: any other important information here.
Project Folder(s):
(date) Full path location to any project folder or documents referring to this table.
*/

CREATE TABLE database.tableName
(
	id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	foriegnTable2Id /* Name with the full table name in singular with _id appended */
	foriegnTable3Id
	attribute1
	attribute2
	attribute3
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
  
) comment = "Short description of table and how it relates to other tables. Maybe note application used for."
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  

/*
Update History

Date: Date of this update
DB Developer: Your name here
Purpose: Include the reason for this change
Project Location: The location of the project this changes applies to
This is where you put the statement you ran to modify the table:
i.e. Alter table database.tablename add col10 int not null after col11;

Example: Change position of field in table
ALTER TABLE tablename MODIFY [COLUMN] column_definition [FIRST | AFTER col_name]
*/

*******************************
EVERYTHING BELOW THIS LINE CAN BE ERASED IN YOUR COPY
*******************************

Field types and sizes
=====================
ID's can be tinyint, smallint, mediumint, int, bigint. Choice will need to be made when designing.
Make IDs unsigned so you get the maximum storage, unless you need negative numbers.

NULL and NOT NULL: Make a decision on whether to make fields NULL or NOT NULL

Foreign Keys should share the same size as the corresponding foreign tables Primary Key size. 
If the foreign tables Primary Key size every changes, all Foreign Key sizes will need to change here too.

Attributes can be any field type. You might have to choose a larger field type at first, if you don't know the expected size of your data.
In the future, you can audit the tables and determine what the largest data size used is and resize based on this information.


Order of fields:
Primary Key
Foreign Keys - list most to least important or most common to least common
Attributes - list most to least important or most common to least common
Decision - list most to least important or most common to least common
Date - Use fields in basic design below

--------------------------- BEGIN BASIC DESIGN------------------------------------

Table name: basic_entities (should be plural)
/* 
* Don't prepend database name.
* Make descriptive but generic (ie. If applicable, design to work for different products, clients...)
*/

CREATE TABLE basic_entities
(
	id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	foriegnRable2Id /* Name with the full table name in singular with Id appended */
	foriegnTable3Id
	attribute1
	attribute2
	attribute3
  `createdAt` datetime NULL,
  `createdBy` mediumint unsigned NULL,
  `updatedAt` datetime NULL,
  `updatedBy` mediumint unsigned NULL,
  `deletedAt` DATETIME NULL,
  `deletedBy` mediumint unsigned NULL,
  `timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
) comment = "Short description of table and how it relates to other tables. Maybe note application used for."
  ENGINE=INNODB DEFAULT CHARSET=utf8;


OPTIONAL FIELDS:
sourceId    --->    sources
dbSourceId    ---->    dbSources



---------------------------END BASIC DESIGN ------------------------------------

-------------------------- BEGIN STATUS DESIGN----------------------------------
-------------------------- END STATUS DESIGN ------------------------------------

-------------------------- BEGIN SOURCE DESIGN----------------------------------
id


-------------------------- END SOURCE DESIGN ------------------------------------




Techniques
----------
load data local infile 'Q:\\\\PATH\\TO\\FOLDER\\AND\\COMMA\\OR\\TAB\\DELIMITED\\FILE.txt'
INTO TABLE [yourtable] (field1, field2, field3, fieldn);


update table
set bad_text = trim(replace(bad_text, '"', ""));

update table
set bad_text = trim(replace(bad_text, char(13), ""));

Update table
Set page_title = Replace(page_title, char(160), '');
