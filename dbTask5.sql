--у кого списывает андреева анастасия 
SELECT groupmate1.name
 , groupmate2.name AS [у кого списывает]
FROM groupmate AS groupmate1
 , cheatsFrom
 , groupmate AS groupmate2
 
WHERE MATCH(groupmate1-(cheatsFrom)->groupmate2)
 AND groupmate1.name = N'Авдеева Анастасия Романовна';


--у кого списывают студенты, у котрых списывает Гринько Кирилл Владимирович
SELECT groupmate1.name + N' списывает у ' + groupmate2.name AS Level1
 , groupmate2.name + N'списывает у ' + groupmate3.name AS Level2
FROM groupmate AS groupmate1
 , cheatsFrom AS cheats1
 , groupmate AS groupmate2
 , cheatsFrom AS cheats2
 , groupmate AS groupmate3
WHERE MATCH(groupmate1-(cheats1)->groupmate2-(cheats2)->groupmate3)
 AND groupmate1.name = N'Гринько Кирилл Владимирович';



--в какой школе учился и как ее оценил друг по списыванию кирилла
 SELECT groupmate2.name AS person
 , school.name AS restaurant
 , schoolLike.rating
FROM groupmate AS groupmate1
 , groupmate AS groupmate2
 , schoolLike
 , cheatsFrom
 , school
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
