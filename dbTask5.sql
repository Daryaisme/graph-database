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