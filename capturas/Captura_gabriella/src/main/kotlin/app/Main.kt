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

            println("Bem-vindo à PowerTech. Por favor, faça o login para usar nosso sistema.\r\n")
            println("Insira seu CPF:")

            val cpfInserido = Scanner(System.`in`)
            val cpf = cpfInserido.next().toLong()

            // Inicializar a conexão JDBC
            repositorio.iniciarJdbc()

            usuario.Cpf = cpf

            if (repositorio.validarCpf(usuario.Cpf)) {
                usuario.IDUsuario = repositorio.pegarId(usuario.Cpf)
                val maquinas = repositorio.resgatarMaquinas(usuario.IDUsuario)
                println("Qual a numeração da máquina em que está instalando o serviço? $maquinas\"\r\n")

                val maquinaEscolhida = Scanner(System.`in`)
                maquina.IDMaquina = maquinaEscolhida.nextInt()
                capturaProc.capturarPy(maquina.IDMaquina)
            }

        }
    }
}
