FROM debian:buster-slim

ARG PUID=1000

ENV USER steam
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMDDIR "${HOMEDIR}/steamcmd"
ENV L4D2SERVER "${HOMEDIR}/l4d2server/left4dead2"

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32stdc++6=8.3.0-6 \
		lib32gcc1=1:8.3.0-6 \
		wget=1.20.1-1.1 \
		ca-certificates=20190110 \
		nano=3.2-3 \
		libsdl2-2.0-0:i386=2.0.9+dfsg1-1 \
		curl=7.64.0-4+deb10u1 \
		rsync \
	&& useradd -u "${PUID}" -m "${USER}" \
	&& su "${USER}" -c \
                "mkdir -p \"${STEAMCMDDIR}\" \
                && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
                && ./${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir /home/steam/l4d2server +app_update 222860 +quit \
				&& mkdir -p \"${L4D2SERVER}\" \
				&& wget -qO- 'https://github.com/ekarunian/l4d2-server-data/archive/main.tar.gz' | tar xvzf - -C \"${L4D2SERVER}\" \
				&& rsync -a \"${L4D2SERVER}/l4d2-server-data-main/addons\" \"${L4D2SERVER}/l4d2-server-data-main/cfg\" \"${L4D2SERVER}\" \
				&& rm -r \"${L4D2SERVER}/l4d2-server-data-main\" \
                && mkdir -p \"${HOMEDIR}/.steam/sdk32\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${HOMEDIR}/.steam/sdk32/steamclient.so\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
                && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\"" \
	&& ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "/usr/lib/i386-linux-gnu/steamclient.so" \
	&& ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

USER ${USER}

WORKDIR ${L4D2SERVER}

VOLUME ${L4D2SERVER}

EXPOSE 27015/tcp 27015/udp 27020/udp