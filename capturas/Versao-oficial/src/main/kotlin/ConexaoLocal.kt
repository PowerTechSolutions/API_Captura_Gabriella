import org.apache.commons.dbcp2.BasicDataSource
import org.springframework.jdbc.core.JdbcTemplate

open class ConexaoLocal {
        open fun iniciar(): JdbcTemplate {
            val dataSource = BasicDataSource()
            dataSource.driverClassName = "com.mysql.cj.jdbc.Driver"
            dataSource.url = "jdbc:mysql://localhost:3306/PowerTechSolutions"
            dataSource.username = "root"
            dataSource.password = "1234"
            return JdbcTemplate(dataSource)
        }

}