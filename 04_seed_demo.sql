-- =========================================================
-- 04_seed_demo.sql  (somente exemplos extras p/ Dashboard)
-- Requisitos: schema + DML base previamente aplicados.
-- =========================================================
USE DIGIFAB;
START TRANSACTION;

-- ---------------------------------------------------------
-- LOTE MP extra para PET (suprir OPs de 08–09/09)
-- ---------------------------------------------------------
INSERT INTO LOTE_MP
  (ID_LOTE_MP, CODIGO, ID_MATERIA_PRIMA, ID_FORNECEDOR, NOTA_FISCAL,
   DATA_RECEBIMENTO, QUANTIDADE, DATA_VALIDADE, ID_RESPONSAVEL)
VALUES
  (5, 'LMP-PET-20250906-B', 1, 1, 'NF52345', '2025-09-06', 120.000, '2026-03-06', 2);

-- ---------------------------------------------------------
-- LOTES DE PRODUTO adicionais (05–09/09)
-- ---------------------------------------------------------
INSERT INTO LOTE_PRODUTO
  (ID_LOTE_PRODUTO, CODIGO, ID_PRODUTO, CIDADE_PRODUCAO, CODIGO_FABRICA, DATA_PRODUCAO)
VALUES
  (5,  'LP-TAM-20250905-1', 1, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-05'),
  (6,  'LP-GAR-20250905-1', 2, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-05'),
  (7,  'LP-ROT-20250905-1', 3, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-05'),
  (8,  'LP-GAR-20250906-1', 2, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-06'),
  (9,  'LP-TAM-20250906-1', 1, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-06'),
  (10, 'LP-POT-20250907-1', 4, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-07'),
  (11, 'LP-ROT-20250907-1', 3, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-07'),
  (12, 'LP-TAM-20250908-1', 1, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-08'),
  (13, 'LP-GAR-20250908-1', 2, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-08'),
  (14, 'LP-GAR-20250909-1', 2, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-09'),
  (15, 'LP-ROT-20250909-1', 3, 'PORTO ALEGRE', 'FAB-POA-01', '2025-09-09');

-- ---------------------------------------------------------
-- ORDENS DE PRODUÇÃO adicionais (05–09/09)
-- (linhas/horários variados p/ alimentar views de série)
-- ---------------------------------------------------------
INSERT INTO ORDEM_PRODUCAO
  (ID_ORDEM_PRODUCAO, CODIGO, ID_LOTE_PRODUTO, ID_LINHA_PRODUCAO, ID_RESPONSAVEL,
   QUANTIDADE_PRODUZIR, DT_HORA_INICIO)
VALUES
  (5,  'OP-20250905-001', 5,  1, 1, 3000, '2025-09-05 08:00:00'), -- tampas
  (6,  'OP-20250905-002', 6,  2, 2, 2000, '2025-09-05 09:00:00'), -- garrafas
  (7,  'OP-20250905-003', 7,  3, 3, 2000, '2025-09-05 10:00:00'), -- rótulos
  (8,  'OP-20250906-001', 8,  2, 2,  750, '2025-09-06 08:00:00'), -- garrafas
  (9,  'OP-20250906-002', 9,  1, 1, 2000, '2025-09-06 11:00:00'), -- tampas
  (10, 'OP-20250907-001', 10, 4, 1,  500, '2025-09-07 13:00:00'), -- potes
  (11, 'OP-20250907-002', 11, 3, 3, 1000, '2025-09-07 15:00:00'), -- rótulos
  (12, 'OP-20250908-001', 12, 1, 1, 4000, '2025-09-08 08:30:00'), -- tampas
  (13, 'OP-20250908-002', 13, 2, 2,  500, '2025-09-08 10:30:00'), -- garrafas
  (14, 'OP-20250909-001', 14, 2, 2, 1000, '2025-09-09 09:15:00'), -- garrafas
  (15, 'OP-20250909-002', 15, 3, 3, 3000, '2025-09-09 14:45:00'); -- rótulos

-- ---------------------------------------------------------
-- PLANEJAMENTO (MATERIA_PRIMA_ORDEM_PRODUCAO)
-- Combina BOM: PRD1->PEAD(0,006), PRD2->PET(0,020), PRD3->PP(0,001), PRD4->PEAD(0,060)
-- ---------------------------------------------------------
INSERT INTO MATERIA_PRIMA_ORDEM_PRODUCAO
  (ID_MATERIA_PRIMA_ORDEM_PRODUCAO, ID_ORDEM_PRODUCAO, ID_MATERIA_PRIMA, QUANTIDADE_PREVISTA)
VALUES
  (5,  5,  2,  18.000),  -- 3.000 tampas * 0,006
  (6,  6,  1,  40.000),  -- 2.000 garrafas * 0,020
  (7,  7,  3,   2.000),  -- 2.000 rótulos * 0,001
  (8,  8,  1,  15.000),  -- 750 garrafas * 0,020
  (9,  9,  2,  12.000),  -- 2.000 tampas * 0,006
  (10, 10, 2,  30.000),  -- 500 potes * 0,060 (PEAD)
  (11, 11, 3,   1.000),  -- 1.000 rótulos * 0,001
  (12, 12, 2,  24.000),  -- 4.000 tampas * 0,006
  (13, 13, 1,  10.000),  -- 500 garrafas * 0,020
  (14, 14, 1,  20.000),  -- 1.000 garrafas * 0,020
  (15, 15, 3,   3.000);  -- 3.000 rótulos * 0,001

-- ---------------------------------------------------------
-- CONSUMO REAL (CONSUMO_LOTE_MP)
-- Ajustado para não estourar saldo dos lotes existentes.
-- ---------------------------------------------------------
INSERT INTO CONSUMO_LOTE_MP
  (ID_CONSUMO_LOTE_MP, ID_ORDEM_PRODUCAO, ID_LOTE_MP, QUANTIDADE_CONSUMIDA, DATA_CONSUMO)
VALUES
  (6,  5,  4,  17.800, '2025-09-05 12:00:00'), -- tampas (PEAD) do lote 4
  (7,  6,  1,  40.000, '2025-09-05 16:00:00'), -- garrafas (PET) do lote 1
  (8,  7,  3,   2.000, '2025-09-05 14:30:00'), -- rótulos (PP)   do lote 3
  (9,  8,  1,  15.000, '2025-09-06 11:00:00'), -- garrafas (PET) do lote 1
  (10, 9,  4,  12.000, '2025-09-06 15:00:00'), -- tampas (PEAD)  do lote 4
  (11,10, 4,  30.000, '2025-09-07 17:00:00'), -- potes  (PEAD)  do lote 4
  (12,11, 3,   1.000, '2025-09-07 15:30:00'), -- rótulos (PP)   do lote 3
  (13,12, 2,  24.000, '2025-09-08 12:00:00'), -- tampas (PEAD)  do lote 2
  (14,13, 5,  10.000, '2025-09-08 13:30:00'), -- garrafas (PET) do lote 5 (novo)
  (15,14, 5,  20.000, '2025-09-09 16:00:00'), -- garrafas (PET) do lote 5
  (16,15, 3,   3.000, '2025-09-09 18:00:00'); -- rótulos (PP)   do lote 3

COMMIT;

-- Dicas para testar rapidamente as views:
-- SELECT * FROM VW_PRODUCAO_POR_DIA_LINHA WHERE DIA BETWEEN '2025-09-05' AND '2025-09-10' ORDER BY DIA, CODIGO_LINHA;
-- SELECT * FROM VW_CONSUMO_MP_POR_DIA    WHERE DIA BETWEEN '2025-09-05' AND '2025-09-10' ORDER BY DIA, CODIGO_MP;
-- SELECT * FROM VW_UTILIZACAO_LINHA_DIA  WHERE DIA BETWEEN '2025-09-05' AND '2025-09-10' ORDER BY LINHA, DIA;