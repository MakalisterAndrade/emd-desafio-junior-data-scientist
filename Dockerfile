#Sistema Operacional
FROM python:3.8-slim-buster

# Define a variável de ambiente para não gerar logs de saída em buffer
ENV PYTHONUNBUFFERED 1

# Crie o diretório de trabalho dentro do contêiner
WORKDIR /app

COPY ./app/requirements.txt .

# Instale as dependências a partir do arquivo requirements.txt

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/streamlit/streamlit-example.git .

RUN pip install --no-cache-dir -r requirements.txt


# Expõe a porta que a aplicação estará escutando (ajuste conforme necessário)

EXPOSE 8500

HEALTHCHECK CMD curl --fail http://localhost:8500/_stcore/health
