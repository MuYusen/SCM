FROM scratch
ADD ubuntu-base-19.10-base-amd64.tar.gz /
CMD ["/bin/bash"]

# docker build . -t ubuntu-docker:17.04
# docker run -it --name test ubuntu-docker:17.04