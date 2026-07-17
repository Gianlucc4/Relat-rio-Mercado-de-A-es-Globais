# Relatório de Mercado de Ações Globais 📈

Análise de desempenho e risco de índices e ativos globais entre 2020 e 2022, desenvolvida em Power BI com modelagem de dados estruturada em SQL Server.

## 🔗 Acesse o Dashboard
[Clique aqui para visualizar o dashboard no Power BI Service](https://app.powerbi.com/view?r=eyJrIjoiNDNjODUxY2EtOGRlYy00ZmQxLTllOWMtYWEyYjEzYmQ0NDkxIiwidCI6ImJkYzFhN2YzLTRmMTEtNGRlMS1hMzViLWMxOTEzMmI3MzY5YSJ9&pageName=726a4053de2836c76130)

## 📋 Sobre o Projeto
Este projeto analisa o comportamento de índices e ativos do mercado financeiro global entre 2020 e 2022, permitindo comparar desempenho, risco e retorno entre diferentes ativos ao longo do período.

A estrutura de dados foi construída em SQL Server antes da conexão com o Power BI, seguindo modelagem dimensional com tabelas staging, fato e dimensões.

## 🗄️ Modelagem SQL
O script completo de estruturação do banco de dados está disponível no arquivo `Criação de esquema e tabela.sql` neste repositório.

A modelagem contempla:
- **Schema M3** — organização das tabelas do projeto
- **STG_COTACOES_GLOBAIS** — tabela staging para ingestão bruta dos dados
- **F_COTACOES_GLOBAIS** — tabela fato com conversão de tipos e inserção tratada
- **D_ATIVOS** — dimensão com 12 ativos globais categorizados por classe, país, região e mercado
- **DCALENDARIO** — dimensão calendário gerada dinamicamente com 1.500 dias a partir de 2020
- **D_EVENTOS_HISTORICOS** — dimensão com eventos macroeconômicos e geopolíticos do período

## 📊 Páginas do Dashboard

### 1. Capa
Página inicial com navegação para as duas visões analíticas principais do relatório.

![Capa](Captura%20de%20tela%202026-07-16%20205754.png)

### 2. Análise Individual de Ativos
Visão detalhada por ativo selecionado: CAGR, retorno acumulado, volatilidade anualizada, fechamento fim do mês e volume de negociações. Inclui registro histórico de fechamentos e variações anuais por mês.

![Análise Individual](Captura%20de%20tela%202026-07-16%20205802.png)

### 3. Comparação de Desempenho
Comparativo entre todos os ativos: maior e menor retorno acumulado, maior e menor volatilidade anualizada, evolução comparativa base 100 e gráfico de dispersão Risco vs Retorno.

![Comparação de Desempenho](Captura%20de%20tela%202026-07-16%20205812.png)

### 4. Filtros
Página dedicada à seleção e filtragem de ativos para personalização das análises.

### 5. Glossário
Definição dos principais indicadores utilizados no relatório: CAGR, volatilidade anualizada, retorno acumulado e base 100.

## 🛠️ Ferramentas Utilizadas
- SQL Server (modelagem e estruturação do banco de dados)
- Power BI Desktop
- Power Query (ETL e transformação de dados)
- DAX (modelagem e métricas)
- Modelagem tabular

## 📁 Fonte de Dados
Base de dados fornecida como material de curso.

## 👤 Autor
**Gianlucca Ciconeli**
[LinkedIn](https://www.linkedin.com/in/gianlucca-ciconeli-a2a740303)
