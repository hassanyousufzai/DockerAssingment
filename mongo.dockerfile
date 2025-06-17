FROM mongo:7

COPY init-db.js /docker-entrypoint-initdb.d/
