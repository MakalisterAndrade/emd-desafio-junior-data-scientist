import streamlit as st
from controller.graph_A.graph_A import display_graphs_A

def main():
    st.title('Dashboard EMD')

    # Aqui você pode adicionar mais opções de navegação ou filtros utilizando st.sidebar
    
    # Display dos gráficos
    display_graphs_A()

    # Para adicionar mais gráficos, siga o padrão:
    # from controller.graph_B.graph_B import display_graph_B
    # display_graph_B()

if __name__ == '__main__':
    main()
