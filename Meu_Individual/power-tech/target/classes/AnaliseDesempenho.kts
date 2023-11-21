class AnaliseDesempenho :CapturaJanelas(){
    lateinit var jdbcTemplate: JdbcTemplate

    fun iniciar(){
        jdbcTemplate = Conexao.jdbcTemplate!!
    }

    fun resgatarNomeP(FKMaquina: Int): String{
        val nomeProc= jdbcTemplate.query("""
            SELECT nome FROM processos where fkmaquina_processo= $FKMaquina
        """.trimIndent())

        return nomeProc
    }
    fun resgatarTempoP(FKMaquina: Int, nomeProcesso: String): String{
        val nomeProc= resgatarNomeP(FKMaquina)
        val tempoProcEmMin= jdbcTemplate.query("""
            SELECT ROUND(SUM(tempo_user/60),2) AS tempo_em_minutos FROM processos WHERE nome= $nomeProc
        """.trimIndent())
    }

    fun resgatarNomeJ(FKMaquina: Int): String{
        val nomeJan= jdbcTemplate.query("""
            SELECT Nome_Janela FROM Janelas where FKMaquina_Janelas= $FKMaquina
        """.trimIndent())

        return nomeJan
    }

    fun compararNomes(nomeJanela: String, nomeProcesso: String, TempoProcesso: String):String{
        val nomeJanela= resgatarNomeJ(FKMaquina).toString()
        val nomeProcesso= resgatarNomeP(FKMaquina)
        val tempoProcesso= resgatarTempoP(FKMaquina)

        nomeJanela.forEach {
            when()
        }

        return
    }

//    fun insertDesempenho(){
//
//    }


}