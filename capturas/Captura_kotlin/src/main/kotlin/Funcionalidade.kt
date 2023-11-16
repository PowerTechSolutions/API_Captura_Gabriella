import com.github.britooo.looca.api.core.Looca

class Funcionalidade {

    fun listarJanelas() {
        val looca = Looca()
        val janelas = looca.grupoDeJanelas.janelasVisiveis

        val listaFiltro= mutableListOf<String>()

        janelas.forEach() {
            val titulos = it.titulo
            println(titulos)
        }


    }
}