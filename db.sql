    -- CREATE DATABASE Одногруппники
-- USE Одногруппники


CREATE TABLE groupmate (
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
) AS NODE

INSERT INTO groupmate(id, name)
VALUES  (1,N'Колесникова Кристина Алексеевна'),
        (2,N'Антонова Кира Александровна'),
        (3,N'Григорьева Мария Георгиевна'),
        (4,N'Фомин Иван Андреевич'),
        (5,N'Федоров Константин Владимирович'),
        (6,N'Некрасова Ольга Ильинична'),
        (7,N'Ильинская Мария Ярославовна'),
        (8,N'Авдеева Анастасия Романовна'),
        (9,N'Фомин Фёдор Захарович'),
        (10,N'Иванова Милана Марковна'),
        (11,N'Кириловец Иван Захарович'),
        (12,N'Лев Фёдор Владимирович'),
        (13,N'Лесун Иван Андреевич'),
        (14,N'Гринько Кирилл Владимирович'),
        (15,N'Грин Захар Иванович');
    

-- SELECT *
-- FROM groupmate 

--Города откуда одногрупники
-- CREATE TABLE hometown(
--     id INT NOT NULL PRIMARY KEY,
--     city NVARCHAR(150) NOT NULL,
--     region NVARCHAR(150) NOT NULL
-- ) AS NODE

INSERT INTO hometown(id, city, region)
VALUES  (1,N'Гомель', N'Гомельская область'),
        (2,N'Светлогорск', N'Гомельская область'),
        (3,N'Минск', N'Минскская область'),
        (4,N'Полоцк', N'Витебская область'),
        (5,N'Браслав', N'Витебская область'),
        (6,N'Могилев', N'Могилевская область'),
        (7,N'Брест', N'Бресткая область'),
        (8,N'Орша', N'Витебская область'),
        (9,N'Гродно', N'Гродненская область'),
        (10,N'Рогачев', N'Гомельская область');
-- SELECT *
-- FROM hometown


CREATE TABLE school(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    hometown NVARCHAR(150) NOT NULL
) AS NODE



--студенты оценивают школу в которой они учились
INSERT INTO school(id, name, hometown)
VALUES  (1, N'Школа 122', N'Гомельская область'),
        (2, N'Школа 33', N'Гомельская область'),
        (3, N'Школа 1', N'Минскская область'),
        (4, N'Лицей 432', N'Витебская область'),
        (5, N'Школа 29', N'Витебская область'),
        (6, N'Школа 90', N'Могилевская область'),
        (7, N'Школа 35', N'Бресткая область'),
        (8, N'Школа 13', N'Витебская область'),
        (9, N'Школа 22', N'Гродненская область'),
        (10, N'Школа 1', N'Гомельская область');


SELECT *
FROM school


--кто у кого списывает
CREATE TABLE cheatsFrom AS EDGE

ALTER TABLE cheatsFrom
ADD CONSTRAINT EC_FriendOf CONNECTION (groupmate TO groupmate);


INSERT INTO cheatsFrom ($from_id, $to_id)
VALUES 
((SELECT $node_id FROM groupmate WHERE id = 1),
 (SELECT $node_id FROM groupmate WHERE id = 3)),

 ((SELECT $node_id FROM groupmate WHERE id = 1),
 (SELECT $node_id FROM groupmate WHERE id = 10)),

 ((SELECT $node_id FROM groupmate WHERE id = 1),
 (SELECT $node_id FROM groupmate WHERE id = 7)),

 ((SELECT $node_id FROM groupmate WHERE id = 2),
 (SELECT $node_id FROM groupmate WHERE id = 15)),

 ((SELECT $node_id FROM groupmate WHERE id = 3),
 (SELECT $node_id FROM groupmate WHERE id = 9)),
--

 ((SELECT $node_id FROM groupmate WHERE id = 5),
 (SELECT $node_id FROM groupmate WHERE id = 13)),

 ((SELECT $node_id FROM groupmate WHERE id = 6),
 (SELECT $node_id FROM groupmate WHERE id = 5)),

 ((SELECT $node_id FROM groupmate WHERE id = 7),
 (SELECT $node_id FROM groupmate WHERE id = 4)),

 ((SELECT $node_id FROM groupmate WHERE id = 7),
 (SELECT $node_id FROM groupmate WHERE id = 6)),
--
 ((SELECT $node_id FROM groupmate WHERE id = 8),
 (SELECT $node_id FROM groupmate WHERE id = 5)),
 
 ((SELECT $node_id FROM groupmate WHERE id = 8),
 (SELECT $node_id FROM groupmate WHERE id = 9)),
 
 ((SELECT $node_id FROM groupmate WHERE id = 8),
 (SELECT $node_id FROM groupmate WHERE id = 10)),

 ((SELECT $node_id FROM groupmate WHERE id = 9),
 (SELECT $node_id FROM groupmate WHERE id = 2)),

 ((SELECT $node_id FROM groupmate WHERE id = 11),
 (SELECT $node_id FROM groupmate WHERE id = 2)),

 ((SELECT $node_id FROM groupmate WHERE id = 12),
 (SELECT $node_id FROM groupmate WHERE id = 4)),

((SELECT $node_id FROM groupmate WHERE id = 13),
 (SELECT $node_id FROM groupmate WHERE id = 12)),

  ((SELECT $node_id FROM groupmate WHERE id = 14),
 (SELECT $node_id FROM groupmate WHERE id = 13)),

  ((SELECT $node_id FROM groupmate WHERE id = 15),
 (SELECT $node_id FROM groupmate WHERE id = 14));

GO


SELECT *
FROM cheatsFrom







--кто откуда
CREATE TABLE whereAreYouFrom AS EDGE

ALTER TABLE whereAreYouFrom
ADD CONSTRAINT EC_whereAreYouFrom CONNECTION (groupmate TO hometown);

INSERT INTO whereAreYouFrom ($from_id, $to_id)
VALUES 
((SELECT $node_id FROM groupmate WHERE ID = 1),
 (SELECT $node_id FROM hometown WHERE ID = 1)),
 ((SELECT $node_id FROM groupmate WHERE ID = 6),
 (SELECT $node_id FROM hometown WHERE ID = 1)),
 --
 ((SELECT $node_id FROM groupmate WHERE ID = 2),
 (SELECT $node_id FROM hometown WHERE ID = 2)),

 ((SELECT $node_id FROM groupmate WHERE ID = 9),
 (SELECT $node_id FROM hometown WHERE ID = 3)),
 ((SELECT $node_id FROM groupmate WHERE ID = 15),
 (SELECT $node_id FROM hometown WHERE ID = 3)),

 ((SELECT $node_id FROM groupmate WHERE ID = 8),
 (SELECT $node_id FROM hometown WHERE ID = 4)),

 ((SELECT $node_id FROM groupmate WHERE ID = 5),
 (SELECT $node_id FROM hometown WHERE ID = 5)),


 ((SELECT $node_id FROM groupmate WHERE ID = 13),
 (SELECT $node_id FROM hometown WHERE ID = 6)),
 ((SELECT $node_id FROM groupmate WHERE ID = 14),
 (SELECT $node_id FROM hometown WHERE ID = 6)),

 
 ((SELECT $node_id FROM groupmate WHERE ID = 3),
 (SELECT $node_id FROM hometown WHERE ID = 7)),
 ((SELECT $node_id FROM groupmate WHERE ID = 4),
 (SELECT $node_id FROM hometown WHERE ID = 7)),
 ((SELECT $node_id FROM groupmate WHERE ID = 7),
 (SELECT $node_id FROM hometown WHERE ID = 7)),


 ((SELECT $node_id FROM groupmate WHERE ID = 11),
 (SELECT $node_id FROM hometown WHERE ID = 8)),

 
 ((SELECT $node_id FROM groupmate WHERE ID = 10),
 (SELECT $node_id FROM hometown WHERE ID = 9)),

 ((SELECT $node_id FROM groupmate WHERE ID = 12),
 (SELECT $node_id FROM hometown WHERE ID = 10));

SELECT *
FROM whereAreYouFrom



--какую оценку он ставит школе
CREATE TABLE schoolLike (rating INT) as EDGE


ALTER TABLE schoolLike
ADD CONSTRAINT EC_schoolLike CONNECTION (groupmate TO school);
GO

