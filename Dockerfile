FROM ubuntu:18.04

ENV DEBIAN_FRONTED=noninteractive
ENV ODOO_VERSION=13.0
COPY odoo-install.sh /

EXPOSE 8069/tcp
EXPOSE 5432/tcp
VOLUME /external-addons

RUN ["/bin/bash", "./odoo-install.sh"]

