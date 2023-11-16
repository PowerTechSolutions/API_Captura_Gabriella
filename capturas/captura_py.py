import psutil
import mysql.connector

#Estabelece uma conexao com o banco de dados
conexao = mysql.connector.connect(
host='localhost',
user='aluno',
password='sptech',
database='powertechsolutions'
)
    
# Criar um cursor, que será utilzado para realizar os comandos mysql 
cursor = conexao.cursor()

# Lista de processos do psutil
lista_processos = psutil.process_iter()

# Contador para delimitar o número de capturas
contador_processos = 300

# Iterar sobre os processos e inserir no banco de dados
for process in lista_processos:
        process_info = process.as_dict(attrs=['name', 'cpu_times'])
        nome = process_info['name']
        cpu_user = process_info['cpu_times'].user

        if cpu_user > 0:
            cursor.execute('''
            INSERT INTO processos (nome, tempo_user)
            VALUES (%s, %s)
            ''', (nome, cpu_user))

        if process == contador_processos:
            break

#Commit das alterações e fechar a conexão com o banco de dados
conexao.commit()
cursor.close()
conexao.close()
