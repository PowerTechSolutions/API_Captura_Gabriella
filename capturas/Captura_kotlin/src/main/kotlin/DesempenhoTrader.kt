fun main() {
    val repositorio= Repositorio()
    val funcionalidade= Funcionalidade()

    val conexao= Conexao()

    conexao.conectar()
    repositorio.iniciar()
//    repositorio.inserirKt(funcionalidade)
    repositorio.pegarId()
    funcionalidade.listarJanelas()


}