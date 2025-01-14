import streamlit as st
from controller.graph_A.graph_A import display_graphs_A

def main():
    st.title('Dashboard EMD')

    # Aqui você pode adicionar mais opções de navegação ou filtros utilizando st.sidebar
    st.markdown('Para acessar meu currículo em PDF, [clique aqui](https://www.canva.com/design/DAF8I-_rVMk/WttRnU2PHyU76y-fGcNy5w/edit?utm_content=DAF8I-_rVMk&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton).', unsafe_allow_html=True)
    
    # Adicionando um link para o blog pessoal
    st.markdown('Para visitar meu blog pessoal, [clique aqui](https://makalister.netlify.app/).', unsafe_allow_html=True)
    
    st.markdown('Para visitar o código fonte desta aplicação, [clique aqui](https://github.com/MakalisterAndrade/emd-desafio-junior-data-scientist).', unsafe_allow_html=True)

    # Display dos gráficos
    display_graphs_A()

    # Para adicionar mais gráficos, siga o padrão:
    # from controller.graph_B.graph_B import display_graph_B
    # display_graph_B()

if __name__ == '__main__':
    main()
