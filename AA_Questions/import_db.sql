DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body  TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id) 
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Herp', 'Derp'),
  ('Mr.', 'Rogers');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Herp Derp', 'HERP DERP?', (SELECT id FROM users WHERE fname = 'Herp' AND lname = 'Derp')),
  ('Mr.', 'Won''t you be my neighbor?', (SELECT id FROM users WHERE fname = 'Mr.' AND lname = 'Rogers'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Herp'), (SELECT id FROM questions WHERE body = 'HERP DERP?')),
  ((SELECT id FROM users WHERE fname = 'Mr.'), (SELECT id FROM questions WHERE body = 'Won''t you be my neighbor?'));

INSERT INTO
  replies (body, user_id, question_id, parent_reply_id)
VALUES
  ('DERP HERP!', (SELECT id FROM users WHERE fname = 'Herp'), (SELECT id FROM questions WHERE body = 'HERP DERP?'), 
    (SELECT id FROM replies WHERE parent_reply_id = id)),
  ('It''s a beautiful day in the neighborhood', (SELECT id FROM users WHERE fname = 'Mr.'), (SELECT id FROM questions WHERE body = 'Won''t you be my neighbor?'), 
    (SELECT id FROM replies WHERE parent_reply_id = id));

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Herp'), (SELECT id FROM questions WHERE body = 'HERP DERP?')),
  ((SELECT id FROM users WHERE fname = 'Mr.'), (SELECT id FROM questions WHERE body = 'Won''t you be my neighbor?'));







