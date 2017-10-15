INSERT INTO USERS (
user_id, 
first_name,
last_name,
year_of_birth,
month_of_birth,
day_of_birth,
gender
) SELECT DISTINCT 
user_id,
first_name,
last_name,
year_of_birth,
month_of_birth,
day_of_birth,
gender 
FROM jsoren.PUBLIC_USER_INFORMATION
WHERE 
user_id IS NOT NULL
AND first_name IS NOT NULL
AND last_name IS NOT NULL;


INSERT INTO CITIES (
city_name,
state_name,
country_name
) SELECT DISTINCT 
current_city,
current_state,
current_country
FROM jsoren.PUBLIC_USER_INFORMATION
UNION
SELECT DISTINCT
hometown_city,
hometown_state,
hometown_country 
FROM jsoren.PUBLIC_USER_INFORMATION
UNION
SELECT DISTINCT 
event_city,
event_state,
event_country
FROM jsoren.PUBLIC_EVENT_INFORMATION;


INSERT INTO user_current_city (
user_id, 
current_city_id
) SELECT DISTINCT 
p.user_id, 
c.city_id
FROM jsoren.PUBLIC_USER_INFORMATION p, CITIES c
WHERE p.current_city = c.city_name
AND p.current_state = c.state_name
AND p.current_country = c.country_name;


INSERT INTO USER_HOMETOWN_CITY 
(
user_id,
hometown_city_id
) SELECT DISTINCT 
p.user_id,
c.city_id
FROM jsoren.PUBLIC_USER_INFORMATION p, CITIES c
WHERE p.hometown_city = c.city_name
AND p.hometown_state = c.state_name
AND p.hometown_country = c.country_name;


INSERT INTO PROGRAMS 
(
institution,
concentration,
degree
) SELECT DISTINCT 
institution_name,
program_concentration,
program_degree
FROM jsoren.PUBLIC_USER_INFORMATION p
WHERE p.institution_name IS NOT NULL 
AND p.program_concentration IS NOT NULL 
AND p.program_degree IS NOT NULL;


INSERT INTO EDUCATION 
(
user_id,
program_id,
program_year
) SELECT DISTINCT 
p.user_id,
r.program_id,
p.program_year
FROM PROGRAMS r, jsoren.PUBLIC_USER_INFORMATION p
WHERE p.institution_name = r.institution
AND p.program_concentration = r.concentration
AND p.program_degree = r.degree;

INSERT INTO FRIENDS (
user1_id,
user2_id
) SELECT DISTINCT 
user1_id,
user2_id
FROM jsoren.PUBLIC_ARE_FRIENDS
WHERE CAST (user1_id as number) < CAST (user2_id as number)
UNION
SELECT DISTINCT
user2_id,
user1_id
from jsoren.PUBLIC_ARE_FRIENDS
WHERE CAST (user1_id as number) > CAST (user2_id as number);


INSERT INTO USER_EVENTS 
(
event_id, 
event_creator_id, 
event_name, 
event_tagline, 
event_description, 
event_host, 
event_type, 
event_subtype, 
event_address, 
event_city_id, 
event_start_time, 
event_end_time
) SELECT DISTINCT 
p.event_id, 
p.event_creator_id, 
p.event_name, 
p.event_tagline, 
p.event_description, 
p.event_host, 
p.event_type, 
p.event_subtype, 
p.event_address, 
c.city_id, 
p.event_start_time, 
p.event_end_time
FROM CITIES c, jsoren.PUBLIC_EVENT_INFORMATION p
WHERE 
p.event_city = c.city_name
AND p.event_state = c.state_name
AND p.event_country = c.country_name;


SET AUTOCOMMIT OFF
SET CONSTRAINT cover_photo DEFERRED;


INSERT INTO ALBUMS (
album_id, 
album_owner_id, 
album_name, 
album_created_time, 
album_modified_time, 
album_link, 
album_visibility, 
cover_photo_id
) SELECT DISTINCT 
album_id, 
owner_id, 
album_name, 
album_created_time, 
album_modified_time, 
album_link, 
album_visibility, 
cover_photo_id
FROM jsoren.PUBLIC_PHOTO_INFORMATION
WHERE
album_id IS NOT NULL
AND album_name IS NOT NULL
AND owner_id IS NOT NULL
AND album_link IS NOT NULL
AND cover_photo_id IS NOT NULL
AND album_visibility IS NOT NULL
AND album_created_time IS NOT NULL
AND (UPPER(album_visibility) = 'EVERYONE'
OR UPPER(album_visibility) = 'FRIENDS'
OR UPPER(album_visibility) = 'FRIENDS_OF_FRIENDS'
OR UPPER(album_visibility) = 'MYSELF'
OR UPPER(album_visibility) = 'CUSTOM');

INSERT INTO PHOTOS (
album_id, 
photo_id, 
photo_caption, 
photo_created_time, 
photo_modified_time, 
photo_link
) SELECT DISTINCT 
album_id, 
photo_id, 
photo_caption, 
photo_created_time, 
photo_modified_time, 
photo_link
FROM jsoren.PUBLIC_PHOTO_INFORMATION
WHERE PHOTO_ID IS NOT NULL
AND photo_created_time IS NOT NULL
AND photo_link IS NOT NULL
AND album_id IS NOT NULL;

COMMIT;
SET AUTOCOMMIT ON


INSERT INTO TAGS (
tag_photo_id, 
tag_subject_id, 
tag_created_time, 
tag_x, 
tag_y
) SELECT DISTINCT 
photo_id, 
tag_subject_id, 
tag_created_time, 
tag_x_coordinate, 
tag_y_coordinate
FROM jsoren.PUBLIC_TAG_INFORMATION
WHERE photo_id IS NOT NULL
AND tag_subject_id IS NOT NULL
AND tag_created_time IS NOT NULL
AND tag_x_coordinate IS NOT NULL
AND tag_y_coordinate IS NOT NULL;