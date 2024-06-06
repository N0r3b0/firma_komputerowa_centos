# Use the CentOS 8 base image
FROM centos:8

# Update repository URLs to vault.centos.org
RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Update the system and install sudo, vim, PostgreSQL, and passwd
RUN dnf -y update && \
    dnf -y install sudo vim postgresql-server postgresql-contrib passwd

# Give postgres user sudo privileges
RUN echo "postgres:postgres" | chpasswd && \
    echo "postgres ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Initialize PostgreSQL
RUN mkdir -p /var/lib/pgsql/data && \
    chown -R postgres:postgres /var/lib/pgsql && \
    sudo -u postgres /usr/bin/initdb -D /var/lib/pgsql/data

# Create a directory for the logfile with proper permissions
RUN mkdir -p /var/lib/pgsql/log && \
    chown -R postgres:postgres /var/lib/pgsql/log

# Expose the PostgreSQL port
EXPOSE 5432

# Switch to the postgres user
USER postgres

# Start PostgreSQL
CMD ["sh", "-c", "/usr/bin/pg_ctl -D /var/lib/pgsql/data -l /var/lib/pgsql/log/logfile start && tail -f /var/lib/pgsql/log/logfile"]
