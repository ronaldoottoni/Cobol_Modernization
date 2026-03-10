FROM node:20

# instalar compilador COBOL
RUN apt-get update && apt-get install -y \
    gnucobol \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copiar projeto
COPY . .

# dar permissão no script
RUN chmod +x cobol/build.sh

# compilar COBOL
RUN ./cobol/build.sh

# instalar backend
WORKDIR /app/backend
RUN npm install

# instalar frontend
WORKDIR /app/frontend
RUN npm install
RUN npm run build

WORKDIR /app

EXPOSE 3000

CMD sh -c "cd backend && npm start"