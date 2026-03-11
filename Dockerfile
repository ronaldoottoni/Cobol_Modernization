FROM node:20

RUN apt-get update && apt-get install -y \
    gnucobol \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY cobol ./cobol
COPY backend ./backend

# compila cobol
WORKDIR /app/cobol
RUN ls -l
RUN chmod +x build.sh 
RUN ./build.sh

ENV PATH="/app/cobol/objects:${PATH}"
ENV LD_LIBRARY_PATH="/app/cobol/objects"

# instala node
WORKDIR /app/backend
RUN npm install

EXPOSE 3000

CMD ["npm","run","dev"]

# docker build -t cobol-modern .
# docker run -p 3000:3000 --name cobol-api cobol-modern

# Entrar no container
# docker exec -it cobol-modern /bin/bash