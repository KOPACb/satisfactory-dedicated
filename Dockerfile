FROM steamcmd/steamcmd:ubuntu
#FROM cm2network/steamcmd:root

RUN adduser --disabled-password --gecos "" --home /srv/satisfactory --uid 1000 satisfactory

RUN mkdir /srv/satisfactory/save \
    && ln -s /srv/satisfactory/save /srv/satisfactory/.config/Epic/FactoryGame/Saved/SaveGames/ \
    && chown satisfactory:satisfactory /srv/satisfactory/.config/Epic/FactoryGame/Saved/SaveGames/

USER satisfactory

ENV HOME="/srv/satisfactory/"

WORKDIR /srv/satisfactory/

RUN steamcmd +force_install_dir /srv/satisfactory/bin/ +login anonymous +app_update 1690800 -beta public validate +quit

ADD entrypoint.sh /

WORKDIR /srv/satisfactory/

EXPOSE 7777/udp 15000/udp 15777/udp

RUN mkdir -p /srv/satisfactory/.steam/sdk64/ && ln -s /srv/satisfactory/bin/linux64/steamclient.so /srv/satisfactory/.steam/sdk64/

ENTRYPOINT ["/entrypoint.sh"]
