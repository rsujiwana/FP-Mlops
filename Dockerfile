FROM python:3.8-alpine3.20

WORKDIR /app

RUN apk add --no-cache \
    make=4.4.1-r1 \
    gcc=12.2.1_git20220924-r10 \
    linux-headers=6.3-r0 \
    musl-dev=1.2.4-r2 \
    build-base


COPY requirements.txt ./

RUN python -m pip install --no-cache-dir uwsgi==2.0.26 && \
    python -m pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 755 entrypoint.sh

EXPOSE 5000

USER nobody
ENTRYPOINT [ "./entrypoint.sh" ]