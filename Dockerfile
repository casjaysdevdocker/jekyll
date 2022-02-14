FROM ruby:2.7 as build

RUN apt-get update && \
      apt-get install -yy ruby ruby-devel && \
      gem install \
      github-pages \
      jekyll-assets \
      jekyll-include-cache \
      activesupport \
      rake \
      mini_portile2 \
      minitest \
      racc \
      zeitwerk \
      rexml \
      ffi \
      sprockets \
      listen \
      jekyll \
      casjaysdev-jekyll-theme

COPY ./bin/. /usr/local/bin/

FROM build as jekyll
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')" 

LABEL \
      org.label-schema.name="jekyll" \
      org.label-schema.description="jekyll container based on Alpine Linux" \
      org.label-schema.url="https://github.com/casjaysdev/jekyll" \
      org.label-schema.vcs-url="https://github.com/casjaysdev/jekyll" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$ARIANG_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license="MIT" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.schema-version="latest" \
      org.label-schema.vendor="CasjaysDev" \
      maintainer="CasjaysDev <docker-admin@casjaysdev.com>" 

EXPOSE 4000
WORKDIR /data/htdocs
VOLUME ["/data","/config"]
HEALTHCHECK CMD ["/usr/local/bin/entrypoint-jekyll.sh", "healthcheck"]
ENTRYPOINT [ "/usr/local/bin/entrypoint-jekyll.sh" ]
