import psutil
import mysql.connector
import time
from datetime import datetime
from datetime import time

teste= process_info['pid']
teste2= teste.parent()
print(teste2)

try:
        #Estabelece uma conexao com o banco de dados
        conexao = mysql.connector.connect(
        host='localhost',
        user='Power',
        password='urubu100',
        database='PowerTechSolutions'
        )
            
        # Criar um cursor, que será utilzado para realizar os comandos mysql 
        cursor = conexao.cursor()

        # Lista de processos do psutil
        lista_processos = psutil.process_iter()

        print("Iniciando capturas")

        # Iterar sobre os processos e inserir no banco de dados
        for process in lista_processos:
                process_info = process.as_dict(attrs=['name', 'cpu_times'])
                nome = process_info['name']
                cpu_user = process_info['cpu_times'].user
                data_hora_captura = datetime.now()

                if cpu_user > 0:
                    cursor.execute('''
                    INSERT INTO processos (nome, tempo_user, dthora_captura, fkmaquina_processo)
                    VALUES (%s, %s, %s, %s)
                    ''', (nome, cpu_user, data_hora_captura, 1 ))
                    

finally:
        #Commit das alterações e fechar a conexão com o banco de dados
        conexao.commit()
        cursor.close()
        conexao.close()

print("...")
print("Capturas realizadas com sucesso!")
                    

