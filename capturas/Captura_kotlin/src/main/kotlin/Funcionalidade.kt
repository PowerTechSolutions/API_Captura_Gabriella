import com.github.britooo.looca.api.core.Looca

class Funcionalidade {

    fun listarJanelas(): MutableList<String>{
        val looca= Looca()
        val janelas= looca.grupoDeJanelas.janelasVisiveis

        val listaFiltro= mutableListOf<String>()

        janelas.forEach(){
            val titulos= it.titulo
            listaFiltro.add(titulos)
//            println(listaFiltro)
        }

        return listaFiltro


    }
}