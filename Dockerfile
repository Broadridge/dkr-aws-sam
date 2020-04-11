FROM python:3.8-alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="bfscloud/aws-sam" \
      org.opencontainers.image.version=$VCS_REF \
      org.opencontainers.image.description="Infrastructure as Code with AWS SAM Framework" \
      org.opencontainers.image.authors="Broadridge - Cloud Platform Engineering <oss@broadridge.com>" \
      org.opencontainers.image.url="https://hub.docker.com/r/bfscloud/aws-sam" \
      org.opencontainers.image.source="https://github.com/broadridge/dkr-aws-sam.git" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE \
      org.label-schema.name="bfscloud/aws-sam" \
      org.label-schema.description="Infrastructure as Code with AWS SAM Framework" \
      org.label-schema.url="https://hub.docker.com/r/bfscloud/aws-sam" \
      org.label-schema.vcs-url="https://github.com/broadridge/dkr-aws-sam.git"\
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE

ENV PYTHONUNBUFFERED 1

ADD requirements.txt .
RUN apk add --no-cache bash ca-certificates docker-cli git \
    && apk add --no-cache --virtual .build-deps build-base \
    && python -m pip install --upgrade pip \
    && python -m pip install -r requirements.txt \
    && apk del .build-deps \
    && rm requirements.txt \
    && rm -rf ~/.cache/pip

ENV SAM_CLI_TELEMETRY=0

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /sam
CMD ["sam"]
