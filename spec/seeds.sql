DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  username text,
  email text,
  password varchar
);

DROP TABLE IF EXISTS posts CASCADE;
-- Create the second table.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  peep text,
  time timestamp,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

DROP TABLE IF EXISTS comments CASCADE;

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    comment text,
    time timestamp,
    post_id int,
    constraint fk_post foreign key(post_id)
        references posts(id)
        on delete cascade
);


DROP TABLE IF EXISTS tags CASCADE;

CREATE TABLE tags (
    tag text,
    post_id int,
    user_id int,
    constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade,
    constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade,
    PRIMARY KEY (post_id, user_id)
);

TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments RESTART IDENTITY CASCADE;
TRUNCATE TABLE tags RESTART IDENTITY CASCADE;

INSERT INTO users (name, username, email, password) VALUES
('John Smith', 'JS', 'js@gmail.com', 'passwordJS'),
('Nikki Wong', 'NickNack', 'nicknack@gmail.com', 'password2'),
('Liam Banks', 'Liam', 'liambanks@gmail.com', 'password3');

INSERT INTO posts (peep, time, user_id) VALUES ('this is my first post', 'Jan-08-2023 10:30', 1),
('Any film recommends?', 'Jan-09-2023 14:00', 2);

INSERT INTO comments (comment, time, post_id) VALUES ('Welcome to chitter!', 'Jan-08-2023 11:00', 1),
('yes! Everything Everywhere film!', 'Jan-09-2023 12:00', 2);

INSERT INTO tags (tag, post_id, user_id) VALUES
('NickNack', 1, 2),
('Liam', 2, 3);

ALTER TABLE tags ADD FOREIGN KEY (post_id) REFERENCES posts(id);
ALTER TABLE tags ADD FOREIGN KEY (user_id) REFERENCES users(id);
