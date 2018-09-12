#FROM library/golang
FROM grayzone/beego

# Godep for vendoring
RUN go get github.com/tools/godep


# Recompile the standard library without CGO
RUN CGO_ENABLED=0 go install -a std


RUN useradd --create-home --no-log-init --shell /bin/bash AssetExpress
RUN adduser AssetExpress sudoRUN echo 'AssetExpress:123456' | chpasswd
#USER AssetExpress
WORKDIR /home/AssetExpress

#ENV APP_DIR $GOPATH
ENV APP_DIR /home/AssetExpress
ENV GOPATH /home/AssetExpress
#RUN mkdir -p $APP_DIR



# Set the entrypoint
ENTRYPOINT (cd $APP_DIR && ./run_by_bee.sh)
ADD . $APP_DIR

# Compile the binary and statically link
#RUN cd $APP_DIR && CGO_ENABLED=0 godep go build -ldflags '-d -w -s'
RUN cd $APP_DIR && CGO_ENABLED=0 go build AssetExpress

EXPOSE 8089
