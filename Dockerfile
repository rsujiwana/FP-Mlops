FROM 3.9.19-slim-bookworm

WORKDIR /app

RUN apt-get update -y && \
    apt-get install --no-install-recommends build-essential -y && \
    apt-get clean -y
    

COPY requirements.txt ./

RUN python -m pip install --no-cache-dir --upgrade pip==24.0

RUN python -m pip install --no-cache-dir uwsgi==2.0.26 && \
    python -m pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 755 entrypoint.sh

EXPOSE 5000

USER nobody
ENTRYPOINT [ "./entrypoint.sh" ]