FROM alpine:3.20 AS updated-base
RUN \
  apk upgrade -U --no-cache


FROM scratch AS build-stage
COPY --from=updated-base / /
COPY --chmod=755 entrypoint.sh /usr/bin/
RUN \
  apk add --no-cache bash curl git go make protobuf-dev sudo && \
  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest && \
  git clone https://github.com/paraglider-project/paraglider && \
  cd paraglider && \
  make build install


FROM scratch
COPY --from=build-stage / /
ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]
