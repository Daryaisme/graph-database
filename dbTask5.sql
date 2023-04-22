--task5
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


--task6
--какой человек является автором работы которую списывает Фомин Фёдор Захарович

SELECT groupmate1.name
 , STRING_AGG(groupmate2.name, '->') WITHIN GROUP (GRAPH PATH) AS Groupmates
FROM groupmate AS groupmate1
 , cheatsFrom FOR PATH AS cf
 , groupmate FOR PATH AS groupmate2
WHERE MATCH(SHORTEST_PATH(groupmate1(-(cf)->groupmate2)+))
 AND groupmate1.name = N'Фомин Фёдор Захарович';

--у кого в итоге списывает Григорьева Мария Георгиевна не более чем на 3 шага

SELECT groupmate1.name
 , STRING_AGG(groupmate2.name, '->') WITHIN GROUP (GRAPH PATH) AS Groupmates
FROM groupmate AS groupmate1
 , cheatsFrom FOR PATH AS cf
 , groupmate FOR PATH AS groupmate2
WHERE MATCH(SHORTEST_PATH(groupmate1(-(cf)->groupmate2){1,3}))
 AND groupmate1.name = N'Григорьева Мария Георгиевна';

 --самый быстрый способ найти цепочку людей связывающих Авдеева Анастасия Романовна и Гринько Кирилл Владимирович в цепочке списывания
 
 DECLARE @GroupmateFrom AS NVARCHAR(30) = N'Авдеева Анастасия Романовна';
 DECLARE @GroupmateTo AS NVARCHAR(30) = N'Гринько Кирилл Владимирович';
 WITH T1 AS(
 SELECT groupmate1.name AS GroupmateName
  , STRING_AGG(groupmate2.name, '->') WITHIN GROUP (GRAPH PATH) AS Groupmates
  , LAST_VALUE(groupmate2.name) WITHIN GROUP (GRAPH PATH) AS LastNode
 FROM groupmate AS groupmate1
  , cheatsFrom FOR PATH AS cf
  , groupmate FOR PATH AS groupmate2
 WHERE MATCH(SHORTEST_PATH(groupmate1(-(cf)->groupmate2)+))
 	AND groupmate1.name = @GroupmateFrom
 )
 SELECT GroupmateName, Groupmates
 FROM T1
 WHERE LastNode = @GroupmateTo