package app

import CapturaProcLocal
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
            val capturaProcLocal= CapturaProcLocal()

            println("Bem-vindo a PowerTech. Por favor, faca o login para usar nosso sistema.\r\n")
            println("Insira seu email:")

            val sn = Scanner(System.`in`)
            val email = sn.next().toString()

            println("Insira sua senha:")
            val senha = sn.next().toString()

            repositorio.iniciarJdbc()

            usuario.Senha= senha
            usuario.Email = email

            if (repositorio.validar(usuario.Email,usuario.Senha)) {
                usuario.IDUsuario = repositorio.pegarId(usuario.Email,usuario.Senha)
                val maquinas = repositorio.resgatarMaquinas(usuario.IDUsuario)
                println("Qual a numeracao da maquina em que esta instalando o servico? $maquinas \r\n")

                val maquinaEscolhida = Scanner(System.`in`)
                maquina.IDMaquina = maquinaEscolhida.nextInt()
                capturaProcLocal.capturarPy(maquina.IDMaquina)

            }

        }
    }
}