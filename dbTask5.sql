--У кого списывает Андреева Анастасия 
SELECT groupmate1.name
      ,groupmate2.name AS [у кого списывает]
FROM groupmate AS groupmate1
    ,cheatsFrom
    ,groupmate AS groupmate2
 
WHERE MATCH(groupmate1-(cheatsFrom)->groupmate2)
      AND groupmate1.name = N'Авдеева Анастасия Романовна';


--У кого списывают студенты, у которых списывает Гринько Кирилл Владимирович
SELECT groupmate1.name + N' списывает у ' + groupmate2.name AS Level1
      ,groupmate2.name + N' списывает у ' + groupmate3.name AS Level2
FROM groupmate AS groupmate1
    ,cheatsFrom AS cheats1
    ,groupmate AS groupmate2
    ,cheatsFrom AS cheats2
    ,groupmate AS groupmate3
WHERE MATCH(groupmate1-(cheats1)->groupmate2-(cheats2)->groupmate3)
      AND groupmate1.name = N'Гринько Кирилл Владимирович';


--В какой школе учился и как ее оценил друг по списыванию Кирилла
SELECT groupmate2.name AS person
      ,school.name AS school
      ,schoolLike.rating
FROM groupmate AS groupmate1
   ,groupmate AS groupmate2
   ,schoolLike
   ,cheatsFrom
   ,school
WHERE MATCH(groupmate1-(cheatsFrom)->groupmate2-(schoolLike)->school)
      AND groupmate1.name = N'Гринько Кирилл Владимирович';


-- Список студентов, которые оценили школу, в которой они учились, на 9 или 10 баллов
SELECT groupmate.name AS [Студент]
      ,school.name AS [Школа]
      ,schoolLike.rating AS [Оценка]
FROM groupmate
    ,schoolLike
    ,school
WHERE MATCH(groupmate-(schoolLike)->school)
      AND rating >= 9;


-- Список студентов, которые из одной области с Григорьевой Марией
SELECT groupmate1.name AS [Первый студент]
      ,groupmate2.name AS [Второй студент]
	,school.hometown AS [Область первого студента]
	,hometown.region AS [Область второго студента]
FROM groupmate AS groupmate1
    ,groupmate AS groupmate2
    ,whereAreYouFrom
    ,hometown
    ,schoolLike
    ,school
WHERE MATCH(hometown<-(whereAreYouFrom)-groupmate1
        AND groupmate2-(schoolLike)->school)
	AND school.hometown = hometown.region
	AND groupmate1.name = N'Григорьева Мария Георгиевна';


--Какой человек является автором работы, которую списывает Фомин Фёдор Захарович
SELECT groupmate1.name
      ,STRING_AGG(groupmate2.name, '->') WITHIN GROUP (GRAPH PATH) AS Groupmates
FROM groupmate AS groupmate1
    ,cheatsFrom FOR PATH AS cf
    ,groupmate FOR PATH AS groupmate2
WHERE MATCH(SHORTEST_PATH(groupmate1(-(cf)->groupmate2)+))
      AND groupmate1.name = N'Фомин Фёдор Захарович';


--У кого в итоге списывает Григорьева Мария Георгиевна не более, чем на 3 шага
SELECT groupmate1.name
      ,STRING_AGG(groupmate2.name, '->') WITHIN GROUP (GRAPH PATH) AS Groupmates
FROM groupmate AS groupmate1
    ,cheatsFrom FOR PATH AS cf
    ,groupmate FOR PATH AS groupmate2
WHERE MATCH(SHORTEST_PATH(groupmate1(-(cf)->groupmate2){1,3}))
      AND groupmate1.name = N'Григорьева Мария Георгиевна';


--Самый быстрый способ найти цепочку людей, связывающих Авдееву Анастасию Романовну и Гринько Кирилла Владимировича, в цепочке списывания 
DECLARE @GroupmateFrom AS NVARCHAR(30) = N'Авдеева Анастасия Романовна';
DECLARE @GroupmateTo AS NVARCHAR(30) = N'Гринько Кирилл Владимирович';
WITH T1 AS (
     SELECT groupmate1.name AS GroupmateName
           ,STRING_AGG(groupmate2.name, '->') WITHIN GROUP (GRAPH PATH) AS Groupmates
           ,LAST_VALUE(groupmate2.name) WITHIN GROUP (GRAPH PATH) AS LastNode
     FROM groupmate AS groupmate1
         ,cheatsFrom FOR PATH AS cf
         ,groupmate FOR PATH AS groupmate2
     WHERE MATCH(SHORTEST_PATH(groupmate1(-(cf)->groupmate2)+))
 	     AND groupmate1.name = @GroupmateFrom
)
SELECT GroupmateName, Groupmates
FROM T1
WHERE LastNode = @GroupmateTo
