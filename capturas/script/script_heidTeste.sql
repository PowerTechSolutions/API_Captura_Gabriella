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

SELECT * FROM analise_desempenho JOIN processos ON fkprocesso=id_proc