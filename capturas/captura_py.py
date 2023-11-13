import psutil
import mysql.connector
from mysql.connector import connect 

#conexao ao banco
conexao = connect(
    host='localhost',
    user='aluno',
    password='sptech',
    database='powertechsolutions'
)
cursor = conexao.cursor()

# lista de processos do psutil
lista_processos = psutil.process_iter()

#contador
contador_processos = 0

#connection = mysql_connection('localhost', 'aluno', 'sptech', 'powertechsolutions')

# Iterar sobre os processos e inserir no banco de dados
for process in lista_processos:
    #try:
    process_info = process.as_dict(attrs=['name', 'cpu_times'])
    nome = process_info['name']
    cpu_user = process_info['cpu_times'].user

    if cpu_user <= 0:
            print("foi detectado um erro na captura")
    else:
        cursor.execute('''
            INSERT INTO processos (nome, tempo_user)
            VALUES (%s, %s)
            ''', (nome, cpu_user))

        contador_processos += 1

        # Parar a captura após 300 processos
    if contador_processos >= 300:
        break

    #except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
        # Lidar com exceções caso o processo não exista ou não seja acessível
        #pass

# Commit das alterações e fechar a conexão com o banco de dados
conexao.commit()
conexao.close()
