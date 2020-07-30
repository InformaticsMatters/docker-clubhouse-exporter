FROM python:3.8.5-alpine3.12

# Labels
LABEL maintainer='Matilda Peak Limited <info@matildapeak.com>'

# Force the binary layer of the stdout and stderr streams
# to be unbuffered
ENV PYTHONUNBUFFERED 1

# Export directory
ENV EXPORT_ROOT /export
WORKDIR ${EXPORT_ROOT}

# Base directory for the application
# Also used for user directory
ENV APP_ROOT /home/exporter

# Containers should NOT run as root
# (as good practice)
RUN adduser -D -h ${APP_ROOT} -s /bin/sh exporter

# Install application and its dependencies
WORKDIR ${APP_ROOT}
COPY docker-entrypoint.sh ./
COPY exporter/*.sh ./
RUN /usr/local/bin/python -m pip install --upgrade pip && \
    pip install awscli==1.18.108 && \
    apk --no-cache add \
        curl \
        jq && \
    chmod -R 755 *.sh 2>/dev/null || true && \
    chmod -R 755 *.py 2>/dev/null || true && \
    chown exporter.exporter ${EXPORT_ROOT}

USER exporter
ENV HOME ${APP_ROOT}

CMD ["./docker-entrypoint.sh"]
