FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

WORKDIR /app
COPY . /app

RUN apt-get -y update && \
    apt-get install -y curl python3 python3-pip && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

RUN pip3 install streamlit
RUN chmod 744 run_gotty.sh

EXPOSE 8080

CMD [""streamlit", "run", "app.py", "--server.port", "8080""]
