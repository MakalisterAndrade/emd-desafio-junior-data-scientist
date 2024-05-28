import pandas as pd

def load_data_graph_A():
    # Carregando os dados
    data = pd.read_csv('data/data1.csv', parse_dates=['data_inicio'])

    # Extraindo ano e mês
    data['ano'] = data['data_inicio'].dt.year
    data['mes'] = data['data_inicio'].dt.month

    return data
