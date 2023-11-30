import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.core.queryForObject

class Repositorio_Capturas :Conexao() {
    private lateinit var jdbcTemplate: JdbcTemplate

    fun iniciarJdbc() {
        jdbcTemplate = super.iniciar()
    }
    fun enviarDesempenho(fkMaquina: Int): String{
        val select1 = jdbcTemplate.queryForList(
            """
            SELECT ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos
            FROM processos
            WHERE fkmaquina_processo = $fkMaquina
            GROUP BY nome
            HAVING ROUND(SUM(tempo_user) / 60, 2) > 1.0;
            """, MutableList::class.java)

        val select2 = jdbcTemplate.queryForList(
            """
            SELECT id_proc
            FROM processos
            WHERE fkmaquina_processo = $fkMaquina
            GROUP BY nome
            HAVING ROUND(SUM(tempo_user) / 60, 2) > 1.0;
            """, MutableList::class.java)

        val maximo_lista= jdbcTemplate.queryForObject("""
            SELECT count(nome) from processos where fkmaquina_processo = $fkMaquina;
        """, Int:: class.java)

        for (i in maximo_lista){
            jdbcTemplate.update(
                """
              INSERT INTO analise_desempenho (minutos_usados,fkprocesso) VALUES
              ()
              
          """.trimMargin()
            )
        }




        return "Captura de desempenho realizada com sucesso!"
    }


}

