**DIGIFAB DB — Schema, Seeds e Consultas**

- **Resumo:** Base MySQL 8 para um cenário de manufatura/reciclagem com produtos, matérias‑primas, lotes, ordens de produção e consumo real. Inclui views para análises e um conjunto de consultas para dashboards sobre 05–10/09/2025.
- **Público‑alvo:** times de dados, engenharia e quem precisa montar rapidamente um ambiente de demonstração/estudo.

**Requisitos**

- **MySQL 8.x:** servidor local funcionando e cliente `mysql` disponível no terminal.
- Opcional: **MySQL Workbench** (para abrir `Modelo_Logico.mwb`).

**Como Subir o Banco (passo a passo)**

1) Criar schema e tabelas
- Com `root` (ou outro usuário com privilégios), rode: `mysql -u root -p < 01_create_tables.sql`
- O script:
  - Cria o schema `DIGIFAB` (utf8mb4),
  - Cria o usuário `digifab`/`digifab` com acesso ao schema,
  - Faz drops seguros e recria todas as tabelas.

2) Inserir dados base (cadastros, lotes, OPs, BOM, planejamento, consumos)
- Rode: `mysql -u root -p < 02_insert_tables.sql`

3) Criar as views analíticas
- Rode: `mysql -u root -p < 03_create_views.sql`

4) Opcional — sementes extras para demos (séries em 05–10/09)
- Rode: `mysql -u root -p < 04_seed_demo.sql`

5) Explorar consultas de dashboard (defina o período)
- Abra `05_queries_dashboard.sql` e use variáveis de período, por exemplo:
  - `SET @DATA_INI = '2025-09-05';`
  - `SET @DATA_FIM = '2025-09-10';`
- Em seguida, execute os blocos desejados (A–K) contra o schema `DIGIFAB`.

Observações

- Os scripts podem ser reexecutados com segurança: `01_create_tables.sql` contém `DROP TABLE IF EXISTS` antes de criar tabelas.
- Depois do passo 1, você pode se conectar com o usuário de aplicação: `mysql -u digifab -p DIGIFAB` (senha: `digifab`).
- Os dados de `04_seed_demo.sql` assumem que os passos 1–3 e `02_insert_tables.sql` já foram aplicados.

**O que cada arquivo faz**

- `01_create_tables.sql`: cria o schema `DIGIFAB`, o usuário `digifab`, e todas as tabelas base:
  - `USUARIO`: cadastro de usuários/responsáveis.
  - `PRODUTO`: itens fabricados (código, nome, peso, etc.).
  - `FORNECEDOR`: origens de matéria‑prima (recicladoras/cooperativas/etc.).
  - `MATERIA_PRIMA`: tipos de MP (PET, PEAD, PP), faixas de temperatura e unidade.
  - `LINHA_PRODUCAO`: linhas com capacidade/hora e status.
  - `LOTE_PRODUTO`: lotes de produção por produto e data.
  - `LOTE_MP`: lotes recebidos de MP, fornecedor, validade e quantidade.
  - `ORDEM_PRODUCAO`: OPs com linha, lote de produto, responsável e quantidade a produzir.
  - `MATERIA_PRIMA_PRODUTO`: BOM (MP por produto e quantidade/unidade).
  - `MATERIA_PRIMA_ORDEM_PRODUCAO`: planejamento de MP por OP.
  - `CONSUMO_LOTE_MP`: consumo real de MP por OP e por lote.

- `02_insert_tables.sql`: insere um conjunto base e coerente de dados para cadastros, lotes, OPs, BOM, planejamento e consumos (útil para validar o schema rapidamente).

- `03_create_views.sql`: cria as views analíticas usadas nas consultas e dashboards:
  - `VW_OP_BASICA`: base com OP × linha × produto × lote (join útil para reaproveitar).
  - `VW_PRODUCAO_POR_DIA_LINHA`: produção planejada por dia e por linha.
  - `VW_PRODUCAO_POR_PRODUTO`: produção planejada agregada por produto.
  - `VW_CONSUMO_MP`: consumo agregado por tipo de MP.
  - `VW_CONSUMO_MP_POR_DIA`: consumo de MP por dia.
  - `VW_PLANEJADO_CONSUMIDO_OP_MP`: planejado × consumido por OP e MP (com desvio).
  - `VW_PLANEJADO_CONSUMIDO_MP`: planejado × consumido agregado por MP (com desvio).
  - `VW_SALDO_LOTE_MP`: saldo por lote de MP (entrada, consumo, saldo).
  - `VW_SALDO_MP`: saldo agregado por MP.
  - `VW_RASTREABILIDADE_CONSUMO`: rastreabilidade (OP × lotes de MP consumidos × lote de produto).
  - `VW_OP_POR_LINHA_DIA` e `VW_UTILIZACAO_LINHA_DIA`: apoio a análises de utilização/capacidade.

- `04_seed_demo.sql`: adiciona mais lotes, OPs, planejamentos e consumos cobrindo 05–10/09/2025 para enriquecer séries temporais e exemplos de desvios e utilização.

- `05_queries_dashboard.sql`: conjunto de consultas exemplo para dashboards/KPIs, organizado em blocos:
  - A) Série: Produção por dia × linha.
  - B) Top produtos no período.
  - C) Série: Consumo de MP por dia.
  - D) Consumo de MP por tipo (pizza/barras no período).
  - E) Desvios por OP e MP (tabela/detalhe).
  - F) Ranking de desvios por OP.
  - G) Planejado × consumido agregado por MP (restrito ao período).
  - H) Inventário: saldo por lote de MP.
  - I) Inventário: saldo agregado por MP.
  - J) Série: utilização por linha por dia.
  - K) Top linhas por utilização média no período.

- `Modelo_Logico.mwb`: modelo lógico no formato do MySQL Workbench.
- `Modelo_Logico.png`: imagem do diagrama lógico para consulta rápida.

**Dicas rápidas de uso**

- Conectar e validar rapidamente:
  - `mysql -u digifab -p DIGIFAB -e "SHOW TABLES;"`
  - `mysql -u digifab -p DIGIFAB -e "SELECT * FROM VW_PRODUCAO_POR_DIA_LINHA;"`
- Ajuste o período das consultas com `@DATA_INI` e `@DATA_FIM` para filtrar séries e KPIs.
- Caso use Workbench, execute os arquivos na ordem 01 → 02 → 03 → (opcional 04) → 05.

**Problemas comuns**

- Erro de permissão: rode o passo 1 com um usuário que tenha `CREATE USER`/`GRANT` ou remova essas linhas e crie o usuário manualmente.
- Charset/Collation: o schema usa `utf8mb4` e `utf8mb4_0900_ai_ci` (MySQL 8). Em MySQL mais antigos, ajuste a collation.

—
Mantido em `DIGIFAB` para fins didáticos e de demonstração.

