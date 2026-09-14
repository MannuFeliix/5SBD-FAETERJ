-- ==========================================================
-- Matéria: 5SBD - Programação de Scripts de Banco de Dados
-- Atividade: Atividade Prática 02: Carga de Dados Iniciais (Seed)
-- Ferramenta: Oracle APEX | Turno: Manhã | 2026.2
-- Aluna(a): Manuelle
-- ==========================================================

-- Objetivo: Executar comandos DDL e DML no ambiente Oracle APEX 
-- para criar a tabela de calendário e popular o banco de dados com 
-- dados fictícios realistas (categorias, clientes, vendedores, produtos, vendas e itens).

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- ---------------------------------------------------------------------
-- ESTRUTURA AUXILIAR PARA CALENDÁRIO
-- ---------------------------------------------------------------------
CREATE TABLE tb_calendario (
    dt_ref DATE CONSTRAINT pk_tb_calendario PRIMARY KEY,
    ano NUMBER(4),
    mes NUMBER(2),
    dia NUMBER(2),
    trimestre NUMBER(1),
    nome_mes VARCHAR2(15),
    dia_semana NUMBER(1),
    nome_dia_semana VARCHAR2(15)
);

-- ---------------------------------------------------------------------
-- POPULANDO TB_CATEGORIA
-- ---------------------------------------------------------------------
INSERT INTO tb_categoria (id_categoria, nome) VALUES (1, 'Tecnologia e Informática');
INSERT INTO tb_categoria (id_categoria, nome) VALUES (2, 'Eletrodomésticos');
INSERT INTO tb_categoria (id_categoria, nome) VALUES (3, 'Móveis e Decoração');
INSERT INTO tb_categoria (id_categoria, nome) VALUES (4, 'Papelaria e Escritório');
INSERT INTO tb_categoria (id_categoria, nome) VALUES (5, 'Esporte e Lazer');

-- ---------------------------------------------------------------------
-- POPULANDO TB_CLIENTE
-- ---------------------------------------------------------------------
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (1, 'Ana Silva', 'ana.silva@email.com', '12345678901', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (2, 'Bruno Santos', 'bruno.santos@email.com', '23456789012', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (3, 'Carlos Oliveira', 'carlos.oliveira@email.com', '34567890123', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (4, 'Daniela Lima', 'daniela.lima@email.com', '45678901234', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (5, 'Eduardo Pereira', 'eduardo.pereira@email.com', '56789012345', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (6, 'Fernanda Souza', 'fernanda.souza@email.com', '67890123456', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (7, 'Gabriel Costa', 'gabriel.costa@email.com', '78901234567', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (8, 'Helena Rodrigues', 'helena.rodrigues@email.com', '89012345678', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (9, 'Igor Alves', 'igor.alves@email.com', '90123456789', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (10, 'Juliana Martins', 'juliana.martins@email.com', '01234567890', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (11, 'Lucas Ribeiro', 'lucas.ribeiro@email.com', '11223344556', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (12, 'Mariana Carvalho', 'mariana.carvalho@email.com', '22334455667', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (13, 'Nicolas Gomes', 'nicolas.gomes@email.com', '33445566778', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (14, 'Olivia Pinto', 'olivia.pinto@email.com', '44556677889', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (15, 'Pedro Rocha', 'pedro.rocha@email.com', '55667788990', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (16, 'Rafaela Barbosa', 'rafaela.barbosa@email.com', '66778899001', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (17, 'Samuel Teixeira', 'samuel.teixeira@email.com', '77889900112', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (18, 'Tatiana Castro', 'tatiana.castro@email.com', '88990011223', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (19, 'Vinicius Melo', 'vinicius.melo@email.com', '99001122334', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (20, 'Yasmin Cardoso', 'yasmin.cardoso@email.com', '00112233445', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (21, 'Andreia Santos', 'andreia.santos@email.com', '12312312312', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (22, 'Caio Ferreira', 'caio.ferreira@email.com', '45645645645', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (23, 'Letícia Neves', 'leticia.neves@email.com', '78978978978', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (24, 'Rodrigo Dias', 'rodrigo.dias@email.com', '98798798798', 'S');
INSERT INTO tb_cliente (id_cliente, nome, email, cpf, ativo) VALUES (25, 'Camila Fonseca', 'camila.fonseca@email.com', '65465465465', 'S');

-- ---------------------------------------------------------------------
-- POPULANDO TB_VENDEDOR
-- ---------------------------------------------------------------------
INSERT INTO tb_vendedor (id_vendedor, nome, email, ativo) VALUES (1, 'Marcos Pontes', 'marcos.pontes@vendas.com', 'S');
INSERT INTO tb_vendedor (id_vendedor, nome, email, ativo) VALUES (2, 'Patricia Ramos', 'patricia.ramos@vendas.com', 'S');
INSERT INTO tb_vendedor (id_vendedor, nome, email, ativo) VALUES (3, 'Roberto Carlos', 'roberto.carlos@vendas.com', 'S');
INSERT INTO tb_vendedor (id_vendedor, nome, email, ativo) VALUES (4, 'Sandra Alencar', 'sandra.alencar@vendas.com', 'S');
INSERT INTO tb_vendedor (id_vendedor, nome, email, ativo) VALUES (5, 'Thiago Silva', 'thiago.silva@vendas.com', 'S');
INSERT INTO tb_vendedor (id_vendedor, nome, email, ativo) VALUES (6, 'Regina Duarte', 'regina.duarte@vendas.com', 'S');

-- ---------------------------------------------------------------------
-- POPULANDO TB_PRODUTO
-- ---------------------------------------------------------------------
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (1, 1, 'PROD-NOTE-01', 'Notebook Gamer Core i7 16GB', 4500.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (2, 1, 'PROD-MOU-02', 'Mouse Sem Fio Ergonômico', 120.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (3, 1, 'PROD-KEY-03', 'Teclado Mecânico RGB', 250.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (4, 1, 'PROD-MON-04', 'Monitor UltraWide 29 polegadas', 1100.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (5, 2, 'PROD-GEL-05', 'Geladeira Frost Free 400L', 3200.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (6, 2, 'PROD-MIC-06', 'Micro-ondas Digital 30L', 650.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (7, 2, 'PROD-AIR-07', 'Fritadeira Elétrica Airfryer', 450.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (8, 2, 'PROD-LIQ-08', 'Liquidificador 1200W', 180.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (9, 3, 'PROD-CAD-09', 'Cadeira de Escritório Presidente', 850.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (10, 3, 'PROD-MES-10', 'Mesa de Escritório em L', 450.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (11, 3, 'PROD-SOF-11', 'Sofá Retrátil 3 Lugares', 1900.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (12, 3, 'PROD-EST-12', 'Estante para Livros Multiuso', 350.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (13, 4, 'PROD-AGE-13', 'Agenda Executiva 2026', 45.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (14, 4, 'PROD-CAN-14', 'Kit Canetas Coloridas Gel (12 un)', 35.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (15, 4, 'PROD-RES-15', 'Resma de Papel A4 500 fls', 28.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (16, 4, 'PROD-ORG-16', 'Organizador de Mesa Acrílico', 60.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (17, 5, 'PROD-BIK-17', 'Bicicleta Aro 29 Alumínio 21M', 1500.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (18, 5, 'PROD-TAP-18', 'Tapete de Yoga Antiderrapante', 80.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (19, 5, 'PROD-GAR-19', 'Garrafa Térmica Esportiva 750ml', 95.00);
INSERT INTO tb_produto (id_produto, id_categoria, sku, nome, preco_unit) VALUES (20, 5, 'PROD-BOC-20', 'Bola de Futebol Oficial', 120.00);

-- ---------------------------------------------------------------------
-- POPULANDO TB_VENDA E TB_VENDA_ITEM
-- ---------------------------------------------------------------------
INSERT INTO tb_venda (id_venda, id_cliente, id_vendedor, dt_venda, valor_liquido, canal, status) VALUES (1, 21, 2, TO_DATE('2026-05-17', 'YYYY-MM-DD'), 1476.50, 'SITE', 'FECHADA');
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (1, 1, 13, 3, 45.00, ROUND((0.00 / (3 * 45.00)) * 100, 2), 135.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (2, 1, 9, 1, 850.00, ROUND((127.50 / (1 * 850.00)) * 100, 2), 722.50);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (3, 1, 18, 2, 80.00, ROUND((0.00 / (2 * 80.00)) * 100, 2), 160.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (4, 1, 8, 3, 180.00, ROUND((81.00 / (3 * 180.00)) * 100, 2), 459.00);

INSERT INTO tb_venda (id_venda, id_cliente, id_vendedor, dt_venda, valor_liquido, canal, status) VALUES (2, 7, 6, TO_DATE('2026-05-08', 'YYYY-MM-DD'), 12099.00, 'TELEFONE', 'ABERTA');
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (5, 2, 5, 3, 3200.00, ROUND((480.00 / (3 * 3200.00)) * 100, 2), 9120.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (6, 2, 9, 3, 850.00, ROUND((255.00 / (3 * 850.00)) * 100, 2), 2295.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (7, 2, 20, 3, 120.00, ROUND((36.00 / (3 * 120.00)) * 100, 2), 324.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (8, 2, 8, 2, 180.00, ROUND((0.00 / (2 * 180.00)) * 100, 2), 360.00);

INSERT INTO tb_venda (id_venda, id_cliente, id_vendedor, dt_venda, valor_liquido, canal, status) VALUES (3, 5, 5, TO_DATE('2026-05-07', 'YYYY-MM-DD'), 8640.00, 'APP', 'FECHADA');
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (9, 3, 5, 3, 3200.00, ROUND((960.00 / (3 * 3200.00)) * 100, 2), 8640.00);

INSERT INTO tb_venda (id_venda, id_cliente, id_vendedor, dt_venda, valor_liquido, canal, status) VALUES (4, 20, 1, TO_DATE('2026-04-09', 'YYYY-MM-DD'), 11425.50, 'TELEFONE', 'CANCELADA');
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (10, 4, 17, 3, 1500.00, ROUND((0.00 / (3 * 1500.00)) * 100, 2), 4500.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (11, 4, 9, 3, 850.00, ROUND((127.50 / (3 * 850.00)) * 100, 2), 2422.50);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (12, 4, 18, 3, 80.00, ROUND((12.00 / (3 * 80.00)) * 100, 2), 228.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (13, 4, 1, 1, 4500.00, ROUND((225.00 / (1 * 4500.00)) * 100, 2), 4275.00);

INSERT INTO tb_venda (id_venda, id_cliente, id_vendedor, dt_venda, valor_liquido, canal, status) VALUES (5, 14, 2, TO_DATE('2026-04-27', 'YYYY-MM-DD'), 3150.00, 'APP', 'ABERTA');
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (14, 5, 17, 1, 1500.00, ROUND((225.00 / (1 * 1500.00)) * 100, 2), 1275.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (15, 5, 6, 3, 650.00, ROUND((195.00 / (3 * 650.00)) * 100, 2), 1755.00);
INSERT INTO tb_venda_item (id_venda_item, id_venda, id_produto, quantidade, valor_unit, percentual_desconto, valor_total) VALUES (16, 5, 20, 1, 120.00, ROUND((0.00 / (1 * 120.00)) * 100, 2), 120.00);

-- ---------------------------------------------------------------------
-- POPULANDO TB_CALENDARIO
-- ---------------------------------------------------------------------
INSERT INTO tb_calendario (dt_ref, ano, mes, dia, trimestre, nome_mes, dia_semana, nome_dia_semana) VALUES (TO_DATE('2026-01-01', 'YYYY-MM-DD'), 2026, 1, 1, 1, 'Janeiro', 4, 'Quinta-feira');
INSERT INTO tb_calendario (dt_ref, ano, mes, dia, trimestre, nome_mes, dia_semana, nome_dia_semana) VALUES (TO_DATE('2026-01-02', 'YYYY-MM-DD'), 2026, 1, 2, 1, 'Janeiro', 5, 'Sexta-feira');
INSERT INTO tb_calendario (dt_ref, ano, mes, dia, trimestre, nome_mes, dia_semana, nome_dia_semana) VALUES (TO_DATE('2026-01-03', 'YYYY-MM-DD'), 2026, 1, 3, 1, 'Janeiro', 6, 'Sábado');

COMMIT;

/* 
  RESULTADO DA EXECUÇÃO NO ORACLE APEX:
  Statement processed.
  Table created. (tb_calendario)
  Rows inserted successfully.
  Commit complete.
*/
