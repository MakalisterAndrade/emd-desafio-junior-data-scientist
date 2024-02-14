import streamlit as st
from google.cloud import bigquery

client = bigquery.Client()

# Consulta SQL para contar os chamados no dia 01/04/2023
query = """
SELECT COUNT(*) as total_chamados
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE DATE(data_inicio) = '2023-04-01'
"""

# Executando a consulta
result = client.query(query)
total_chamados = list(result)[0]["total_chamados"]

# Usando Streamlit para exibir o resultado
st.title('Análise de Chamados do 1746')
st.write(f"Total de chamados abertos no dia 01/04/2023: {total_chamados}")
