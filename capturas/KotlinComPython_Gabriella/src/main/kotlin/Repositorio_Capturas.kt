import com.github.britooo.looca.api.core.Looca
import org.springframework.jdbc.core.JdbcTemplate

class Repositorio_Capturas : Conexao() {
    private lateinit var jdbcTemplate: JdbcTemplate
//    val looca= Looca()
//    var totalProcessos = looca.grupoDeProcessos.totalProcessos

    fun iniciarJdbc() {
        jdbcTemplate = super.iniciar()
    }

    fun getTempo(fkMaquina: Int) :MutableList<String>?{
        val tempo=jdbcTemplate.queryForObject(
            """
            SELECT ROUND(SUM(tempo_user) / 60, 2) AS tempo_em_minutos
            FROM processos
            WHERE fkmaquina_processo = $fkMaquina
            GROUP BY nome
            HAVING ROUND(SUM(tempo_user) / 60, 2) > 1.0;
        """, mutableListOf<String>()::class.java
        )

        return tempo
    }

    fun getId(fkMaquina: Int) :MutableList<Int>?{
       val id= jdbcTemplate.queryForObject(
            """
            SELECT id_proc
            FROM processos
            WHERE fkmaquina_processo = $fkMaquina
            GROUP BY nome
            HAVING ROUND(SUM(tempo_user) / 60, 2) > 1.0;
        """, mutableListOf<Int>()::class.java
        )
        return id
    }
    fun enviarDesempenho(idprocesso: MutableList<Int>?, tempoMin: MutableList<String>?, totalProc: Int): String {

        for(i in 0..totalProc){
            jdbcTemplate.update("""
            INSERT INTO analise_desempenho (minutos_usados, fkprocesso) VALUES
            ($idprocesso, $tempoMin)
        """.trimIndent())
        }


        return "Captura de desempenho realizada com sucesso!"
    }
}
