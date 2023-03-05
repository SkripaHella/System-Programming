FROM alpine:latest
COPY test.sh .
RUN chmod +x test.sh
RUN apk update && apk add bash && apk add --no-cache bash
CMD ./test.sh
