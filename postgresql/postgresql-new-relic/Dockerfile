FROM postgres:latest

# Reference
# https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/linux-installation/install-infrastructure-monitoring-agent-linux

# https://bugs.launchpad.net/ubuntu/+source/sysvinit/+bug/1456670
# https://stackoverflow.com/questions/38229579/docker-container-lsmod-not-found
RUN apt update \
    && apt install -y wget initscripts insserv kmod \
    && dpkg-reconfigure initscripts

# https://download.newrelic.com/infrastructure_agent/binaries/linux/amd64/
RUN wget https://download.newrelic.com/infrastructure_agent/binaries/linux/amd64/newrelic-infra_linux_1.15.1_amd64.tar.gz -O newrelic-infra.tar.gz \
    && tar xf newrelic-infra.tar.gz \
    && cd newrelic-infra \
    && echo "license_key=\"LICENSE_KEY\"" >> config_defaults.sh \
    && ./installer.sh

COPY ./postgresql-config.yml /etc/newrelic-infra/integrations.d/postgresql-config.yml

RUN wget https://download.newrelic.com/infrastructure_agent/binaries/linux/amd64/nri-postgresql_linux_2.6.1_amd64.tar.gz -O nri-postgresql.tar.gz \
    && mkdir nri-postgresql \
    && mv nri-postgresql.tar.gz nri-postgresql/ \
    && cd nri-postgresql \
    && tar xf nri-postgresql.tar.gz \
    && cp var/db/newrelic-infra/newrelic-integrations/postgresql-definition.yml /var/db/newrelic-infra/newrelic-integrations \
    && cp -R var/db/newrelic-infra/newrelic-integrations/bin/ /var/db/newrelic-infra/newrelic-integrations

# Add track io timing configuration
RUN echo "track_io_timing = on" >> /var/lib/postgresql/data/postgresql.conf

COPY ./entrypoint.sh /

ENTRYPOINT []
