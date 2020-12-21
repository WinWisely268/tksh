ARG IMAGE_BASE=alpine:3.12
# Image build starts here
FROM $IMAGE_BASE
RUN mkdir -p /app/data
WORKDIR /app
ARG IMAGE_EXECUTABLE=server
ARG IMAGE_REF
ARG IMAGE_DATE
ARG IMAGE_AUTHOR
ARG IMAGE_NAME
ARG IMAGE_ORG
ARG IMAGE_FLAGS
ARG IMAGE_PORT=8080
ARG DB_PASSWORD
ENV PORT $IMAGE_PORT
ENV EXECUTABLE $IMAGE_EXECUTABLE
ENV DB_PASSWORD $DB_PASSWORD
COPY bin-all/$IMAGE_EXECUTABLE /app/$IMAGE_EXECUTABLE
EXPOSE $PORT
RUN chmod +x /app/$IMAGE_EXECUTABLE
RUN ls -alh /app
CMD ["./server"]

LABEL org.opencontainers.image.created="${IMAGE_DATE}" \
    org.opencontainers.image.title="${IMAGE_NAME}" \
    org.opencontainers.image.authors="${IMAGE_AUTHOR}" \
    org.opencontainers.image.revision="${IMAGE_REF}" \
    org.opencontainers.image.vendor="${IMAGE_ORG}"