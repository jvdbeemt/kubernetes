FROM golang:1.13.4 as build

WORKDIR /app
COPY src/healthcheck.go ./

RUN CGO_ENABLED=0 go build -a healthcheck.go

FROM nginx:alpine
ARG version
ENV version ${version}
ARG demo_app
ENV demo_app ${demo_app}

COPY --from=build /app/healthcheck /usr/local/bin/healthcheck

HEALTHCHECK CMD /usr/local/bin/healthcheck -url http://localhost:80
RUN echo "<html><title>${demo_app}</title><body>Demo app: ${demo_app} - Running version ${version}</body></html>" > /usr/share/nginx/html/index.html
