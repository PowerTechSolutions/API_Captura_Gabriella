import mysql.connector
import psutil
import time
from datetime import datetime

try:
    # Estabelece uma conexão com o banco de dados
    conexao = mysql.connector.connect(
        host='localhost',
        user='Power',
        password='urubu100',
        database='PowerTechSolutions'
    )
            
    # Criar um cursor, que será utilizado para realizar os comandos MySQL 
    cursor = conexao.cursor()

    # Lista de processos do psutil
    lista_processos = psutil.process_iter()

    # Contador para de inserts
    contador_inserts = 0

    # Contador para delimitar o número de capturas
    contador_processos = 50

    print("Iniciando capturas")

    # Iterar sobre os processos e inserir no banco de dados
    for process in lista_processos:
        process_info = process.as_dict(attrs=['name', 'cpu_times'])
        nome = process_info['name']
        cpu_user = process_info['cpu_times'].user
        data_hora_captura = datetime.now()

        if cpu_user > 0:
            cursor.execute('''
                INSERT INTO processos (nome, tempo_user, dthora_captura)
                VALUES (%s, %s, %s)
            ''', (nome, cpu_user, data_hora_captura))
            contador_inserts += 1

        if contador_inserts == contador_processos:
            print("...")
            print("Capturas realizadas com sucesso!")
            break

finally:
    # Commit das alterações e fechar a conexão com o banco de dados
    conexao.commit()
    cursor.close()
    conexao.close()
