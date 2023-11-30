import org.springframework.jdbc.core.JdbcTemplate
import org.apache.commons.dbcp2.BasicDataSource

open class Conexao {
    open fun iniciar(): JdbcTemplate {
        val dataSource = BasicDataSource()
        dataSource.driverClassName = "com.mysql.cj.jdbc.Driver"
        dataSource.url = "jdbc:mysql://localhost:3306/PowerTechSolutions?serverTimezone=UTC&useSSL=false"
        dataSource.username = "aluno"
        dataSource.password = "sptech"
        return JdbcTemplate(dataSource)
    }
}
