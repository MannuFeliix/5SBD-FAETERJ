-- ==========================================================
-- Matéria: 5SBD - Programação de Scripts de Banco de Dados
-- Atividade: Atividade Prática 03: Consultas SQL (Simples, Intermediário e Avançado)
-- Ferramenta: Oracle APEX | Turno: Manhã | 2026.2
-- Aluna: Manuelle
-- ==========================================================


-- ==========================================================
-- 🟢 NÍVEL SIMPLES: Fundamentos (SELECT, WHERE, ORDER BY e JOIN)
-- ==========================================================

-- Exercício 1.1: Listagem de Clientes Ativos (Ajustado para CPF)
SELECT nome, email, cpf 
FROM tb_cliente 
WHERE ativo = 'S' 
ORDER BY nome ASC;

/* 
  SIMULAÇÃO DE RESULTADO (EX 1.1):
  NOME             EMAIL                         CPF
  ---------------------------------------------------------
  Ana Silva        ana.silva@email.com           12345678901
  Andreia Santos   andreia.santos@email.com      12312312312
  Bruno Santos     bruno.santos@email.com        23456789012
  Caio Ferreira    caio.ferreira@email.com       45645645645
  ... (demais clientes ordenados alfabeticamente)
*/


-- Exercício 1.2: Filtro de Vendas por Canal
SELECT id_venda, dt_venda, valor_liquido 
FROM tb_venda 
WHERE canal = 'APP' AND status = 'FECHADA';

/* 
  SIMULAÇÃO DE RESULTADO (EX 1.2):
  ID_VENDA  DT_VENDA   VALOR_LIQUIDO
  ----------------------------------
  3         07/05/2026 8640.00
*/


-- Exercício 1.3: Catálogo de Produtos e Categorias (JOIN)
SELECT p.nome AS produto, p.sku, c.nome AS categoria 
FROM tb_produto p
JOIN tb_categoria c ON p.id_categoria = c.id_categoria;

/* 
  SIMULAÇÃO DE RESULTADO (EX 1.3):
  PRODUTO                       SKU           CATEGORIA
  ------------------------------------------------------------------
  Notebook Gamer Core i7 16GB   PROD-NOTE-01  Tecnologia e Informática
  Mouse Sem Fio Ergonômico      PROD-MOU-02   Tecnologia e Informática
  Geladeira Frost Free 400L     PROD-GEL-05   Eletrodomésticos
  ...
*/


-- Exercício 1.4: Contagem de Vendedores
SELECT COUNT(*) AS total_vendedores 
FROM tb_vendedor;

/* 
  SIMULAÇÃO DE RESULTADO (EX 1.4):
  TOTAL_VENDEDORES
  ----------------
  6
*/


-- Exercício 1.5: Produtos Mais Caros
SELECT nome, preco_unit 
FROM tb_produto 
ORDER BY preco_unit DESC;

/* 
  SIMULAÇÃO DE RESULTADO (EX 1.5):
  NOME                           PRECO_UNIT
  -----------------------------------------
  Notebook Gamer Core i7 16GB    4500.00
  Geladeira Frost Free 400L      3200.00
  Sofá Retrátil 3 Lugares        1900.00
  ...
*/



-- ==========================================================
-- 🟡 NÍVEL INTERMEDIÁRIO: Agrupamentos e Lógica de Negócio
-- ==========================================================

-- Exercício 2.1: Faturamento por Canal de Venda (GROUP BY)
SELECT canal, SUM(valor_liquido) AS faturamento_total
FROM tb_venda
WHERE status = 'FECHADA'
GROUP BY canal
ORDER BY faturamento_total DESC;

/* 
  SIMULAÇÃO DE RESULTADO (EX 2.1):
  CANAL  FATURAMENTO_TOTAL
  ------------------------
  APP    8640.00
  SITE   1476.50
*/


-- Exercício 2.2: Ticket Médio por Vendedor
SELECT v.nome AS vendedor, ROUND(AVG(ve.valor_liquido), 2) AS ticket_medio
FROM tb_venda ve
JOIN tb_vendedor v ON ve.id_vendedor = v.id_vendedor
WHERE ve.status = 'FECHADA'
GROUP BY v.nome
ORDER BY ticket_medio DESC;

/* 
  SIMULAÇÃO DE RESULTADO (EX 2.2):
  VENDEDOR          TICKET_MEDIO
  ------------------------------
  Thiago Silva      8640.00
  Patricia Ramos    1476.50
*/


-- Exercício 2.3: Clientes Inativos Comercialmente (NOT EXISTS)
SELECT c.nome, c.email
FROM tb_cliente c
WHERE NOT EXISTS (
    SELECT 1 
    FROM tb_venda v 
    WHERE v.id_cliente = c.id_cliente
);

/* 
  SIMULAÇÃO DE RESULTADO (EX 2.3):
  NOME             EMAIL
  ------------------------------------
  Ana Silva        ana.silva@email.com
  Bruno Santos     bruno.santos@email.com
  Carlos Oliveira  carlos.oliveira@email.com
  ... (demais clientes sem compras registradas)
*/


-- Exercício 2.4: Vendas Acima da Média (Subquery)
SELECT v.id_venda, c.nome AS cliente, v.valor_liquido
FROM tb_venda v
JOIN tb_cliente c ON v.id_cliente = c.id_cliente
WHERE v.status = 'FECHADA'
  AND v.valor_liquido > (
      SELECT AVG(valor_liquido) 
      FROM tb_venda 
      WHERE status = 'FECHADA'
  );

/* 
  SIMULAÇÃO DE RESULTADO (EX 2.4):
  ID_VENDA  CLIENTE          VALOR_LIQUIDO
  ----------------------------------------
  3         Eduardo Pereira  8640.00
*/


-- Exercício 2.5: Classificação de Preço dos Produtos (CASE WHEN)
SELECT nome, preco_unit,
       CASE 
           WHEN preco_unit < 50.00 THEN 'BARATO'
           WHEN preco_unit BETWEEN 50.00 AND 200.00 THEN 'MÉDIO'
           ELSE 'CARO'
       END AS faixa_preco
FROM tb_produto;

/* 
  SIMULAÇÃO DE RESULTADO (EX 2.5):
  NOME                         PRECO_UNIT  FAIXA_PRECO
  ----------------------------------------------------
  Notebook Gamer Core i7 16GB  4500.00     CARO
  Mouse Sem Fio Ergonômico     120.00      MÉDIO
  Agenda Executiva 2026        45.00       BARATO
  ...
*/



-- ==========================================================
-- 🔴 NÍVEL AVANÇADO: Consultas Analíticas e CTEs (WITH / OVER)
-- ==========================================================

-- Exercício 3.1: Numeração Cronológica de Compras (ROW_NUMBER)
SELECT c.nome AS cliente, v.dt_venda, v.valor_liquido,
       ROW_NUMBER() OVER (PARTITION BY c.id_cliente ORDER BY v.dt_venda) AS numero_compra
FROM tb_venda v
JOIN tb_cliente c ON v.id_cliente = c.id_cliente;

/* 
  SIMULAÇÃO DE RESULTADO (EX 3.1):
  CLIENTE          DT_VENDA   VALOR_LIQUIDO  NUMERO_COMPRA
  --------------------------------------------------------
  Yasmin Cardoso   09/04/2026 11425.50       1
  Olivia Pinto     27/04/2026 3150.00        1
  Eduardo Pereira  07/05/2026 8640.00        1
  Gabriel Costa    08/05/2026 12099.00       1
  Andreia Santos   17/05/2026 1476.50        1
*/


-- Exercício 3.2: Participação Percentual no Faturamento (Matemática com OVER)
SELECT v.nome AS vendedor,
       SUM(ve.valor_liquido) AS faturamento_vendedor,
       ROUND((SUM(ve.valor_liquido) / SUM(SUM(ve.valor_liquido)) OVER()) * 100, 2) AS percentual_participacao
FROM tb_venda ve
JOIN tb_vendedor v ON ve.id_vendedor = v.id_vendedor
WHERE ve.status = 'FECHADA'
GROUP BY v.nome;

/* 
  SIMULAÇÃO DE RESULTADO (EX 3.2):
  VENDEDOR          FATURAMENTO_VENDEDOR  PERCENTUAL_PARTICIPACAO
  ---------------------------------------------------------------
  Thiago Silva      8640.00               85.37
  Patricia Ramos    1476.50               14.63
*/


-- Exercício 3.3: Ranking Mensal de Vendedores (CTE + DENSE_RANK)
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
       DENSE_RANK() OVER (PARTITION BY mes_ref ORDER BY receita_total DESC) AS ranking_mensal
FROM vendas_mensais;

/* 
  SIMULAÇÃO DE RESULTADO (EX 3.3):
  MES_REF    VENDEDOR          RECEITA_TOTAL  RANKING_MENSAL
  ----------------------------------------------------------
  01/04/2026 Patricia Ramos    3150.00        1
  01/05/2026 Thiago Silva      8640.00        1
  01/05/2026 Patricia Ramos    1476.50        2
*/


-- Exercício 3.4: Termômetro de Vendas (Comparação Analítica)
SELECT id_venda, valor_liquido,
       valor_liquido - AVG(valor_liquido) OVER() AS diferenca_para_media
FROM tb_venda
WHERE status = 'FECHADA';

/* 
  SIMULAÇÃO DE RESULTADO (EX 3.4):
  ID_VENDA  VALOR_LIQUIDO  DIFERENCA_PARA_MEDIA
  ---------------------------------------------
  1         1476.50        -3581.75
  3         8640.00        3581.75
*/


-- Exercício 3.5: Os 3 Produtos Mais Vendidos (CTE + ROW_NUMBER)
WITH ranking_produtos AS (
    SELECT p.nome AS produto,
           SUM(i.quantidade) AS total_vendido,
           ROW_NUMBER() OVER (ORDER BY SUM(i.quantidade) DESC) AS ranking
    FROM tb_venda_item i
    JOIN tb_produto p ON i.id_produto = p.id_produto
    GROUP BY p.nome
)
SELECT produto, total_vendido
FROM ranking_produtos
WHERE ranking <= 3;

/* 
  SIMULAÇÃO DE RESULTADO (EX 3.5):
  PRODUTO                      TOTAL_VENDIDO
  ------------------------------------------
  Geladeira Frost Free 400L    3
  Cadeira de Escritório Pres.  7
  Agenda Executiva 2026        3
*/
