-- Respostas das questões 1 a 5 foram consultadas no dia 09/02/2024 podendo o banco ter sofrido alterações
-- posteriormente, as respostas as consultas feitas podem sofrer pequenas alterações.

-- 1) Quantos chamados foram abertos no dia 01/04/2023?
-- R. 73
SELECT COUNT(id_chamado) AS QTD_Chamados FROM `datario.administracao_servicos_publicos.chamado_1746` WHERE data_inicio BETWEEN '2023-04-01T00:00:00' AND '2023-04-01T23:59:59';

-- 2) Qual o tipo de chamado que teve mais reclamações no dia 01/04/2023?
-- R. Poluição Sonora com 24 chamados
SELECT tipo AS TIPO_Chamado, COUNT(*) AS QTD_Reclamacoes
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE data_inicio BETWEEN '2023-04-01T00:00:00' AND '2023-04-01T23:59:59'
GROUP BY tipo
ORDER BY QTD_Reclamacoes DESC
LIMIT 1;

-- 3) Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?
-- R. Engenho de Dentro, Campo Grande e Leblon
SELECT b.nome AS NOME_bairro, COUNT(*) AS QTD_Chamados
FROM `datario.administracao_servicos_publicos.chamado_1746` c
INNER JOIN `datario.dados_mestres.bairro` b ON c.id_bairro = b.id_bairro
WHERE c.data_inicio BETWEEN '2023-04-01T00:00:00' AND '2023-04-01T23:59:59'
GROUP BY b.nome
ORDER BY QTD_Chamados DESC
LIMIT 3;

-- 4) Qual o nome da subprefeitura com mais chamados abertos nesse dia?
-- R. Zona Norte
SELECT s.subprefeitura AS Subprefeitura, COUNT(*) AS QTD_Chamados
FROM `datario.administracao_servicos_publicos.chamado_1746` c
INNER JOIN `datario.dados_mestres.bairro` b ON c.id_bairro = b.id_bairro
INNER JOIN `datario.dados_mestres.subprefeitura` s ON b.subprefeitura = s.subprefeitura
WHERE c.data_inicio BETWEEN '2023-04-01T00:00:00' AND '2023-04-01T23:59:59'
GROUP BY s.subprefeitura
ORDER BY QTD_Chamados DESC
LIMIT 1;

-- 5) Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim, por que isso acontece?
-- R. Existem 12 chamados onde um destes dois campos estão nulos, e 
-- suas descrições se referem a chamados abertos para verificação de ar-condicionado em ônibus,
-- sendo assim, não estao atribuidos a nenhum bairro ou subprefeitura

SELECT *
FROM `datario.administracao_servicos_publicos.chamado_1746` AS c
LEFT JOIN `datario.dados_mestres.bairro` AS b ON c.id_bairro = b.id_bairro
WHERE DATE(c.data_inicio) = DATE('2023-04-01')
AND (b.nome IS NULL OR b.subprefeitura IS NULL);

-- Respostas das questões 6 a 10 foram consultadas no dia 10/02/2024 podendo o banco ter sofrido alterações
-- posteriormente, as respostas as consultas feitas podem sofrer pequenas alterações.

-- 6) Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 até 31/12/2023 (incluindo extremidades)?
-- R. 42408 chamados de Pertubação do sossego.

SELECT COUNT(*) AS QTD_Chamados_Perturbacao_Sossego
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE subtipo = 'Perturbação do sossego'
AND data_inicio BETWEEN '2022-01-01' AND '2023-12-31';

-- 7) Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).
-- R. A consulta sql abaixo retorna a seleção

SELECT c.*
FROM `datario.administracao_servicos_publicos.chamado_1746` c
INNER JOIN `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` e
ON c.data_inicio BETWEEN e.data_inicial AND e.data_final
WHERE c.subtipo = 'Perturbação do sossego'
AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio');

-- 8) Quantos chamados desse subtipo foram abertos em cada evento?
-- R. Carnaval = 197, Reveillon = 79 e Rock in Rio = 518

SELECT e.evento AS Evento, COUNT(c.id_chamado) AS QTD_Chamados
FROM `datario.administracao_servicos_publicos.chamado_1746` c
INNER JOIN `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` e
ON c.data_inicio BETWEEN e.data_inicial AND e.data_final
WHERE c.subtipo = 'Perturbação do sossego'
AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
GROUP BY e.evento;

-- 9) Qual evento teve a maior média diária de chamados abertos desse subtipo?
-- R. Rock in Rio com a média de 103,6 chamados diários.

SELECT evento AS Evento, AVG(QTD_Chamados) AS Media_Diaria_Chamados
FROM (
    SELECT e.evento, DATE(c.data_inicio) AS data, COUNT(*) AS QTD_Chamados
    FROM `datario.administracao_servicos_publicos.chamado_1746` c
    INNER JOIN `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` e
    ON c.data_inicio BETWEEN e.data_inicial AND e.data_final
    WHERE c.subtipo = 'Perturbação do sossego'
    GROUP BY e.evento, DATE(c.data_inicio)
) AS subquery
GROUP BY evento
ORDER BY Media_Diaria_Chamados DESC
LIMIT 1;

-- 10) Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023.
-- R.Rock in Rio = 103.6|Carnaval = 65.6667|Todos os Eventos = 63.2012|Reveillon = 39.5

SELECT 'Todos os Eventos' AS evento, ROUND(AVG(QTD_Chamados), 4) AS Media_Diaria
FROM (
    SELECT DATE(data_inicio) AS data, COUNT(*) AS QTD_Chamados
    FROM `datario.administracao_servicos_publicos.chamado_1746`
    WHERE subtipo = 'Perturbação do sossego'
    AND data_inicio BETWEEN '2022-01-01' AND '2023-12-31'
    GROUP BY DATE(data_inicio)
) AS subquery1
UNION ALL
SELECT evento, ROUND(AVG(QTD_Chamados), 4) AS Media_Diaria
FROM (
    SELECT e.evento, DATE(c.data_inicio) AS data, COUNT(*) AS QTD_Chamados
    FROM `datario.administracao_servicos_publicos.chamado_1746` c
    INNER JOIN `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` e
    ON c.data_inicio BETWEEN e.data_inicial AND e.data_final
    WHERE c.subtipo = 'Perturbação do sossego'
    AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
    GROUP BY e.evento, DATE(c.data_inicio)
) AS subquery2
GROUP BY evento ORDER BY Media_Diaria DESC;
