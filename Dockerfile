FROM python:3.9.19-slim-bookworm

# disable suid and guid
RUN find / -xdev -perm +6000 -type f -exec chmod a-s {} \; || true

WORKDIR /app

# install build-essential and git
RUN apt-get update -y && \
    apt-get install --no-install-recommends build-essential git -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
    

# Copy requirements.txt
COPY requirements.txt ./

# upgrade pip
RUN python -m pip install --no-cache-dir --upgrade pip==24.0

# install uwsgi and the requirement
RUN python -m pip install --no-cache-dir uwsgi==2.0.26 && \
    python -m pip install --no-cache-dir -r requirements.txt

# copy all file
COPY . .

# change permissio entrypoint.sh
RUN chmod 755 entrypoint.sh

# expose port 5000
EXPOSE 5000

# set user to nobody
USER nobody

# set entrypoint
ENTRYPOINT [ "./entrypoint.sh" ]