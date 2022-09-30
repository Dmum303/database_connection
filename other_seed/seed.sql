TRUNCATE TABLE user_accounts, posts RESTART IDENTITY; -- replace with your own table name.



INSERT INTO user_accounts (email_address, username) VALUES ('abc@gmail.com', 'abc123');
INSERT INTO user_accounts (email_address, username) VALUES ('xyz@gmail.com', 'xyz123');


INSERT INTO posts (title, content, views, user_account_id) VALUES ('birthday', 'meal', 1, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('anniversary', 'happy', 3, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('wedding', 'congrats', 2, 2);

-- this is from a diff project I was working on