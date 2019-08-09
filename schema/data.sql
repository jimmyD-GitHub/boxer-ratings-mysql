USE boxers;

INSERT INTO `user` (`id`, `name`, `email`, `password`, `created_at`, `active`, `confirmed`)
VALUES (999, 'Jimmy', 'jamesalandixon@gmail.com', '$2y$10$gNWX2jS.gemnaimVh6yn5eXGj.Nf4hwuYafbC.nFYxcIrq14.b0Om',
        '2018-07-27 14:45:45', 1, 1);

INSERT INTO `boxer` (`id`, `division_id`, `boxrec_id`, `name`, `nationality`, `dob`, `record`, `home_town`, `snippet`,
                     `twitter`, `enabled`, `created_at`, `updated_at`, `deleted_at`)
VALUES (1, 1, 659461, 'Anthony Joshua', 'GB', '1989-10-15', '21-0-0', 'Watford, Hertfordshire',
        'Charismatic and athletic, the 6\'6\" Joshua established himself as the biggest attraction in boxing with a thrilling victory over Wladimir Klitchsko. An enticing unification showdown with WBC champion Deontay Wilder lies in wait some time in 2019.',
        'anthonyfjoshua', 1, '2018-09-06 10:26:08', '2018-09-07 16:08:19', NULL),
       (2, 1, 468841, 'Deontay Wilder', 'US', '1985-10-22', '40-0-0', 'Tuscaloosa, Alabama',
        '\"The Bronze Bomber\" showed his formidable KO power when overcoming adversity to vanquish previously undefeated challenger Luis Ortiz. Potential match ups with British rivals Anthony Joshua and Tyson Fury appear to be high on his agenda.',
        'BronzeBomber', 1, '2018-09-06 10:47:13', '2018-09-07 16:09:00', NULL),
       (3, 1, 318081, 'Alexander Povetkin', 'RU', '1979-09-02', '34-1-0', 'Kursk, Russia',
        'The hard hitting former Olympic gold medalist has earned a shot at Anthony Joshua\'s world titles by knocking out David Price in spectacular fashion. Povetkin is hoping to regain the WBA championship belt he lost to Wladimir Klitschko.',
        NULL, 1, '2018-09-06 14:05:23', '2018-09-06 15:13:02', NULL),
       (4, 1, 528949, 'Luis Ortiz', 'CU', '1979-03-29', '29-1-0', 'Camaguey, Cuba',
        'The skilful southpaw veteran is hoping to bounce back after running Deontay Wilder very close in a WBC title challenge. Despite that defeat he remains one of the most technically accomplished heavyweights in the division.',
        NULL, 1, '2018-09-06 14:24:36', '2018-09-06 14:27:09', NULL),
       (5, 1, 569964, 'Dillian Whyte', 'GB', '2011-05-13', '24-1-0', 'Brixton, London',
        'After impressive victories over Joseph Parker and Lucas Browne \"The Body Snatcher\" seems close to earning a rematch with promotional stable mate Anthony Joshua. Whyte\'s only loss to date came at the hands of his British rival.',
        'DillianWhyte', 1, '2018-09-06 14:44:35', '2018-09-07 16:10:27', NULL),
       (6, 1, 613846, 'Joseph Parker', 'NZ', '1992-01-09', '24-2-0', 'South Auckland, New Zealand',
        'The amiable Kiwi was on the wrong side of decision losses when facing Anthony Joshua and Dillian Whyte in the UK. However, the speedy young contender and former WBO title holder has plenty of time left to re-establish himself on the world scene.',
        'joeboxerparker', 1, '2018-09-06 15:24:59', '2018-09-07 16:11:07', NULL),
       (7, 1, 498837, 'Jarrell Miller', 'US', '1988-07-15', '20-0-1', 'Brooklyn, New York',
        'This slick New Yorker is looking to gatecrash the upper echelons of the heavyweight division. The 280 pounder, known as \"Big Baby\", will be hoping to make a statement when he takes on the hugely experienced Tomasz Adamek next.',
        NULL, 1, '2018-09-06 15:47:16', '2018-09-06 15:49:57', NULL),
       (8, 1, 479205, 'Tyson Fury', 'GB', '1988-08-12', '27-0-0', 'Manchester, Lancashire',
        'The 6\'9\" switch hitting \"Gypsy King\" has returned after a two year absence. Having scored a unanimous decision victory over Wladimir Klitschko before the Ukrainian lost to Anthony Joshua, Fury retains a claim to the lineal championship of the world.',
        'Tyson_Fury', 1, '2018-09-06 16:07:54', '2018-09-07 16:15:17', NULL),
       (9, 1, 629462, 'Dominic Breazeale', 'US', '1985-08-24', '19-1-0', 'Glendale, California',
        'The tall and powerful Breazeale bounced back from his sole career loss to Anthony Joshua by defeating Izuagbe Ugonoh and Eric Molina inside the distance. Another crack at one of the heavyweight titles is certainly within reach.',
        NULL, 1, '2018-09-07 11:31:07', '2018-09-07 11:31:07', NULL),
       (10, 1, 512994, 'Adam Kownacki', 'PL', '1989-03-27', '18-0-0', 'Lomza, Poland',
        'Unbeaten prospect Kownacki demonstrated his potential by overcoming more experienced countryman Artur Szpilka. A hard fought victory former IBF titlist Charles Martin has lent even further credence to his growing reputation. ',
        NULL, 1, '2018-09-07 11:50:39', '2018-09-09 15:33:14', NULL);


INSERT INTO `rating` (`division_id`, `boxer_id`, `rating`, `points`)
VALUES (1, 1, 1, 7653),
       (1, 2, 2, 4872),
       (1, 3, 3, 2502),
       (1, 4, 4, 1256),
       (1, 5, 5, 1132),
       (1, 6, 6, 1046),
       (1, 7, 7, 967),
       (1, 8, 8, 865),
       (1, 9, 9, 786),
       (1, 10, 10, 542);

INSERT INTO `p4p_rating` (`boxer_id`, `rating`)
VALUES (8, 1),
       (4, 2),
       (9, 3),
       (3, 4),
       (6, 5),
       (5, 6),
       (7, 7),
       (1, 8),
       (2, 9),
       (10, 10);

INSERT INTO admin (id, name, password, roles, active)
VALUES (1, 'Jimmy',
        '$argon2id$v=19$m=65536,t=4,p=1$iula8QSe/0baWjAUYxPddg$/9H7Bci+dCv64H9XHzzPne6nJhVVjipl90EHVJKbzgU',
        '[
          "ROLE_ADMIN"
        ]', 1);
