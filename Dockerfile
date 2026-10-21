# Etapa 1: compila o Go (substitui o "build" do Rancher Pipeline)
FROM golang:1.23 AS build
WORKDIR /src
COPY . .
RUN [ -f go.mod ] || go mod init hello-server
RUN go mod tidy && CGO_ENABLED=0 go build -o /hello-server .

# Etapa 2: imagem final pequena
FROM alpine:3.20
EXPOSE 80
COPY --from=build /hello-server /usr/local/bin/hello-server
ENV GOKUBE v56
CMD ["hello-server"]
