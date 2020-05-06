CREATE DATABASE cvazquezblogcake;


create user blog_trig_user@localhost IDENTIFIED WITH mysql_native_password by '...';
GRANT ALL PRIVILEGES ON `cvazquezblog`.* TO `blog_trig_user`@'localhost';
GRANT ALL PRIVILEGES ON `cvazquezblogcake`.* TO `blog_trig_user`@`localhost`;

create user blog_func_user@localhost identified by '...';
GRANT ALL PRIVILEGES ON `cvazquezblog`.* TO `blog_func_user`@'localhost';
GRANT ALL PRIVILEGES ON `cvazquezblogcake`.* TO `blog_func_user`@`localhost`;


DROP VIEW cvazquezblogcake.posts;
CREATE DEFINER = `blog_view_user`@`localhost`
    SQL SECURITY DEFINER
    VIEW cvazquezblogcake.posts (`id`, `post_id`, `title`, `teaser`, `body`, `metaDescription`, `metaKeyWords`, `publishAt`, `created`, `modified`, `updatedBy`, `deletedAt`, `deletedBy`, `user_id`)
    AS
	 SELECT `id`, `entryId`, `title`, `teaser`, `content`, `metaDescription`, `metaKeyWords`, `publishAt`, `createdAt`, `updatedAt`, `updatedBy`, `deletedAt`, `deletedBy`, `createdBy`
	 FROM cvazquezblog.entries
    WITH  CHECK OPTION;


GRANT SELECT, INSERT, UPDATE ON `cvazquezblogcake`.`posts` TO 'cakeUser'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cvazquezblog.entries TO blog_view_user@localhost;

SELECT * from cvazquezblogcake.posts
limit 10;


DROP VIEW IF EXISTS cvazquezblogcake.categories;
CREATE DEFINER = `blog_view_user`@`localhost`
    SQL SECURITY DEFINER
    VIEW cvazquezblogcake.categories (`id`, `category_id`, `name`, `created`, `createdBy`, `modified`, `updatedBy`, `deletedAt`, `deletedBy`, `timestampAt`)
    AS
	 SELECT `id`, `categoryId`, `name`, `createdAt`, `createdBy`, `updatedAt`, `updatedBy`, `deletedAt`, `deletedBy`, `timestampAt`
	 FROM cvazquezblog.categories
    WITH  CHECK OPTION;

GRANT SELECT ON cvazquezblogcake.categories TO 'cakeUser'@'localhost';
show grants for 'cakeUser'@'localhost';

GRANT SELECT ON cvazquezblog.categories TO blog_view_user@localhost;


DROP VIEW IF EXISTS cvazquezblogcake.categories_posts;
CREATE DEFINER = `blog_view_user`@`localhost`
    SQL SECURITY DEFINER
    VIEW cvazquezblogcake.categories_posts (`id`, `post_id`, `category_id`, `created`, `createdBy`, `modified`, `updatedBy`, `deletedAt`, `deletedBy`, `timestampAt`)
    AS
	 SELECT `id`, `entryId`, `categoryId`, `createdAt`, `createdBy`, `updatedAt`, `updatedBy`, `deletedAt`, `deletedBy`, `timestampAt`
	 FROM cvazquezblog.entrycategories
    WITH  CHECK OPTION;

#revoke delete ON cvazquezblogcake.categories_posts from 'cakeUser'@'localhost';
#revoke delete ON cvazquezblog.entrycategories from blog_view_user@localhost;
GRANT SELECT, DELETE, INSERT ON cvazquezblogcake.categories_posts TO 'cakeUser'@'localhost';
GRANT SELECT, DELETE, INSERT ON cvazquezblog.entrycategories TO blog_view_user@localhost;


DROP VIEW IF EXISTS cvazquezblogcake.users;
CREATE DEFINER = `blog_view_user`@`localhost`
    SQL SECURITY DEFINER
    VIEW cvazquezblogcake.users (`id`, username, `password`, role, `created`, `createdBy`, `modified`, `updatedBy`, `deletedAt`, `deletedBy`, `timestampAt`)
    AS
	 SELECT `id`, handle, passwd, if(handle = "xxxxx", "admin", "") AS username, `createdAt`, `createdBy`, `updatedAt`, `updatedBy`, `deletedAt`, `deletedBy`, `timestampAt`
	 FROM cvazquezblog.users
    WITH  CHECK OPTION;

GRANT SELECT ON cvazquezblogcake.users TO 'cakeUser'@'localhost';
GRANT SELECT ON cvazquezblog.users TO blog_view_user@localhost;


DROP VIEW IF EXISTS cvazquezblogcake.admin_settings;
CREATE DEFINER = `blog_view_user`@`localhost`
    SQL SECURITY DEFINER
    VIEW cvazquezblogcake.admin_settings (`id`, name, value, deletedAt)
    AS
	 SELECT id, name, value, deletedAt
	 FROM cvazquezblog.adminsettings
    WITH  CHECK OPTION;

GRANT SELECT ON cvazquezblogcake.admin_settings TO 'cakeUser'@'localhost';
GRANT SELECT ON cvazquezblog.adminsettings TO blog_view_user@localhost;



DROP VIEW IF EXISTS cvazquezblogcake.entry_drafts;
CREATE DEFINER = `blog_view_user`@`localhost`
    SQL SECURITY DEFINER
    VIEW cvazquezblogcake.entry_drafts (`id`, entry_id, content, created)
    AS
	 SELECT id, entryId, content, createdAt
	 FROM cvazquezblog.entrydrafts
    WITH  CHECK OPTION;

GRANT SELECT, INSERT, UPDATE ON cvazquezblogcake.entry_drafts TO 'cakeUser'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cvazquezblog.entrydrafts TO blog_view_user@localhost;



show grants for 'cakeUser'@'localhost';
