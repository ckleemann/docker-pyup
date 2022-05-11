FROM python:3.11.0b1-alpine3.14

ARG VCS_REF
ARG VERSION
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-url="https://github.com/ckleemann/docker-pyup" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.build-date=$BUILD_DATE

RUN apk add --no-cache --virtual .build-deps gcc libffi-dev musl-dev

RUN pip install --no-cache-dir --upgrade pip setuptools

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --compile -r /tmp/requirements.txt

RUN apk del .build-deps

ENTRYPOINT ["/usr/local/bin/pyup"]
