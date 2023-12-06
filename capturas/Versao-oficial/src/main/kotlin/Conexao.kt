import org.springframework.jdbc.core.JdbcTemplate
import org.apache.commons.dbcp2.BasicDataSource

open class Conexao {
    open fun iniciar(): JdbcTemplate {
        val dataSource = BasicDataSource()
        dataSource.driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
        dataSource.url = "jdbc:sqlserver://34.194.127.191;database=PowerTechSolutions;encrypt=false;trustServerCertificate=false"
        dataSource.username = "sa"
        dataSource.password = "myLOVEisthe0506"
        return JdbcTemplate(dataSource)
    }
}
