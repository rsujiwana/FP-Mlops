FROM python:3.8-alpine3.20

WORKDIR /app

RUN apk add --no-cache \
    make\
    gcc\
    linux-headers \
    musl-dev


COPY requirements.txt ./

RUN python -m pip install --no-cache-dir uwsgi==2.0.26 && \
    python -m pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 755 entrypoint.sh

EXPOSE 5000

USER nobody
ENTRYPOINT [ "./entrypoint.sh" ]