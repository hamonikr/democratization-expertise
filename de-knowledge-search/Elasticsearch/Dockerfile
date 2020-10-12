FROM docker.elastic.co/elasticsearch/elasticsearch:7.3.2

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-icu && \
  /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-nori && \
  /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-attachment 

#RUN elasticsearch-plugin install -b analysis-nori



COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/
