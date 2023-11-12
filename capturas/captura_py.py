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
process_list = psutil.process_iter()

#contador
captured_processes = 0

# Iterar sobre os processos e inserir no banco de dados
for process in process_list:
    #try:
    process_info = process.as_dict(attrs=['name', 'cpu_times'])
    nome = process_info['name']
    cpu_user = process_info['cpu_times'].user
    cpu_system = process_info['cpu_times'].system

    if cpu_user <= 0:
            print("foi detectado um erro na captura")
    else:
        cursor.execute('''
            INSERT INTO processos (nome, tempo_user, tempo_cpu)
            VALUES (%s, %s, %s)
            ''', (nome, cpu_user, cpu_system))

        captured_processes += 1

        # Parar a captura após 300 processos
    if captured_processes >= 300:
        break

    #except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
        # Lidar com exceções caso o processo não exista ou não seja acessível
        #pass

# Commit das alterações e fechar a conexão com o banco de dados
conexao.commit()
conexao.close()
