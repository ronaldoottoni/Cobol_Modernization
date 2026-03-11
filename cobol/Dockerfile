# FROM debian:12
# 
# RUN apt-get update && apt-get install -y \
#     gnucobol \
#     gcc \
#     make \
#     && rm -rf /var/lib/apt/lists/*
# 
# WORKDIR /app
# 
# COPY . .
# 
# RUN chmod +x build.sh
# RUN ./build.sh
# 
# ENV LD_LIBRARY_PATH=/app/objects
# 
# CMD ["tail", "-f", "/dev/null"]

# docker build --no-cache -t cobol-runtime .
# docker run -d --name cobol-runtime cobol-runtime

# Rodar o prompt do Conteiner
# docker ps
# docker exec -it cobol-runtime /bin/bash