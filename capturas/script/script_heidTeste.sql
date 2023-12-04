USE powertechsolutions;

INSERT INTO analise_desempenho (minutos_usados)
SELECT ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos
FROM processos
GROUP BY nome
HAVING ROUND(SUM(tempo_user) / 60, 2) > 0.0;

/* Aqui o select do tempo*/
SELECT tempo_em_minutos
FROM (
    SELECT nome, ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos
    FROM processos
    GROUP BY nome
) AS subquery
WHERE tempo_em_minutos > 1.0;

SELECT * FROM processos;

SELECT id_proc FROM processos;

SELECT ROUND(SUM(tempo_user) / 60, 2) 
    AS tempo_em_minutos, nome, dthora_captura
    FROM processos WHERE fkmaquina_processo= 2
    GROUP BY nome ORDER BY dthora_captura DESC;

SELECT ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos, nome, 
   	MAX(dthora_captura) AS ultima_data_captura
	FROM processos 
	WHERE fkmaquina_processo = 2 
	GROUP BY nome 
	ORDER BY ultima_data_captura DESC;
	
SELECT 
    ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos, 
    nome, 
    MAX(dthora_captura) AS ultima_data_captura
FROM 
    processos 
WHERE 
    fkmaquina_processo = 2
GROUP BY 
    nome, DATE(dthora_captura)
ORDER BY 
    ultima_data_captura DESC;
    

SELECT ROUND(SUM(tempo_user) / 60, 2) FROM Processos WHERE fkmaquina_processo=2;	


SELECT IDMaquina FROM Maquinas WHERE FKFuncionario = 1 

-- TENTATIVA DE RANKEAR PARA PUXAR A LISTAGEM
SELECT 
    Subconsulta.IDUsuario,
    Subconsulta.Nome_funcionario, 
    Subconsulta.Identificacao_maquina,
    RANK() OVER (ORDER BY Subconsulta.Desempenho_mais_alto DESC) AS Posicao_desempenho
FROM (
    SELECT 
        IDUsuario,
        Usuario_Dashboard.Nome AS Nome_funcionario, 
        fkmaquina_processo AS Identificacao_maquina,
        MAX(ROUND((tempo_user/60),2)) AS Desempenho_mais_alto
    FROM Processos
    JOIN Maquinas ON fkmaquina_processo = IDMaquina 
    JOIN Usuario_Dashboard ON IDUsuario = FKFuncionario
    WHERE Processos.nome IN ('tradingscreen.exe', 'energyquant.exe', 'bloombergbash.exe', 'eikon.exe', 'powermarket.exe', 'calypso.exe')
    GROUP BY IDUsuario
) AS Subconsulta
ORDER BY Desempenho_mais_alto DESC;



SELECT 
	        IDUsuario,
	        Usuario_Dashboard.Nome AS Nome_funcionario, 
	        ROUND(SUM(tempo_user) / 60, 2) AS Tempo_desempenho_total, 
	        fkmaquina_processo AS Identificacao_maquina 
	    FROM Processos
	    JOIN Maquinas ON fkmaquina_processo = IDMaquina 
	    JOIN Usuario_Dashboard ON IDUsuario = FKFuncionario
	    GROUP BY IDUsuario;
	    
	    
	    
	    

-- Y = 100% - X
	WITH Consulta100Porcento AS (-- Tempo total de determinado usuário = 100%
	    SELECT 
	        IDUsuario,
	        Usuario_Dashboard.Nome AS Nome_funcionario, 
	        ROUND(SUM(tempo_user) / 60, 2) AS Tempo_desempenho_total, 
	        fkmaquina_processo AS Identificacao_maquina 
	    FROM Processos
	    JOIN Maquinas ON fkmaquina_processo = IDMaquina 
	    JOIN Usuario_Dashboard ON IDUsuario = FKFuncionario
	    GROUP BY IDUsuario
	),
	ConsultaX AS (-- AQUI É X = O VALOR DO TEMPO UTILIZANDO OS PROCESSOS PRINCIPAIS
	    SELECT 
	        IDUsuario,
	        Usuario_Dashboard.Nome AS Nome_funcionario, 
	        ROUND(SUM(tempo_user) / 60, 2) AS Tempo_principal_total, 
	        fkmaquina_processo AS Identificacao_maquina
	    FROM Processos
	    JOIN Maquinas ON fkmaquina_processo = IDMaquina 
	    JOIN Usuario_Dashboard ON IDUsuario = FKFuncionario
	    WHERE Processos.nome IN ('tradingscreen.exe', 'energyquant.exe', 'bloombergbash.exe', 'eikon.exe', 'powermarket.exe', 'calypso.exe')
	    GROUP BY IDUsuario
	),
	
	EQUACAO AS (
    -- REALIZA A OPERAÇÃO
    SELECT 
        Consulta100Porcento.IDUsuario,
        Consulta100Porcento.Nome_funcionario,
        Consulta100Porcento.Tempo_desempenho_total AS Total_percent,
        ConsultaX.Tempo_principal_total AS Ferramentas_percent,
        Consulta100Porcento.Tempo_desempenho_total - ConsultaX.Tempo_principal_total AS Resultado_setor
    FROM Consulta100Porcento
    JOIN ConsultaX ON ConsultaX.IDUsuario = Consulta100Porcento.IDUsuario
)
-- MOSTRA O TOTAL DE TEMPO NÃO GASTO NESSAS ATIVIDADES 
SELECT Resultado_setor FROM EQUACAO;


SELECT ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos, processos.nome AS Nome_Processo, MAX(dthora_captura) 
    AS ultima_data_captura
    FROM processos 
    JOIN Maquinas ON fkmaquina_processo = IDMaquina 
	 JOIN Usuario_Dashboard ON IDUsuario = FKFuncionario
    WHERE IDUsuario= 2
    GROUP BY processos.nome, DATE(dthora_captura)
    ORDER BY ultima_data_captura DESC;

SELECT fkmaquina_processo AS IDMaquina_capturada, nome AS Nome_processo, ROUND(SUM(tempo_user) / 60, 2) AS Tempo_desempenho_total FROM processos GROUP BY id_proc;

SELECT * FROM processos JOIN analise_desempenho WHERE fkmaquina_processo=3 ORDER BY dthora_captura DESC LIMIT 10;

 