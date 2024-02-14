# Documentação do Projeto EMD Desafio

Repositório de resolução ao desafio técnico do Escritório Municipal de Dados do Rio de Janeiro para a vaga de Cientista de Dados JR.

Os arquivos de resposta estão dentro de `app/respostas sql e python` -> [clique aqui](https://github.com/MakalisterAndrade/emd-desafio-junior-data-scientist/tree/resolucao/app/respostas%20sql%20e%20python).

Este projeto utiliza um ambiente Docker para rodar uma aplicação Streamlit, com várias bibliotecas Python para análise de dados como `numpy`, `matplotlib`, `scipy`, `basedosdados`, `jupyter`, `altair`, `pandas` e `streamlit`.

## Pré-requisitos

Antes de começar, você precisa ter o Docker e o Docker Compose instalados em seu sistema. Para instruções de instalação, visite:

- [Instalar Docker](https://docs.docker.com/get-docker/)
- [Instalar Docker Compose](https://docs.docker.com/compose/install/)

## Clonagem do Repositório

Para obter o projeto, clone o repositório Git utilizando o seguinte comando no terminal:

```bash
git clone https://github.com/MakalisterAndrade/emd-desafio-junior-data-scientist/tree/resolucao emd-desafio-makalister
```
```bash
cd emd-desafio-makalister
```

## Configuração do Ambiente Docker

O arquivo `Dockerfile` contém todas as instruções necessárias para construir a imagem Docker da aplicação, incluindo a instalação de dependências.

O arquivo `docker-compose.yml` define o serviço `emddesafio`, configurando volumes, portas e o comando de execução.

## Construção da Imagem Docker

Para construir a imagem Docker com base no Dockerfile, execute o seguinte comando no diretório raiz do projeto:

```bash
docker compose build
```

## Executando o Contêiner

Após a construção da imagem, você pode iniciar o contêiner usando o Docker Compose:

```bash
docker compose up -d
```
## Acesso à Aplicação

Após iniciar o contêiner, a aplicação Streamlit estará acessível através do navegador no seguinte endereço:

```bash
http://localhost:8500
```
Já a aplicação jupyter pode ser acessada no endereço:

```bash
http://localhost:8888
```
Acesse o arquivo `analise_python.ipynb` dentro `respostas sql e python`.

