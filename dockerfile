FROM gcc:latest AS build

# create the folder /app and work inside it.
WORKDIR /app
COPY expo.c .

# compile the code into a program called expo.
RUN gcc -static -o expo expo.c -lm

FROM scratch
ARG version=1.0
LABEL version="${version}"
COPY --from=build /app/expo /expo 

# run as non-root user (65534 = "nobody")
USER 65534:65534

# when the container starts, run /expo.
# any arguments you pass to docker run like 2 10 are handed to i.

ENTRYPOINT ["/expo"] 