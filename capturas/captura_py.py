import psutil
import mysql.connector

#conexao ao banco
conexao = mysql.connector.connect(
    host='localhost',
    user='Power',
    password='urubu100',
    database='powertechsolutions'
)
cursor = conexao.cursor()

# lista de processos do psutil
lista_processos = psutil.process_iter()

#contador
contador_processos = 0

# Iterar sobre os processos e inserir no banco de dados
for process in process_list:
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
