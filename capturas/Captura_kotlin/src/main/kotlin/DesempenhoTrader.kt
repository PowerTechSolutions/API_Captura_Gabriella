fun main() {
    val repositorio= Repositorio()
    val funcionalidade= Funcionalidade()

    val conexao= Conexao()

    repositorio.iniciar()
    conexao.conectar()
    repositorio.pegarId()
    funcionalidade.listarJanelas()

}