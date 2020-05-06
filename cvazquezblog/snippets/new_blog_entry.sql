select * from entries
order by id desc
limit 1;

select * from entryurls
order by entryId desc
limit 1;

select * from categories;

select * from entrycategories
order by entryId desc
limit 2;

INSERT INTO entrycategories (entryId, categoryId, createdAt)
VALUES (173, 4, now());

INSERT INTO entryurls (entryId, titleURL, isActive, createdAt)
VALUES (8, CreateTitleURL("Zabaglione - Egg White and Marsala Wine Dessert"), 1, now());