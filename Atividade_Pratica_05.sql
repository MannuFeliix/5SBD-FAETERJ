-- ==========================================================
-- Matéria: 5SBD - Programação de Scripts de Banco de Dados
-- Atividade: Atividade Prática 05: Modelagem Física e Qualidade de Dados (Constraints)
-- Ferramenta: Oracle APEX | Turno: Manhã | 2026.2
-- Aluna(a): Manuelle
-- ==========================================================

-- Objetivo: Testar restrições físicas (PK, FK, UNIQUE, CHECK) no Oracle
-- Database 23ai / APEX, evoluir o modelo via DDL (ALTER TABLE) e comparar
-- exclusão em cascata (ON DELETE CASCADE) com exclusão lógica (Soft Delete)[cite: 7, 8].


-- ==========================================================
-- PARTE 1: Testando a Resiliência (O Princípio de "Falhar Cedo")
-- ==========================================================

-- Questão 1: Violação de Chave Estrangeira (FK)
-- Tentativa de inserir venda com id_cliente inexistente (9999)[cite: 7, 9].
INSERT INTO tb_venda (id_cliente, id_vendedor, dt_venda, status, canal)
VALUES (9999, 1, SYSDATE, 'ABERTA', 'LOJA');
[cite: 9]

/*
  SIMULAÇÃO DE RESULTADO / ERRO ESPERADO (Q1):
  ORA-02291: integrity constraint (FK_TB_VENDA_CLIENTE) violated - parent key not found[cite: 9]

  Análise: A FK impede "vendas órfãs" exigindo que o cliente exista previamente
  em tb_cliente, preservando a integridade referencial e métricas de CRM/vendas[cite: 9].
*/


-- Questão 2: Violação de Domínio (CHECK Constraint)
-- Tentativa de atualizar o status da venda para um valor fora do domínio ('PENDENTE')[cite: 7, 9].
UPDATE tb_venda
SET status = 'PENDENTE'
WHERE id_venda = 1;
[cite: 9]

/*
  SIMULAÇÃO DE RESULTADO / ERRO ESPERADO (Q2):
  ORA-02290: check constraint (CK_TB_VENDA_STATUS) violated[cite: 9]

  Análise: A constraint CHECK restringe o status aos valores válidos ('ABERTA',
  'FECHADA', 'CANCELADA'). Validar no banco protege contra bugs na aplicação ou
  integrações externas que tentem gravar estados inválidos[cite: 9].
*/


-- Questão 3: Impedindo Preços Absurdos
-- Tentativa de inserir produto com preco_unit negativo (-15.00)[cite: 7, 10].
INSERT INTO tb_produto (id_categoria, sku, nome, preco_unit)
VALUES (1, 'SKU-TEMP-01', 'Produto Teste Negativo', -15.00);
[cite: 10]

/*
  SIMULAÇÃO DE RESULTADO / ERRO ESPERADO (Q3):
  ORA-02290: check constraint (CK_TB_PRODUTO_PRECO) violated[cite: 9, 10]

  Análise: A check constraint (preco_unit > 0) bloqueia preços negativos ou zerados/inválidos,
  evitando distorções em estoque, faturamento e dashboards financeiros[cite: 10].
*/


-- ==========================================================
-- PARTE 2: Evoluindo a Modelagem Física (DDL)
-- ==========================================================

-- Questão 4: Limite de Desconto de Itens (CHECK)
-- Garante que desconto_item não ultrapasse 50% do preco_unit[cite: 7, 10].
ALTER TABLE tb_venda_item
ADD CONSTRAINT ck_tb_item_desconto_max
CHECK (desconto_item <= (preco_unit * 0.50));
[cite: 10]

/*
  SIMULAÇÃO DE RESULTADO (Q4):
  Table TB_VENDA_ITEM altered.

  Análise: Constraints CHECK podem comparar colunas da mesma linha e bloqueiam
  descontos acima de 50% diretamente no INSERT/UPDATE[cite: 10].
*/


-- Questão 5: Garantia de Unicidade de Contato (UNIQUE)
-- Adiciona restrição UNIQUE na coluna telefone de tb_cliente[cite: 7, 10].
-- (Obs.: Caso a coluna telefone ainda não exista na sua tb_cliente, adicione-a antes via ALTER TABLE ADD telefone VARCHAR2(20))
ALTER TABLE tb_cliente
ADD CONSTRAINT uq_tb_cliente_telefone UNIQUE (telefone);
[cite: 10]

/*
  SIMULAÇÃO DE RESULTADO (Q5):
  Table TB_CLIENTE altered.

  Análise: Cria índice exclusivo para evitar telefones duplicados entre clientes.
  No Oracle, valores NULL não violam UNIQUE (vários clientes podem ter telefone NULL),
  mas valores preenchidos não podem se repetir[cite: 10].
*/


-- ==========================================================
-- PARTE 3: Comportamento de Exclusão (CASCADE vs. Soft Delete)
-- ==========================================================

-- Questão 6: Exclusão em Cascata (ON DELETE CASCADE)
-- Remove venda pai e confere se os itens filhos em tb_venda_item foram removidos[cite: 7, 11].
DELETE FROM tb_venda WHERE id_venda = 1;

SELECT * FROM tb_venda_item WHERE id_venda = 1;
[cite: 11]

/*
  SIMULAÇÃO DE RESULTADO (Q6):
  1 row deleted.
  no rows selected (na consulta de verificação em tb_venda_item)

  Análise: Com ON DELETE CASCADE na FK de itens para venda, excluir a venda apaga
  automaticamente os itens vinculados. O perigo do uso indiscriminado é apagar em
  cadeia grandes volumes de dados históricos acidentalmente por um DELETE mal filtrado[cite: 11].
*/


-- Questão 7: Exclusão Lógica (Soft Delete)
-- Desativa o vendedor logicamente (ativo = 'N') em vez de apagar fisicamente[cite: 8, 11].
UPDATE tb_vendedor
SET ativo = 'N'
WHERE id_vendedor = 1;
[cite: 11]

/*
  SIMULAÇÃO DE RESULTADO (Q7):
  1 row updated.

  Análise: Em bases corporativas com histórico comercial, o Soft Delete (ativo = 'N')
  impede novos vínculos/operações com o registro inativo sem destruir o histórico
  de vendas passadas, auditorias ou relatórios financeiros[cite: 11].
*/
