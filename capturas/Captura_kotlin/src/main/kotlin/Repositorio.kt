import org.springframework.jdbc.core.JdbcTemplate

class Repositorio {
    lateinit var jdbcTemplate: JdbcTemplate

    fun iniciar(){
        jdbcTemplate=Conexao().conectar()
    }


    fun pegarId(){
        val fkProcesso: Int?= jdbcTemplate.queryForObject("""
             SELECT id_proc FROM processos;
         """.trimIndent(), Int::class.java)

         println(fkProcesso)
     }

}