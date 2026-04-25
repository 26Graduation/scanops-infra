FROM ghcr.io/zaproxy/zaproxy:stable

CMD ["zap.sh", "-daemon", \
     "-host", "0.0.0.0", \
     "-port", "8090", \
     "-config", "api.addrs.addr.name=.*", \
     "-config", "api.addrs.addr.regex=true", \
     "-config", "api.disablekey=true"]

EXPOSE 8090
