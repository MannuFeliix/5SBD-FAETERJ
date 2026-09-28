-- ==========================================================
-- Matéria: 5SBD - Programação de Scripts de Banco de Dados
-- Atividade: Atividade Prática 04: SQL para Análise de Dados (Funções Analíticas)
-- Ferramenta: Oracle APEX | Turno: Manhã | 2026.2
-- Aluna(a): Manuelle
-- ==========================================================

-- Contextualização: Utilização de Funções Analíticas (OVER, PARTITION BY, 
-- DENSE_RANK, ROW_NUMBER) para relatórios de Business Intelligence (BI) 
-- linha a linha, sem perder o detalhamento original dos registros[cite: 6].


-- ==========================================================
-- PARTE 1: Numeração e Histórico (ROW_NUMBER)
-- ==========================================================

-- Exercício 1: Jornada de Compras do Cliente (CRM)
-- Objetivo: Criar sequências lógicas cronológicas dentro de grupos de clientes[cite: 6].
SELECT c.nome AS cliente, v.dt_venda, v.valor_liquido,
       ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY v.dt_venda ASC) AS numero_compra
FROM tb_venda v
JOIN tb_cliente c ON v.id_cliente = c.id_cliente
WHERE v.status = 'FECHADA';

/* 
  SIMULAÇÃO DE RESULTADO (PARTE 1):
  CLIENTE          DT_VENDA   VALOR_LIQUIDO  NUMERO_COMPRA
  --------------------------------------------------------
  Yasmin Cardoso   09/04/2026 11425.50       1
  Olivia Pinto     27/04/2026 3150.00        1
  Eduardo Pereira  07/05/2026 8640.00        1
  Gabriel Costa    08/05/2026 12099.00       1
  Andreia Santos   17/05/2026 1476.50        1
*/


-- ==========================================================
-- PARTE 2: Competições e Agrupamentos Analíticos (DENSE_RANK e PARTITION BY)
-- ==========================================================

-- Exercício 2.1: Ranking Mensal de Vendedores (Pódio do RH)
-- Objetivo: Descobrir os melhores vendedores por período, reiniciando o ranking a cada mês[cite: 6].
WITH vendas_mensais AS (
    SELECT TRUNC(ve.dt_venda, 'MM') AS mes_ref,
           v.nome AS vendedor,
           SUM(ve.valor_liquido) AS receita_total
    FROM tb_venda ve
    JOIN tb_vendedor v ON ve.id_vendedor = v.id_vendedor
    WHERE ve.status = 'FECHADA'
    GROUP BY TRUNC(ve.dt_venda, 'MM'), v.nome
)
SELECT mes_ref, vendedor, receita_total,
       DENSE_RANK() OVER (PARTITION BY mes_ref ORDER BY receita_total DESC) AS posicao_ranking
FROM vendas_mensais;

/* 
  SIMULAÇÃO DE RESULTADO (PARTE 2.1):
  MES_REF    VENDEDOR          RECEITA_TOTAL  POSICAO_RANKING
  -----------------------------------------------------------
  01/04/2026 Patricia Ramos    3150.00        1
  01/05/2026 Thiago Silva      8640.00        1
  01/05/2026 Patricia Ramos    1476.50        2
*/


-- Exercício 2.2: Os 2 Produtos Mais Vendidos por Categoria (Carros-chefes)
-- Objetivo: Gerar ranking por categoria filtrando os top 2 com auxílio de CTE[cite: 6].
WITH ranking_produtos AS (
    SELECT cat.nome AS categoria,
           p.nome AS produto,
           SUM(i.quantidade) AS qtd_total,
           DENSE_RANK() OVER (PARTITION BY cat.id_categoria ORDER BY SUM(i.quantidade) DESC) AS ranking
    FROM tb_venda_item i
    JOIN tb_produto p ON i.id_produto = p.id_produto
    JOIN tb_categoria cat ON p.id_categoria = cat.id_categoria
    GROUP BY cat.id_categoria, cat.nome, p.nome
)
SELECT categoria, produto, qtd_total, ranking
FROM ranking_produtos
WHERE ranking <= 2;

/* 
  SIMULAÇÃO DE RESULTADO (PARTE 2.2):
  CATEGORIA                PRODUTO                       QTD_TOTAL  RANKING
  -------------------------------------------------------------------------
  Tecnologia e Informática Mouse Sem Fio Ergonômico      3          1
  Tecnologia e Informática Teclado Mecânico RGB          3          1
  Eletrodomésticos         Geladeira Frost Free 400L     3          1
  Eletrodomésticos         Liquidificador 1200W          5          2
*/


-- ==========================================================
-- PARTE 3: Indicadores de Negócio Avançados (Matemática com OVER)
-- ==========================================================

-- Exercício 3.1: Participação no Faturamento (Market Share Interno)
-- Objetivo: Comparar o desempenho individual do vendedor com o total geral da empresa[cite: 6].
SELECT v.nome AS vendedor,
       SUM(ve.valor_liquido) AS receita_vendedor,
       ROUND((SUM(ve.valor_liquido) / SUM(SUM(ve.valor_liquido)) OVER()) * 100, 2) AS percentual_faturamento
FROM tb_venda ve
JOIN tb_vendedor v ON ve.id_vendedor = v.id_vendedor
WHERE ve.status = 'FECHADA'
GROUP BY v.nome;

/* 
  SIMULAÇÃO DE RESULTADO (PARTE 3.1):
  VENDEDOR          RECEITA_VENDEDOR  PERCENTUAL_FATURAMENTO
  ----------------------------------------------------------
  Thiago Silva      8640.00           85.37
  Patricia Ramos    1476.50           14.63
*/


-- Exercício 3.2: Termômetro de Vendas (Acima ou Abaixo da Média?)
-- Objetivo: Exibir métricas globais e comparativas linha a linha[cite: 6].
SELECT id_venda, valor_liquido,
       AVG(valor_liquido) OVER() AS media_geral,
       valor_liquido - AVG(valor_liquido) OVER() AS diferenca_media
FROM tb_venda
WHERE status = 'FECHADA';

/* 
  SIMULAÇÃO DE RESULTADO (PARTE 3.2):
  ID_VENDA  VALOR_LIQUIDO  MEDIA_GERAL  DIFERENCA_MEDIA
  -----------------------------------------------------
  1         1476.50        5058.25      -3581.75
  3         8640.00        5058.25       3581.75
*/
