USE DIGIFAB;
START TRANSACTION;

-- =============================
-- USUARIOS
-- =============================
INSERT INTO USUARIO (ID_USUARIO, EMAIL, NOME) VALUES
(1, 'ana_bolizante@xyz.com', 'Ana Bolizante'),
(2, 'paul_arara@email.com', 'Paul de Arara'),
(3, 'inocencio_coitadinho@abc.com', 'Inocêncio Coitadinho'),
(4, 'maria_privada@avc.com', 'Maria Privada de Jesus'),
(5, 'armando_guerra@xyz.com', 'Pacífico Armando Guerra');

-- =============================
-- LINHAS DE PRODUCAO
-- =============================
INSERT INTO LINHA_PRODUCAO (ID_LINHA_PRODUCAO, CODIGO, NOME, CAPACIDADE_MAX, DESCRICAO, STATUS, ID_RESPONSAVEL) VALUES
(1, 'LIN-001', 'Linha Injeção de Tampas', 12000, 'Máquinas de injeção para tampas 28mm', 'ATIVA', 1),
(2, 'LIN-002', 'Linha Sopro de Garrafas',  8000, 'Sopro de garrafas PET 500ml',          'ATIVA', 2),
(3, 'LIN-003', 'Linha Impressão de Rótulos', 20000, 'Impressão flexográfica de rótulos BOPP', 'ATIVA', 3),
(4, 'LIN-004', 'Linha Extrusão de Potes',   4000, 'Extrusão e termoformagem de potes 1L', 'ATIVA', 1);

-- =============================
-- PRODUTOS (embalagens/rótulos/tampas)
-- =============================
INSERT INTO PRODUTO (ID_PRODUTO, CODIGO, NOME, PESO_BRUTO, UNIDADE_MEDIDA, CODIGO_BARRAS) VALUES
(1, 'PRD-TAM-28',  'TAMPA 28MM PEAD',        0.006, 'UND', '7891234567890'),
(2, 'PRD-GAR-500', 'GARRAFA PET 500ML',      0.020, 'UND', '7891234567891'),
(3, 'PRD-ROT-500', 'ROTULO BOPP 500ML',      0.001, 'UND', '7891234567892'),
(4, 'PRD-POT-1L',  'POTE PEAD 1L',           0.060, 'UND', '7891234567893');

-- =============================
-- FORNECEDORES (recicladoras, catadores, atravessadores)
-- =============================
INSERT INTO FORNECEDOR (ID_FORNECEDOR, CODIGO, NOME) VALUES
(1, 'FOR-REC-001',  'RECICLADORA GAIA LTDA'),
(2, 'FOR-COOP-002', 'COOPERATIVA CATADORES SOL NASCENTE'),
(3, 'FOR-ATR-003',  'ATRAVESSADOR ECOLOG COMERCIAL'),
(4, 'FOR-COOP-004', 'COOPERATIVA VERDE VIDA');

-- =============================
-- MATERIAS-PRIMAS (resíduos recicláveis)
-- =============================
INSERT INTO MATERIA_PRIMA (ID_MATERIA_PRIMA, CODIGO, NOME, TEMP_MIN, TEMP_MAX, UNIDADE_MEDIDA) VALUES
(1, 'MP-PET',  'PLASTICO PET RECICLADO (FLAKES/GRANULADO)', 5.00, 30.00, 'KG'),
(2, 'MP-PEAD', 'POLIETILENO ALTA DENSIDADE RECICLADO (PEAD)', 5.00, 30.00, 'KG'),
(3, 'MP-PP',   'POLIPROPILENO RECICLADO (PP)',               5.00, 30.00, 'KG');

-- =============================
-- LOTES DE MP
-- =============================
INSERT INTO LOTE_MP (ID_LOTE_MP, CODIGO, ID_MATERIA_PRIMA, ID_FORNECEDOR, NOTA_FISCAL, DATA_RECEBIMENTO, QUANTIDADE, DATA_VALIDADE, ID_RESPONSAVEL) VALUES
(1, 'LMP-PET-20250901-A',  1, 1, 'NF12345', '2025-09-01', 150.000, '2026-03-01', 5),
(2, 'LMP-PEAD-20250902-A', 2, 2, 'NF22345', '2025-09-02', 200.000, '2026-03-02', 3),
(3, 'LMP-PP-20250903-A',   3, 3, 'NF32345', '2025-09-03',  50.000, '2026-03-03', 1),
(4, 'LMP-PEAD-20250904-B', 2, 4, 'NF42345', '2025-09-04', 100.000, '2026-03-04', 2);

-- =============================
-- LOTES DE PRODUTO
-- =============================
INSERT INTO LOTE_PRODUTO (ID_LOTE_PRODUTO, CODIGO, ID_PRODUTO, CIDADE_PRODUCAO, CODIGO_FABRICA, DATA_PRODUCAO) VALUES
(1, 'LP-TAM-20250910-1', 1, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-10'),
(2, 'LP-GAR-20250910-1', 2, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-10'),
(3, 'LP-ROT-20250910-1', 3, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-10'),
(4, 'LP-POT-20250910-1', 4, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-10');

-- =============================
-- ORDENS DE PRODUCAO
-- =============================
INSERT INTO ORDEM_PRODUCAO (ID_ORDEM_PRODUCAO, CODIGO, ID_LOTE_PRODUTO, ID_LINHA_PRODUCAO, ID_RESPONSAVEL, QUANTIDADE_PRODUZIR, DT_HORA_INICIO) VALUES
(1, 'OP-20250910-001', 1, 1, 1, 10000, '2025-09-10 08:30:00'), -- tampas
(2, 'OP-20250910-002', 2, 2, 2,  5000, '2025-09-10 09:00:00'), -- garrafas
(3, 'OP-20250910-003', 3, 3, 3,  8000, '2025-09-10 09:30:00'), -- rótulos
(4, 'OP-20250910-004', 4, 4, 1,  2000, '2025-09-10 10:00:00'); -- potes

-- =============================
-- BOM (PRODUTO x MP)
-- =============================
INSERT INTO MATERIA_PRIMA_PRODUTO (ID_MATERIA_PRIMA_PRODUTO, ID_PRODUTO, ID_MATERIA_PRIMA, QUANTIDADE_UNIDADE) VALUES
(1, 1, 2, 0.006),  -- Tampa 28mm usa PEAD
(2, 2, 1, 0.020),  -- Garrafa 500ml usa PET
(3, 3, 3, 0.001),  -- Rótulo usa PP (BOPP)
(4, 4, 2, 0.060);  -- Pote 1L usa PEAD

-- =============================
-- PLANEJAMENTO DE MP POR OP
-- =============================
INSERT INTO MATERIA_PRIMA_ORDEM_PRODUCAO (ID_MATERIA_PRIMA_ORDEM_PRODUCAO, ID_ORDEM_PRODUCAO, ID_MATERIA_PRIMA, QUANTIDADE_PREVISTA) VALUES
(1, 1, 2,  60.000),  -- 10.000 tampas * 0,006 kg
(2, 2, 1, 100.000),  -- 5.000 garrafas * 0,020 kg
(3, 3, 3,   8.000),  -- 8.000 rótulos * 0,001 kg
(4, 4, 2, 120.000);  -- 2.000 potes * 0,060 kg

-- =============================
-- CONSUMO REAL POR LOTE DE MP (opcional)
-- =============================
INSERT INTO CONSUMO_LOTE_MP (ID_CONSUMO_LOTE_MP, ID_ORDEM_PRODUCAO, ID_LOTE_MP, QUANTIDADE_CONSUMIDA, DATA_CONSUMO) VALUES
(1, 1, 2,  60.000, '2025-09-10 12:00:00'), -- OP1 consome PEAD do lote 2
(2, 2, 1,  95.000, '2025-09-10 15:00:00'), -- OP2 consome PET do lote 1 (parcial)
(3, 3, 3,   7.900, '2025-09-10 14:00:00'), -- OP3 consome PP do lote 3
(4, 4, 2, 100.000, '2025-09-10 17:00:00'), -- OP4 consome PEAD lote 2 (parcial)
(5, 4, 4,  20.000, '2025-09-10 17:30:00'); -- OP4 completa consumo com PEAD lote 4

COMMIT;