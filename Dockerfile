# Copyright 2018 Cyface GmbH
# 
# This file is part of the Cyface GeoServer Docker Setup.
# 
# The Cyface GeoServer Docker Setup is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#  
# The Cyface GeoServer Docker Setup is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with the Cyface GeoServer Docker Setup. If not, see <http://www.gnu.org/licenses/>.
#

FROM openjdk:8-jre-alpine

MAINTAINER Cyface GmbH <mail@cyface.de>

ARG GEOSERVER_VERSION=2.14.1
ENV GEOSERVER_HOME /geoserver

RUN set -x \
&& apk add --update openssl \
&& wget -O /tmp/geoserver.zip http://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-bin.zip \
&& unzip -d /tmp/ /tmp/geoserver.zip \
&& mv /tmp/geoserver-$GEOSERVER_VERSION $GEOSERVER_HOME \
&& rm -rf /tmp/geoserver.zip \
&& adduser -S geoserver \
&& chown -R geoserver $GEOSERVER_HOME \
&& mkdir -p /docker-entrypoint-initgeoserver.d

COPY app/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["geoserver"]

USER geoserver
#VOLUME $GEOSERVER_HOME/data_dir
EXPOSE 8080
