import org.springframework.jdbc.core.BeanPropertyRowMapper
import org.springframework.jdbc.core.JdbcTemplate

class Repositorio : ConexaoLocal() {
    private lateinit var jdbcTemplate: JdbcTemplate

    fun iniciarJdbc() {
        jdbcTemplate = super.iniciar()
    }

    fun validar(email: String,senha:String): Boolean {
        val usuario = jdbcTemplate.queryForObject(
            "SELECT * FROM Usuario_Dashboard WHERE Email = '$email' AND Senha = '$senha'",
            BeanPropertyRowMapper(Usuario::class.java)
        )

        return usuario != null
    }

    fun pegarId(email: String,senha:String): Int {
        val select = jdbcTemplate.queryForObject(
            """SELECT IDUsuario FROM Usuario_Dashboard WHERE Email = '$email' AND Senha = '$senha'""",
            Int::class.java
        )

        return select
    }

    fun resgatarMaquinas(fkFunc: Int): String {
        val maquinas = jdbcTemplate.query(
            """
            SELECT * FROM 
            Maquinas 
            WHERE FKFuncionario = $fkFunc
        """, BeanPropertyRowMapper(Maquinas::class.java)
        )

        var resposta = ""

        for (maquina in maquinas) {
            resposta += "\n\r\n\rNumeracao: ${maquina.IDMaquina} | Apelido: ${maquina.Apelido}"

            maquina.FKFuncionario = fkFunc
        }

        return resposta
    }



}