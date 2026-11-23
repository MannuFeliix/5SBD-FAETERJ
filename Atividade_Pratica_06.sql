-- ==========================================================
-- Matéria: 5SBD - Programação de Scripts de Banco de Dados
-- Atividade: Atividade Prática 06: Views como Camada de Abstração, Segurança e Reuso
-- Ferramenta: Oracle APEX | Turno: Manhã | 2026.2
-- Aluna(a): Manuelle
-- ==========================================================

-- Objetivo: Criar Views no Oracle APEX como tabelas virtuais e "contratos de
-- dados" para abstração operacional, segurança/privacidade (LGPD) e análises de BI[cite: 12].


-- ==========================================================
-- PARTE 1: Abstração Operacional
-- ==========================================================

-- Questão 1: View de Resumo de Vendas (V_VENDAS_RESUMO)
-- Centraliza JOINs entre vendas, clientes e vendedores retornando os campos consolidados[cite: 12].
CREATE OR REPLACE VIEW V_VENDAS_RESUMO AS
SELECT ve.id_venda,
       ve.dt_venda,
       ve.status,
       ve.canal,
       c.nome AS nome_cliente,
       v.nome AS nome_vendedor,
       ve.valor_liquido
FROM tb_venda ve
JOIN tb_cliente c ON ve.id_cliente = c.id_cliente
JOIN tb_vendedor v ON ve.id_vendedor = v.id_vendedor;

-- Consulta de conferência da View operacional:
SELECT * FROM V_VENDAS_RESUMO;

/*
  SIMULAÇÃO DE RESULTADO (QUESTÃO 1):
  View V_VENDAS_RESUMO created.

  ID_VENDA  DT_VENDA   STATUS     CANAL     NOME_CLIENTE     NOME_VENDEDOR   VALOR_LIQUIDO
  -----------------------------------------------------------------------------------------
  1         17/05/2026 FECHADA    SITE      Andreia Santos   Patricia Ramos  1476.50
  2         08/05/2026 ABERTA     TELEFONE  Gabriel Costa    Regina Duarte   12099.00
  3         07/05/2026 FECHADA    APP       Eduardo Pereira  Thiago Silva    8640.00
  4         09/04/2026 CANCELADA  TELEFONE  Yasmin Cardoso   Marcos Pontes   11425.50
  5         27/04/2026 ABERTA     APP       Olivia Pinto     Patricia Ramos  3150.00
*/


-- ==========================================================
-- PARTE 2: Camada de Segurança e Privacidade (LGPD)
-- ==========================================================

-- Questão 2: View de Cliente Público (V_CLIENTE_PUBLICO)
-- Oculta dados pessoais sensíveis (como CPF e telefone) e filtra apenas clientes ativos ('S')[cite: 12].
CREATE OR REPLACE VIEW V_CLIENTE_PUBLICO AS
SELECT id_cliente,
       nome,
       email,
       ativo
FROM tb_cliente
WHERE ativo = 'S';

-- Consulta de conferência da View de segurança/LGPD:
SELECT * FROM V_CLIENTE_PUBLICO;

/*
  SIMULAÇÃO DE RESULTADO (QUESTÃO 2):
  View V_CLIENTE_PUBLICO created.

  ID_CLIENTE  NOME             EMAIL                        ATIVO
  ---------------------------------------------------------------
  1           Ana Silva        ana.silva@email.com          S
  2           Bruno Santos     bruno.santos@email.com       S
  3           Carlos Oliveira  carlos.oliveira@email.com    S
  ... (demais clientes com ativo = 'S', sem expor CPF ou telefone)
*/


-- ==========================================================
-- PARTE 3: Inteligência de Negócio (Views Analíticas para BI)
-- ==========================================================

-- Questão 3: View de Receita por Categoria (V_VENDAS_POR_CATEGORIA)
-- Agrupa o faturamento acumulado por mês e por categoria considerando vendas 'FECHADA'[cite: 12].
CREATE OR REPLACE VIEW V_VENDAS_POR_CATEGORIA AS
SELECT TRUNC(ve.dt_venda, 'MM') AS mes_referencia,
       cat.id_categoria,
       cat.nome AS nome_categoria,
       SUM(vi.valor_total) AS faturamento_acumulado
FROM tb_venda ve
JOIN tb_venda_item vi ON ve.id_venda = vi.id_venda
JOIN tb_produto p ON vi.id_produto = p.id_produto
JOIN tb_categoria cat ON p.id_categoria = cat.id_categoria
WHERE ve.status = 'FECHADA'
GROUP BY TRUNC(ve.dt_venda, 'MM'), cat.id_categoria, cat.nome;

-- Consulta de conferência da View analítica:
SELECT *
FROM V_VENDAS_POR_CATEGORIA
ORDER BY mes_referencia, faturamento_acumulado DESC;

/*
  SIMULAÇÃO DE RESULTADO (QUESTÃO 3):
  View V_VENDAS_POR_CATEGORIA created.

  MES_REFERENCIA  ID_CATEGORIA  NOME_CATEGORIA            FATURAMENTO_ACUMULADO
  -------------------------------------------------------------------------------
  01/05/2026      2             Eletrodomésticos          9099.00
  01/05/2026      3             Móveis e Decoração        722.50
  01/05/2026      5             Esporte e Lazer           160.00
  01/05/2026      4             Papelaria e Escritório    135.00
*/


-- Questão 4: Consumindo a View Analítica
-- Filtra categorias com faturamento acumulado > R$ 5.000,00 para o mês corrente[cite: 12].
SELECT mes_referencia,
       id_categoria,
       nome_categoria,
       faturamento_acumulado
FROM V_VENDAS_POR_CATEGORIA
WHERE mes_referencia = TRUNC(SYSDATE, 'MM')
  AND faturamento_acumulado > 5000.00;

/*
  SIMULAÇÃO DE RESULTADO (QUESTÃO 4):
  no rows selected (caso não haja vendas 'FECHADA' > 5000 no mês corrente de execução)

  Exemplo de retorno quando há mês correspondente com faturamento > 5000 (ex.: 01/05/2026):
  MES_REFERENCIA  ID_CATEGORIA  NOME_CATEGORIA    FATURAMENTO_ACUMULADO
  -----------------------------------------------------------------------
  01/05/2026      2             Eletrodomésticos  9099.00
*/
