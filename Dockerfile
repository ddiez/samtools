FROM debian:testing
MAINTAINER Diego Diez <diego10ruiz@gmail.com>

## Install samtools.
RUN apt-get update && \
    apt-get install -y curl gcc make bzip2 autoconf && \
    apt-get install -y zlib1g zlib1g-dev libncurses5 libncurses5-dev  && \
    apt-get install -y libbz2-1.0 libbz2-dev liblzma5 liblzma-dev && \
    apt-get install -y libcurl3 libcurl4-openssl-dev openssl libssl-dev && \
    curl -L https://github.com/samtools/samtools/releases/download/1.4/samtools-1.4.tar.bz2 > /tmp/samtools-1.4.tar.bz2 && \
    cd /tmp && tar xfjv samtools-1.4.tar.bz2 && rm samtools-1.4.tar.bz2 && \
    cd samtools-1.4 && ./configure && make && make prefix=/opt install && \
    cd /tmp && rm -rf samtools-1.4 && \
    apt-get clean -y && \
    apt-get purge -y curl gcc make bzip2 autoconf zlib1g-dev libncurses5-dev libbz2-dev liblzma-dev libcurl4-openssl-dev libssl-dev && \
    apt-get autoremove -y

ENV PATH /opt/bin:$PATH

RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev

CMD ["/bin/bash"]
