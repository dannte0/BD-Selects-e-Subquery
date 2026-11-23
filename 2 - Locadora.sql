--USE Locadora
--GO
SELECT * FROM DVD
SELECT * FROM Estrela
SELECT * FROM Cliente
SELECT * FROM Filme
SELECT * FROM Locacao


/*1) Fazer uma consulta que retorne ID, Ano, nome do Filme (Caso o nome do filme tenha
mais de 10 caracteres, para caber no campo da tela, mostrar os 10 primeiros
caracteres, seguidos de reticências ...) dos filmes cujos DVDs foram fabricados depois
de 01/01/2020*/
SELECT id, 
CASE WHEN(LEN(titulo)>10)
	 THEN SUBSTRING(titulo,1,10)+'...'
	 ELSE titulo
	 END AS filme,
ano FROM Filme
INNER JOIN DVD ON Filme.id = DVD.Filmeid
WHERE DVD.data_fabricacao > '2020-01-01'

/*2) Fazer uma consulta que retorne num, data_fabricacao, qtd_meses_desde_fabricacao
(Quantos meses desde que o dvd foi fabricado até hoje) do filme Interestelar */
SELECT num, data_fabricacao, 
DATEDIFF(MONTH, data_fabricacao, GETDATE()) AS qtd_meses_desde_fabricacao 
FROM DVD INNER JOIN Filme ON DVD.Filmeid = Filme.id
WHERE Filme.titulo = 'Interestelar'

/*3) Fazer uma consulta que retorne num_dvd, data_locacao, data_devolucao,
dias_alugado(Total de dias que o dvd ficou alugado) e valor das locações da cliente que
tem, no nome, o termo Rosa */
SELECT DVD.num, Locacao.data_locacao, Locacao.data_devolucao, 
DATEDIFF(DAY, Locacao.data_locacao, Locacao.data_devolucao) AS dias_alugado,
Locacao.valor FROM DVD 
INNER JOIN Locacao ON DVD.num = Locacao.DVDnum
INNER JOIN Cliente ON Locacao.Clientenum_cadastro = Cliente.num_cadastro
WHERE Cliente.nome LIKE '%Rosa%'


/*4) Nome, endereço_completo (logradouro e número concatenados), cep (formato
XXXXX-XXX) dos clientes que alugaram DVD de num 10002. */
SELECT nome, logradouro + ', ' + CAST(num AS VARCHAR) + ' - ' + SUBSTRING(cep, 1, 4) + '-' + SUBSTRING(cep,5,8) AS endereco_completo
FROM Cliente 
WHERE num_cadastro IN
(
SELECT Clientenum_cadastro FROM Locacao
WHERE DVDnum = 10002
)