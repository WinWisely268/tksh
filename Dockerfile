ARG IMAGE_BASE=alpine:3.12
# Image build starts here
FROM $IMAGE_BASE
RUN mkdir -p /app/db
WORKDIR /app
ARG IMAGE_EXECUTABLE=maintemplatev2-deploy
ARG IMAGE_REF
ARG IMAGE_DATE
ARG IMAGE_AUTHOR
ARG IMAGE_NAME
ARG IMAGE_ORG
ARG IMAGE_FLAGS
ARG IMAGE_PORT=8080
ENV PORT $IMAGE_PORT
ENV EXECUTABLE $IMAGE_EXECUTABLE
COPY --from=app-builder /go/src/app/bin-all/$IMAGE_EXECUTABLE /app/$IMAGE_EXECUTABLE
COPY --from=app-builder /go/src/app/bootstrap-data /app/bootstrap-data
COPY --from=app-builder /go/src/app/encrypted-config /app/encrypted-config
COPY certs /app/certs
#COPY encrypted-config /app/encrypted-config
#COPY certs  /app/certs
#COPY bin-all/$IMAGE_EXECUTABLE /app/maintemplatev2
EXPOSE $PORT
RUN chmod +x /app/maintemplatev2
RUN ls -alh /app
CMD ["./maintemplatev2","-c","/app/config"]

LABEL org.opencontainers.image.created="${IMAGE_DATE}" \
    org.opencontainers.image.title="${IMAGE_NAME}" \
    org.opencontainers.image.authors="${IMAGE_AUTHOR}" \
    org.opencontainers.image.revision="${IMAGE_REF}" \
    org.opencontainers.image.vendor="${IMAGE_ORG}"