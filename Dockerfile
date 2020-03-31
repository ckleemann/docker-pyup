FROM python:alpine

ARG VCS_REF
ARG VERSION
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-url="https://github.com/ckleemann/docker-pyup" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.build-date=$BUILD_DATE
      
RUN pip install --no-cache-dir --upgrade pip setuptools

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

ENTRYPOINT ["/usr/local/bin/pyup"]
