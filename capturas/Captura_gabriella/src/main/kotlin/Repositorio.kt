// Repositorio.kt
import org.springframework.jdbc.core.BeanPropertyRowMapper
import org.springframework.jdbc.core.JdbcTemplate

class Repositorio : Conexao() {
    private lateinit var jdbcTemplate: JdbcTemplate

    fun iniciarJdbc() {
        jdbcTemplate = super.iniciar()
    }

    fun validarCpf(cpfConsulta: Long): Boolean {
        val usuario = jdbcTemplate.queryForObject(
            "SELECT * FROM Usuario_Dashboard WHERE Cpf = $cpfConsulta",
            BeanPropertyRowMapper(Usuario::class.java)
        )

        return usuario != null
    }

    fun pegarId(cpfConsulta: Long): Int {
        val select = jdbcTemplate.queryForObject(
            """SELECT IDUsuario FROM Usuario_Dashboard WHERE Cpf= $cpfConsulta""",
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
            resposta += "\n\r\n\rNumeração: ${maquina.IDMaquina} | Apelido: ${maquina.Apelido}"

            maquina.FKFuncionario = fkFunc
        }

        return resposta
    }
}
