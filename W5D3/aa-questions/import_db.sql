PRAGMA foreign_keys = ON;
DROP TABLE if exists users;
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE if exists questions;
CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    aa_id INTEGER NOT NULL,
    FOREIGN KEY(aa_id) REFERENCES users(id)
);

DROP TABLE if exists question_follows;
CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,
    FOREIGN KEY(users_id) REFERENCES users(id)
    FOREIGN KEY(questions_id) REFERENCES questions(id)
);

DROP TABLE if exists replies;
CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    parent_id INTEGER REFERENCES replies(id),
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,
    FOREIGN KEY(users_id) REFERENCES users(id)
    FOREIGN KEY(questions_id) REFERENCES questions(id)
);

DROP TABLE if exists question_likes;
CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,   
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,
    FOREIGN KEY(users_id) REFERENCES users(id)
    FOREIGN KEY(questions_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
        ('Bob', 'Smith'),
        ('Joe', 'Schmo');

INSERT INTO
--   ('All My Sons', 1947, (SELECT id FROM playwrights WHERE name = 'Arthur Miller'))
    questions (title, body, aa_id)
VALUES
    ('a', 'aaaaaa', (SELECT id FROM users WHERE fname = 'Bob'));

INSERT INTO
    question_follows (users_id, questions_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Joe'), (SELECT id FROM questions WHERE title = 'a'));
