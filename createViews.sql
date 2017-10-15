CREATE VIEW VIEW_USER_INFORMATION 
(
user_id,
first_name,
last_name,
year_of_birth,
month_of_birth,
day_of_birth,
gender,
hometown_city,
hometown_state,
hometown_country,
current_city,
current_state,
current_country,
institution_name,
program_year,
program_concentration,
program_degree
)
AS SELECT
u.user_id,
u.first_name,
u.last_name,
u.year_of_birth,
u.month_of_birth,
u.day_of_birth,
u.gender,	
x.city_name,
x.state_name,
x.country_name,
y.city_name,
y.state_name,
y.country_name,
p.institution,
e.program_year,
p.concentration,
p.degree
FROM users u
LEFT JOIN user_current_city c1 ON u.user_id = c1.user_id
LEFT JOIN cities x ON x.city_id = c1.current_city_id
LEFT JOIN user_hometown_city c2 ON u.user_id = c2.user_id
LEFT JOIN cities y ON y.city_id = c2.hometown_city_id
LEFT JOIN education e ON u.user_id = e.user_id
LEFT JOIN programs p ON e.program_id = p.program_id;

CREATE VIEW VIEW_ARE_FRIENDS 
(
user1_id, 
user2_id
)
AS SELECT 
user1_id, 
user2_id 
FROM FRIENDS;

CREATE VIEW VIEW_PHOTO_INFORMATION 
(
album_id, 
owner_id, 
cover_photo_id, 
album_name, 
album_created_time, 
album_modified_time, 
album_link, 
album_visibility, 
photo_id, 
photo_caption, 
photo_created_time, 
photo_modified_time, 
photo_link
)
AS SELECT DISTINCT
a.album_id, 
a.album_owner_id, 
a.cover_photo_id, 
a.album_name, 
a.album_created_time, 
a.album_modified_time, 
a.album_link, 
a.album_visibility, 
p.photo_id, 
p.photo_caption, 
p.photo_created_time, 
p.photo_modified_time, 
p.photo_link
FROM ALBUMS a, PHOTOS p
WHERE a.ALBUM_ID = p.ALBUM_ID;

CREATE VIEW VIEW_TAG_INFORMATION 
(
photo_id, 
tag_subject_id, 
tag_created_time, 
tag_x_coordinate, 
tag_y_coordinate
)
AS SELECT DISTINCT
t.tag_photo_id, 
t.tag_subject_id, 
t.tag_created_time, 
t.tag_x, t.tag_y
from tags t;

CREATE VIEW VIEW_EVENT_INFORMATION 
(
event_id, 
event_creator_id, 
event_name, 
event_tagline, 
event_description, 
event_host, 
event_type, 
event_subtype, 
event_location, 
event_city, 
event_state, 
event_country, 
event_start_time, 
event_end_time
)
AS SELECT DISTINCT
e.event_id, 
e.event_creator_id, 
e.event_name, 
e.event_tagline, 
e.event_description, 
e.event_host, 
e.event_type, 
e.event_subtype, 
e.event_address, 
c.city_name, 
c.state_name, 
c.country_name, 
e.event_start_time, 
e.event_end_time
FROM user_events e, cities c
WHERE e.event_city_id = c.city_id;





