USE boxers;

-- Heavyweights
INSERT INTO `boxer` (`id`, `division_id`, `boxrec_id`, `name`, `nationality`, `dob`, `record`, `home_town`,
                     `snippet`, `twitter`, `enabled`)
VALUES (999, 1, 474, 'Mike Tyson', 'US', '1966-06-30', '50-6-0', 'Brooklyn, New York',
        'The baddest man on the planet!', null, 1),
       (1000, 1, 499, 'Evander Holyfield', 'US', '1962-10-19', '44-10-2', 'Atlanta, Georgia',
        'He was the real deal.', 'holyfield', 1),
       (1001, 1, 1853, 'Lennox Lewis', 'GB', '1965-09-02', '41-2-1', 'West Ham, London',
        'Olympic gold medallist for Canada', null, 1),
       (1002, 1, 1640, 'Riddick Bowe', 'US', '1968-08-10', '43-1-0', 'Brooklyn, New York',
        'They called him Big Daddy.', null, 1),
       (1003, 1, 4345, 'Andrew Golota', 'PL', '1968-01-05', '41-9-1', 'Warsaw, Poland',
        'Trained by Lou Duva.', null, 1);

-- Middleweights
INSERT INTO `boxer` (`id`, `division_id`, `boxrec_id`, `name`, `nationality`, `dob`, `record`, `home_town`,
                     `snippet`, `twitter`, `titles`, `enabled`)
VALUES (998, 5, 774820, 'Roy Jones Jr', 'US', '1969-01-16', '65-9-0', 'Pensacola, Florida',
        'So good he didn\'t need a nick name.', null, null, 1),
       (997, 5, 1437, 'James Toney', 'US', '1968-08-24', '77-10-3', 'Grand Rapids, Michigan',
        'His middle name was \'Light Out\'.', 'RealJamesToney', 'WBC, WBA', 1),
       (996, 5, 447, 'Iran Barkley', 'US', '1960-05-06', '43-19-1', 'The Bronx, New York',
        'He was known as \'The Blade\'.', null, null, 1),
       (995, 5, 804, 'Chris Eubank', 'GB', '1966-08-08', '45-5-2', 'Dulwich, London',
        'Simply the best!', null, null, 1),
       (994, 5, 739, 'Nigel Benn', 'GB', '1964-01-22', '42-5-1', 'Ilford, Essex',
        'They called him \'The Dark Destroyer\'.', null, null, 0);

-- Ratings
INSERT INTO `rating` (`division_id`, `boxer_id`, `rating`, `points`)
VALUES (1, 999, 1, 599),
       (1, 1000, 3, 597),
       (1, 1001, 2, 598),
       (1, 1002, 4, 596),
       (5, 998, 1, 400),
       (5, 997, 2, 300),
       (5, 994, 4, 100),
       (5, 995, 3, 200);

-- Users
INSERT INTO `user` (`id`, `name`, `email`, `active`, `confirmed`, `password`, `fingerprint`)
VALUES (996, 'Billy', 'billy-test@gmail.com', 1, 0, '$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq',
        '179bfcfa80c41e8342a91c4fcfc3c91e'),
       (997, 'Bobby', 'bobby-test@gmail.com', 0, 0, '$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq',
        '179bfcfa80c41e8342a91c4fcfc3c91e'),
       (998, 'Jimmy', 'jimmy-test@gmail.com', 0, 0, '$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq',
        '179bfcfa80c41e8342a91c4fcfc3c91e'),
       (999, 'Tommy', 'tommy-test@gmail.com', 1, 1, '$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq',
        '179bfcfa80c41e8342a91c4fcfc3c91e'),
       (1000, 'Andy', 'andy-test@gmail.com', 1, 1, '$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq',
        '179bfcfa80c41e8342a91c4fcfc3c91e');

-- Email Queue
INSERT INTO `email_queue` (user_id, type, token, created_at, sent_at)
VALUES (1000, 'resetPassword', 'vg4JPwDpaFlzm+hXfuxpyWyhj7YqHkHq6G+hUifqlAnWu2DuPHdOZoJfYGJlMgv8YEZaqEEfwVe48dfx',
        '2019-11-01 23:59:59', NULL),
       (996, 'signupConfirmation', 'vg4JPwDpaFlzm+hXfuxpyWyhj7YqHkHq6G+hUifqlAnWu2DuPHdOZoJfYGJlMgv8YEZaqEEfwVe48dfx',
        '2019-11-01 21:30:00', NULL),
       (999, 'signupConfirmation', 'vg4JPwDpaFlzm+hXfuxpyWyhj7YqHkHq6G+hUifqlAnWu2DuPHdOZoJfYGJlMgv8YEZaqEEfwVe48dfx',
        '2019-11-01 23:59:59', '2019-11-02 01:03:45');

-- Password Tokens
INSERT INTO `password_token` (`user_id`, `token`, `created_at`, `updated_at`)
VALUES (999, 'vg4JPwDpaFlzm+hXfuxpyWyhj7YqHkHq6G+hUifqlAnWu2DuPHdOZoJfYGJlMgv8YEZaqEEfwVe48dfx',
        '2019-10-24 12:00:00', '2019-10-24 12:00:00');

-- User Ratings
INSERT INTO `heavyweight_user_rating` (`user_id`, `boxer_id`, `rating`)
VALUES (999, 1002, 1),
       (999, 999, 2),
       (999, 1000, 3),
       (1000, 1002, 1),
       (1000, 999, 2),
       (1000, 1000, 3);

-- P4P Ratings
INSERT INTO `p4p_rating` (`boxer_id`, `rating`)
VALUES (998, 1),
       (997, 2),
       (999, 3);