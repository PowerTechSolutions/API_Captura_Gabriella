import java.io.File

class CapturaProcLocal {
        fun capturarPy(fkMaquina: Int) {
            val codigoPy = """
import psutil
import mysql.connector
import time
from datetime import datetime
from datetime import time
#import pymssql

try:
        #Estabelece uma conexao com o banco de dados
        conexao = mysql.connector.connect(
        host='localhost',
        user='root',
        password='1234',
        database='PowerTechSolutions'
        )
        
        # Criar um cursor, que será utilzado para realizar os comandos mysql 
        cursor = conexao.cursor()

        # Lista de processos do psutil
        lista_processos = psutil.process_iter()

        print("Iniciando capturas")

        # Iterar sobre os processos e inserir no banco de dados
        for process in lista_processos:
                process_info = process.as_dict(attrs=['name'])
                nome = process_info['name']
                data_hora_captura = datetime.now()
                ram= round(psutil.virtual_memory().percent, 2)

                if ram > 1.0:
                    cursor.execute('''
                    INSERT INTO Processos (nomeProcesso, uso_ram, data_hora, fkMaquina
                    )
                    VALUES (%s, %s, %s, %s)
                    ''', (nome, ram, data_hora_captura, $fkMaquina))
                    

finally:
        #Commit das alterações e fechar a conexão com o banco de dados
        conexao.commit()
        cursor.close()
        conexao.close()

print("...")
print("Capturas realizadas com sucesso!")
                          """

            val nomeArquivoPyDefault = "CodigoPythonProc.py"

            File(nomeArquivoPyDefault).writeText(codigoPy)
            Runtime.getRuntime().exec("python $nomeArquivoPyDefault")

            println("Processos Cadastrados com Sucesso")

        }
    }
