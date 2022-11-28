# # CMD instruction
# # Build image: docker build -t saiyam911/alpine-add . -f Dockerfile
# # Tagging image: docker tag saiyam911/alpine-add saiyam911/labs-add:v1.0
# # Create a container: docker run -itd saiyam911/labs-add:v1.0 /bin/sh
# # Enter into Container: docker attach f094
# # Verify the link: / # ls -ltr
# FROM alpine:3.5
# RUN apk update
# ADD http://www.vlsitechnology.org/pharosc_8.4.tar.gz .

# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# # COPY
# # COPY [--chown=<user>:<group>] <src>... <dest>
# # COPY [--chown=<user>:<group>] ["<src>",... "<dest>"] (this form is required for paths containing whitespace)

# # echo "Welcome to Dockerlabs !" > index.html
# # docker image build -t cpy:v1 .
# # docker container run -d --rm --name myapp1 -p 8080:80 cpy:v1
# # curl localhost:8080
# # Configuration already do: COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf
# FROM nginx:alpine
# LABEL maintainer="Collabnix"
# COPY index.html /usr/share/nginx/html/
# ENTRYPOINT ["nginx", "-g", "daemon off;"]
# # -------------------------------------------------------------------------------------------------------------
# FROM alpine AS stage1
# LABEL maintainer="Collabnix"
# RUN echo "Welcome to Docker Labs!" > /opt/index.html

# FROM nginx:alpine
# LABEL maintainer="Collabnix"
# COPY --from=stage1 /opt/index.html /usr/share/nginx/html/
# ENTRYPOINT ["nginx", "-g", "daemon off;"]


# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# # CMD
# # docker build -t ajeetraina/lab3_cmd . -f Dockerfile_cmd
# # docker run ajeetraina/lab3_cmd:latest
# FROM alpine:3.6

# RUN apk update
# CMD ["top"]


# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# ENTRYPOINT

# Exec Form
# ENTRYPOINT [“executable”, “param1”, “param2”]
# Shell Form
# ENTRYPOINT command param1 param2
# FROM debian:jessie-slim

# RUN apt-get update                                   && \
#     apt-get install -y --no-install-recommends          \
#         cowsay                                          \
#         screenfetch                                   &&\
#     rm -rf /var/lib/apt/lists/*
# ENV PATH "$PATH:/usr/games"

# CMD ["Yo, CMD!!"]
# ENTRYPOINT ["cowsay", "Yo, Entrypoint!!"]


## Override the existing ENTRYPOINT
## docker container run --entrypoint "/bin/echo" entrypoint:v2 "Hello, Welocme to Docker Meetup! "

# FROM ubuntu:16.04
# ENTRYPOINT ["/bin/echo"]
# CMD ["Hello"]



# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

## docker image build -t arg:v1 .
## docker image build -t arg:v1 --build-arg WELCOME_USER=Savio .


# FROM alpine:3.9.3
# LABEL maintainer="Collabnix"

# #Setting a default value to Argument WELCOME_USER
# ARG WELCOME_USER=Collabnix
# RUN echo "Welcome $WELCOME_USER, to Docker World!" > message.txt
# CMD cat message.txt

# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# # Create a VOLUME
# # docker build -t volume:v1 .
# # docker container run --rm -d --name volume-test volume:v1
# # VOLUME name: docker container inspect -f '' volume-test
# # Path: docker container inspect -f '' volume-test
# # Create FILE: touch /var/lib/docker/volumes/ed09456a448934218f03acbdaa31f465ebbb92e0d45e8284527a2c538cc6b016/_data/mytestfile.txt
# # docker container exec -it volume-test ls myvol
# FROM nginx:alpine
# LABEL maintainer="Collabnix"
# VOLUME /myvol
# CMD [ "nginx","-g","daemon off;" ]

# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# # EXPOSE
# # docker build -t expose:v1 .
# # docker container run --rm -d --name expose-inst expose:v1
# # docker image inspect --format= expose:v1
# # docker container run --rm -P -d --name expose-inst-Publish expose:v1
# # 

# FROM nginx:alpine
# LABEL maintainer="Collabnix"

# EXPOSE 80/tcp
# EXPOSE 80/udp

# CMD [ "nginx","-g","daemon off;" ]


# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# 







