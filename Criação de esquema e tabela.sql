USE BD_MERCADO_ACOES
GO

-- CRIANDO SCHEMAS


CREATE SCHEMA M3;

-- CRIANDO TABELAS



-- STG HISTÓRICO DE COTAÇÕES 2020 - 2022


CREATE TABLE M3.STG_COTACOES_GLOBAIS (
    TICKER              VARCHAR (15) NOT NULL,
    DATA_COTACAO        DATE         NOT NULL,
    ABERTURA            VARCHAR (50) NOT NULL,
    ALTA                VARCHAR (50) NOT NULL,
    BAIXA               VARCHAR (50) NOT NULL,
    FECHAMENTO          VARCHAR (50) NOT NULL,
    FECHAMENTO_AJUSTADO VARCHAR (50) NOT NULL,
    VOLUME              VARCHAR (50) NOT NULL
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------



-- FATO HISTÓRICO DE COTAÇÕES


CREATE TABLE M3.F_COTACOES_GLOBAIS (
    TICKER              VARCHAR (15) NOT NULL,
    DATA_COTACAO        DATE         NOT NULL,
    ABERTURA            DECIMAL(38,15) NOT NULL,
    ALTA                DECIMAL(38,15) NOT NULL,
    BAIXA               DECIMAL(38,15) NOT NULL,
    FECHAMENTO          DECIMAL(38,15) NOT NULL,
    FECHAMENTO_AJUSTADO DECIMAL(38,15) NOT NULL,
    VOLUME              DECIMAL(38,15) NOT NULL
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------



-- IMPORTAÇÃO STG PARA FATO

INSERT INTO m3.F_COTACOES_GLOBAIS
SELECT TICKER,
       DATA_COTACAO,
       CAST (ABERTURA AS DECIMAL (38, 15)) AS ABERTURA,
       CAST (ALTA AS DECIMAL (38, 15)) AS ALTA,
       CAST (BAIXA AS DECIMAL (38, 15)) AS BAIXA,
       CAST (FECHAMENTO AS DECIMAL (38, 15)) AS FECHAMENTO,
       CAST (FECHAMENTO_AJUSTADO AS DECIMAL (38, 15)) AS FECHAMENTO_AJUSTADO,
       CAST (VOLUME AS DECIMAL (20, 1)) AS VOLUME
FROM   M3.STG_COTACOES_GLOBAIS;

--------------------------------------------------------------------------------------------------------------------------------------------------------------



-- TABELA ATIVOS 

CREATE TABLE M3.D_ATIVOS (
    TICKER       VARCHAR (15)  PRIMARY KEY,
    NOME_ATIVO   VARCHAR (100) NOT NULL,
    CLASSE_ATIVO VARCHAR (50)  NOT NULL,
    PAIS         VARCHAR (50)  NOT NULL,
    REGIAO       VARCHAR (50)  NOT NULL,
    MERCADO      VARCHAR (50)  NOT NULL,
    REFERENCIA   VARCHAR (100) NOT NULL
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------


-- INFORMAÇÃO ATIVOS



INSERT  INTO M3.D_ATIVOS (TICKER, NOME_ATIVO, CLASSE_ATIVO, PAIS, REGIAO, MERCADO, REFERENCIA)
VALUES                  ('^GSPC', 'S&P 500', 'Índice acionário', 'Estados Unidos', 'América do Norte', 'Bolsa de valores', 'S&P Dow Jones Indices'),
('^IXIC', 'Nasdaq Composite', 'Índice acionário', 'Estados Unidos', 'América do Norte', 'Bolsa de valores', 'Nasdaq'),
('^DJI', 'Dow Jones Industrial Average', 'Índice acionário', 'Estados Unidos', 'América do Norte', 'Bolsa de valores', 'S&P Dow Jones Indices'),
('^NYA', 'NYSE Composite', 'Índice acionário', 'Estados Unidos', 'América do Norte', 'Bolsa de valores', 'NYSE'),
('^FTSE', 'FTSE 100', 'Índice acionário', 'Reino Unido', 'Europa', 'Bolsa de valores', 'London Stock Exchange'),
('^N100', 'Euronext 100', 'Índice acionário', 'Europa', 'Europa', 'Bolsa de valores', 'Euronext'),
('^N225', 'Nikkei 225', 'Índice acionário', 'Japão', 'Ásia', 'Bolsa de valores', 'Tokyo Stock Exchange'),
('000001.SS', 'SSE Composite', 'Índice acionário', 'China', 'Ásia', 'Bolsa de valores', 'Shanghai Stock Exchange'),
('^NSEI', 'Nifty 50', 'Índice acionário', 'Índia', 'Ásia', 'Bolsa de valores', 'National Stock Exchange of India'),
('^BSESN', 'BSE Sensex', 'Índice acionário', 'Índia', 'Ásia', 'Bolsa de valores', 'Bombay Stock Exchange'),
('GC=F', 'Gold Futures', 'Commodity / futuro', 'Ouro', 'Global', 'Mercado futuro', 'CME / COMEX'),
('CL=F', 'WTI Crude Oil Futures', 'Commodity / futuro', 'Petróleo', 'Global', 'Mercado futuro', 'CME / NYMEX');
--------------------------------------------------------------------------------------------------------------------------------------------------------------


-- TABELA DATA

DECLARE @DATA_INICIAL AS DATE = '2020-01-01', @TOTAL_DIAS AS INT = 1500, @I AS INT = 0;

SET LANGUAGE Portuguese;

IF OBJECT_ID('M3.dCalendario', 'U') IS NOT NULL
    DROP TABLE m3.dCalendario;

CREATE TABLE M3.DCALENDARIO (
    DATA          DATE         NOT NULL PRIMARY KEY,
    ANO           INT          NOT NULL,
    MES           INT          NOT NULL,
    DIA           INT          NOT NULL,
    MES_ABREVIADO VARCHAR (3)  NOT NULL,
    MES_EXTENSO   VARCHAR (20) NOT NULL,
    DIA_ABREVIADO VARCHAR (3)  NOT NULL,
    DIA_EXTENSO   VARCHAR (20) NOT NULL,
    TRIMESTRE     INT          NOT NULL,
    SEMANA        INT          NOT NULL
);

WHILE @I < @TOTAL_DIAS
    BEGIN
        DECLARE @DT AS DATE = DATEADD(DAY, @I, @DATA_INICIAL);
        INSERT INTO M3.DCALENDARIO
        SELECT @DT,
               DATEPART(YEAR, @dt),
               DATEPART(MONTH, @dt),
               DATEPART(DAY, @dt),
               LEFT(DATENAME(MONTH,@DT),3),
               DATENAME(MONTH, @dt),
               LEFT(DATENAME(WEEKDAY,@DT),3),
               DATENAME(WEEKDAY, @dt),
               DATEPART(QUARTER, @dt),
               DATEPART(ISO_WEEK, @DT);
        SET @I += 1;
    END

SELECT   *
FROM     M3.DCALENDARIO
ORDER BY DATA;
--------------------------------------------------------------------------------------------------------------------------------------------------------------



-- TABELA EVENTOS HISTÓRICOS

CREATE TABLE M3.D_EVENTOS_HISTORICOS (
    ID_EVENTO        INT           IDENTITY (1, 1) NOT NULL,
    DATA             DATE          NOT NULL,
    EVENTO           VARCHAR (150) NOT NULL,
    CATEGORIA_EVENTO VARCHAR (50)  NOT NULL,
    REGIAO_AFETADA   VARCHAR (50)  NOT NULL,
    MERCADO_AFETADO  VARCHAR (50)  NULL,
    DESCRICAO        VARCHAR (500) NULL,
    CONSTRAINT PK_D_EVENTOS_HISTORICOS PRIMARY KEY (ID_EVENTO)
); 


-- DADOS EVENTOS HISTORICOS

INSERT  INTO M3.D_EVENTOS_HISTORICOS (DATA, EVENTO, CATEGORIA_EVENTO, REGIAO_AFETADA, MERCADO_AFETADO, DESCRICAO)
VALUES                              ('2020-03-11', 'OMS caracteriza a COVID-19 como pandemia', 'Saúde / Macroeconomia', 'Global', 'Índices globais', 'Evento associado ao aumento da aversão ao risco e forte volatilidade nos mercados globais.'),
('2020-04-20', 'Petróleo WTI negocia abaixo de zero', 'Commodities', 'Global', 'Petróleo', 'Evento extremo no mercado futuro de petróleo, relacionado ao choque de demanda e limitações de armazenamento.'),
('2022-02-24', 'Início da invasão em larga escala da Ucrânia pela Rússia', 'Geopolítica', 'Europa / Global', 'Índices globais e commodities', 'Evento associado ao aumento da incerteza geopolítica, pressão em energia e commodities.'),
('2022-03-16', 'Fed inicia alta da taxa de juros em 2022', 'Política monetária', 'Estados Unidos / Global', 'Índices globais', 'Evento associado ao aperto monetário global e pressão sobre ativos de risco.');
--------------------------------------------------------------------------------------------------------------------------------------------------------------