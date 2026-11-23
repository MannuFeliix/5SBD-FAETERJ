-- ==========================================================
-- Matéria: 5SBD - Programação de Scripts de Banco de Dados
-- Atividade: Atividade Prática 05: Modelagem Física e Qualidade de Dados (Constraints)
-- Ferramenta: Oracle APEX | Turno: Manhã | 2026.2
-- Aluna: Manuelle
-- ==========================================================


-- ==========================================================
-- PARTE 1: Testando a Resiliência (O Princípio de "Falhar Cedo")
-- ==========================================================

-- Questão 1: Violação de Chave Estrangeira (FK)[cite: 2, 4]
INSERT INTO tb_venda (id_cliente, id_vendedor, dt_venda, status, canal)
VALUES (9999, 1, SYSDATE, 'ABERTA', 'LOJA');[cite: 4]

/*
  RESULTADO / ERRO ESPERADO (Q1):
  ORA-02291: integrity constraint (FK_TB_VENDA_CLIENTE) violated - parent key not found[cite: 4]
  - A FK exige que o cliente exista previamente em tb_cliente, evitando vendas órfãs[cite: 4].
*/


-- Questão 2: Violação de Domínio (CHECK Constraint)[cite: 2, 4]
UPDATE tb_venda
SET status = 'PENDENTE'
WHERE id_venda = 1;[cite: 4]

/*
  RESULTADO / ERRO ESPERADO (Q2):
  ORA-02290: check constraint (CK_TB_VENDA_STATUS) violated[cite: 4]
  - A constraint CHECK restringe o status aos valores 'ABERTA', 'FECHADA' ou 'CANCELADA'
    diretamente no banco, protegendo contra falhas na aplicação ou integrações[cite: 4].
*/


-- Questão 3: Impedindo Preços Absurdos[cite: 2, 4]
INSERT INTO tb_produto (id_categoria, sku, nome, preco_unit)
VALUES (1, 'SKU-TEMP-01', 'Produto Teste Negativo', -15.00);[cite: 5]

/*
  RESULTADO / ERRO ESPERADO (Q3):
  ORA-02290: check constraint (CK_TB_PRODUTO_PRECO) violated[cite: 4, 5]
  - A constraint CHECK (preco_unit > 0) bloqueia preços negativos ou zerados no catálogo[cite: 5].
*/


-- ==========================================================
-- PARTE 2: Evoluindo a Modelagem Física (DDL)
-- ==========================================================

-- Questão 4: Limite de Desconto de Itens (CHECK)[cite: 2, 5]
ALTER TABLE tb_venda_item
ADD CONSTRAINT ck_tb_item_desconto_max
CHECK (desconto_item <= (preco_unit * 0.50));[cite: 5]

/*
  RESULTADO (Q4):
  Table TB_VENDA_ITEM altered.
  - Impede no INSERT/UPDATE que desconto_item ultrapasse 50% do preco_unit[cite: 5].
*/


-- Questão 5: Garantia de Unicidade de Contato (UNIQUE)[cite: 2, 5]
ALTER TABLE tb_cliente
ADD CONSTRAINT uq_tb_cliente_telefone UNIQUE (telefone);[cite: 5]

/*
  RESULTADO (Q5):
  Table TB_CLIENTE altered.
  - Cria índice exclusivo para impedir telefones duplicados (valores NULL são permitidos)[cite: 5].
*/


-- ==========================================================
-- PARTE 3: Comportamento de Exclusão (CASCADE vs. Soft Delete)
-- ==========================================================

-- Questão 6: Exclusão em Cascata (ON DELETE CASCADE)[cite: 2, 6]
DELETE FROM tb_venda WHERE id_venda = 1;[cite: 6]

SELECT * FROM tb_venda_item WHERE id_venda = 1;[cite: 6]

/*
  RESULTADO (Q6):
  1 row deleted.
  no rows selected (na consulta em tb_venda_item)
  - A FK com ON DELETE CASCADE apaga automaticamente os itens filhos da venda removida;
    o risco é excluir dados históricos em cadeia se o DELETE não for bem filtrado[cite: 2, 6].
*/


-- Questão 7: Exclusão Lógica (Soft Delete)[cite: 3, 6]
UPDATE tb_vendedor
SET ativo = 'N'
WHERE id_vendedor = 1;[cite: 6]

/*
  RESULTADO (Q7):
  1 row updated.
  - Inativa o vendedor (ativo = 'N') sem quebrar a integridade referencial nem perder
    o histórico de vendas passadas[cite: 3, 6].
*/
