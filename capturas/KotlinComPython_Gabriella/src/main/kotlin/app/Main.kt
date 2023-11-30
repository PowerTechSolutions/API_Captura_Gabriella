package app

import CapturaProc
import Maquinas
import Repositorio
import Usuario
import java.util.*

open class Main {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            val repositorio = Repositorio()
            val usuario = Usuario()
            val maquina = Maquinas()
            val capturaProc= CapturaProc()

            println("Bem-vindo a PowerTech. Por favor, faca o login para usar nosso sistema.\r\n")
            println("Insira sua senha:")

            val senhaInserida = Scanner(System.`in`)
            val senha = senhaInserida.next().toString()

            repositorio.iniciarJdbc()

            usuario.Senha = senha

            if (repositorio.validarCpf(usuario.Senha)) {
                usuario.IDUsuario = repositorio.pegarId(usuario.Senha)
                val maquinas = repositorio.resgatarMaquinas(usuario.IDUsuario)
                println("Qual a numeracao da maquina em que esta instalando o servico? $maquinas\"\r\n")

                val maquinaEscolhida = Scanner(System.`in`)
                maquina.IDMaquina = maquinaEscolhida.nextInt()
                capturaProc.capturarPy(maquina.IDMaquina)


            }

        }
    }
}
