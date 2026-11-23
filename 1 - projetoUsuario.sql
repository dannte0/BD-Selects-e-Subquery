/*Fazer uma consulta que retorne id, nome, email, username e caso a senha seja diferente de
123mudar, mostrar ******** (8 asteriscos), caso contrário, mostrar a própria senha.*/

SELECT id, name, email, username, 
	   CASE WHEN(password != '123mudar')
			THEN '********'
			ELSE password
			END AS password
FROM users

/* Considerando que o projeto 10001 durou 15 dias, fazer uma consulta que mostre o nome do
projeto, descrição, data, data_final do projeto realizado por usuário de e-mail
aparecido@empresa.com*/

SELECT projects.name, description, date, DATEADD(DAY, 15, date) AS final_date FROM projects
INNER JOIN users_has_projects uhp ON projects.id = uhp.projects_id
INNER JOIN users ON uhp.users_id = users.id
WHERE users.email = 'aparecido@empresa.com'

/*Fazer uma consulta que retorne o nome e o email dos usuários que estão envolvidos no
projeto de nome Auditoria*/

SELECT users.name, users.email FROM users
INNER JOIN users_has_projects uhp ON users.id = uhp.users_id
INNER JOIN projects ON projects.id = uhp.projects_id
WHERE projects.name = 'Auditoria'

/*Considerando que o custo diário do projeto, cujo nome tem o termo Manutenção, é de 79.85
e ele deve finalizar 16/09/2014, consultar, nome, descrição, data, data_final e custo_total do
projeto*/
SELECT projects.name, description, date, 
DATEADD(DAY, DATEDIFF(DAY, date, CAST('2014-09-16' AS DATE)), date) AS data_final,
CAST(79.85 * DATEDIFF(DAY, date, CAST('2014-09-16' AS DATE)) AS DECIMAL(7,2)) AS custo_total
FROM projects
WHERE projects.name LIKE 'Manutenção%'

