import org.springframework.jdbc.core.JdbcTemplate

class Repositorio {
    lateinit var jdbcTemplate: JdbcTemplate

    fun iniciar(){
        jdbcTemplate=Conexao().conectar()
    }

//    fun inserirKt(funcionalidade: Funcionalidade){
//        jdbcTemplate.update("""
//            insert into analise_desempenho (titulo_janela) values
//            ("${funcionalidade.listarJanelas()}")
//        """.trimIndent())
//    }

    fun pegarId(){
        val fkProcesso: Int?= jdbcTemplate.queryForObject("""
             SELECT id_proc FROM processos limit 1;
         """.trimIndent(), Int::class.java)

         println(fkProcesso)
     }

}