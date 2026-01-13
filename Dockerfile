FROM quay.io/podman/stable:v5.7
LABEL authors="Kydane"
COPY podman-entrypoint.sh /
RUN chmod +x podman-entrypoint.sh
ENTRYPOINT ["/podman-entrypoint.sh"]