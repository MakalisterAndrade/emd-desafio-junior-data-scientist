import streamlit as st
from controller.graph_A.data_loader_graph_A import load_data_graph_A 
import plotly.express as px
import calendar

# Mapeamento de números para nomes de meses em português
meses_nome = {
        1: 'Janeiro', 2: 'Fevereiro', 3: 'Março', 4: 'Abril',
        5: 'Maio', 6: 'Junho', 7: 'Julho', 8: 'Agosto',
        9: 'Setembro', 10: 'Outubro', 11: 'Novembro', 12: 'Dezembro'
    }

def create_yearly_chart(data):
    fig_ano = px.bar(data.groupby('ano').size().reset_index(name='quantidade'),
                     x='ano', y='quantidade', title='Quantidade de Chamados por Ano',
                     text='quantidade', color='quantidade',
                     color_continuous_scale=px.colors.sequential.Agsunset)
    fig_ano.update_traces(texttemplate='%{text}', textposition='outside')
    fig_ano.update_layout(showlegend=False)
    fig_ano.update_xaxes(tickangle=45, title_text='Ano')
    st.plotly_chart(fig_ano)

def create_monthly_chart(data):

    anos_disponiveis = sorted(data['ano'].unique())
    ano_selecionado = st.selectbox('Selecione o Ano', anos_disponiveis)
    
    # Filtrando os dados pelo ano selecionado
    data_filtrada = data[data['ano'] == ano_selecionado]
    
    # Agrupando os dados por mês e contando os chamados
    chamados_por_mes = data_filtrada.groupby('mes').size().reset_index(name='quantidade')
    
    # Mapeando o número do mês para o nome do mês para melhor legibilidade
    # Mantendo a coluna original de 'mes' para a ordenação
    chamados_por_mes['nome_mes'] = chamados_por_mes['mes'].map(meses_nome)
    
    # Criando o gráfico com uma paleta de cores customizada
    fig_mes = px.bar(chamados_por_mes,
                     x='nome_mes', y='quantidade', title=f'Quantidade de Chamados por Mês em {ano_selecionado}',
                     text='quantidade',  # Mostra o valor em cima de cada barra
                     color='quantidade',  # Usa a quantidade como base para a cor
                     color_continuous_scale=px.colors.sequential.Agsunset)  # Paleta de cores mais suave
    
    # Configurando o eixo x para mostrar o nome dos meses em português
    fig_mes.update_xaxes(tickangle=45, title_text='Mês')
    
    # Melhorando a visualização das dicas de ferramenta e ajustando a legenda
    fig_mes.update_traces(texttemplate='%{text}', textposition='outside')
    fig_mes.update_layout(uniformtext_minsize=8, uniformtext_mode='hide', showlegend=False)
    
    st.plotly_chart(fig_mes)

def identify_outliers_general(data):
    chamados_por_mes = data.groupby('mes')['id_chamado'].count().reset_index(name='quantidade')
    media = chamados_por_mes['quantidade'].mean()
    desvio_padrao = chamados_por_mes['quantidade'].std()
    limite_outlier = media + 1.5 * desvio_padrao
    outliers = chamados_por_mes[chamados_por_mes['quantidade'] > limite_outlier]

    if not outliers.empty:
        # Mapeando o número do mês para o nome do mês
        outliers['mes_nome'] = outliers['mes'].map(meses_nome)

        # Criando o gráfico de outliers
        fig_outliers = px.bar(outliers, x='mes_nome', y='quantidade',
                              title='Outliers de Chamados por Mês',
                              text='quantidade', color='quantidade',
                              color_continuous_scale=px.colors.sequential.Agsunset)
        
        fig_outliers.update_traces(texttemplate='%{text}', textposition='outside')
        fig_outliers.update_layout(showlegend=False)
        fig_outliers.update_xaxes(tickangle=45, title_text='Mês')
        st.plotly_chart(fig_outliers)

        # Gerando a lista de meses outliers para exibir na mensagem
        meses_outliers = ", ".join(outliers['mes_nome'].tolist())
        st.write(f'Ao longo de todos os anos inclusos no dataset, os meses de {meses_outliers} tiveram uma quantidade de chamados significativamente maior do que a média mensal, ajustada pelo critério de mais de 1.5 desvio padrão acima da média.')
    else:
        st.write('Não foram identificados meses outliers.')


def display_graphs_A():
    data = load_data_graph_A()

    # Chamando as funções para criar gráficos
    create_yearly_chart(data)
    create_monthly_chart(data)
    identify_outliers_general(data)

if __name__ == '__main__':
    st.title('Análise de Chamados')
    display_graphs_A()
