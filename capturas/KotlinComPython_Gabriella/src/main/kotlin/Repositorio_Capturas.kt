import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.core.queryForObject

class Repositorio_Capturas :Conexao(){
    private lateinit var jdbcTemplate: JdbcTemplate

    fun iniciarJdbc() {
        jdbcTemplate = super.iniciar()
    }

    fun enviarDesempenho(fkMaquina: Int): String{
        jdbcTemplate.update(
            """
    INSERT INTO analise_desempenho (minutos_usados, fkprocesso)
    SELECT ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos, id_proc
    FROM processos
    WHERE fkmaquina_processo = $fkMaquina
    GROUP BY nome
    HAVING ROUND(SUM(tempo_user) / 60, 2) > 1.0
    """
        )

        return "Captura de desempenho realizada com sucesso!"
    }
}