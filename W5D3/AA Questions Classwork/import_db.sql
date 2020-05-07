PRAGMA foreign_keys      ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(64),
    last_name VARCHAR(64)
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(256),
    body TEXT,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT,

    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(first_name, last_name)
VALUES
  ('Okey', 'Mbanugo'),
  ('Leo', 'Li');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Title of our question', 'Body of our question', (
    SELECT id FROM users WHERE first_name = 'Okey'
  )),
  ('Title of our second question', 'Body of our second question', (
    SELECT id FROM users WHERE first_name = 'Leo'
  ));

INSERT INTO
  question_follows(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Title of our question'),
  (SELECT id FROM users WHERE first_name = 'Leo'));

INSERT INTO
  replies(question_id, user_id, body)
VALUES
    (1, 1, 'reply'),
    (2, 2, '2nd reply');

INSERT INTO
  question_likes(question_id, user_id)
VALUES
    (1, 1),
    (2, 2);
