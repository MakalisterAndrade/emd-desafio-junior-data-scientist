#Sistema Operacional
FROM python:3.8-slim-buster

# Define a variável de ambiente para não gerar logs de saída em buffer
ENV PYTHONUNBUFFERED 1

# Crie o diretório de trabalho dentro do contêiner
WORKDIR /app

COPY ./app/requirements.txt .

# Instale as dependências a partir do arquivo requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copie todo o conteúdo do projeto para o contêiner
COPY . /app/

# Expõe a porta que a aplicação estará escutando (ajuste conforme necessário)
EXPOSE 5000

# Comando para iniciar a aplicação (substitua main.py pelo seu arquivo principal)
CMD ["python", "main.py"]