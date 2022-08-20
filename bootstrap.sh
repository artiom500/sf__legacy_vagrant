#!/bin/sh -e
yum update -y
cat << EOF > /etc/yum.repos.d/pgdg-84.repo
[pgdg84]
name=PostgreSQL 8.4 RPMs for RHEL/CentOS 6
baseurl=https://yum-archive.postgresql.org/8.4/redhat/rhel-6-x86_64
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG
EOF
    yum -y install postgresql84-server
	    /etc/init.d/postgresql-8.4 initdb
	echo 'listen_addresses = '"'"'*'"'" >> /var/lib/pgsql/8.4/data/postgresql.conf
    echo 'host all all 0.0.0.0/0 trust' >> /var/lib/pgsql/8.4/data/pg_hba.conf
    /etc/init.d/postgresql-8.4 start
	cd /
    echo "CREATE ROLE skill CREATEDB CREATEROLE LOGIN PASSWORD 'skill_2022'" | sudo -u postgres psql -a -f -
    echo "CREATE DATABASE skill OWNER skill" | sudo -u postgres psql -a -f -
    echo "ALTER USER postgres WITH PASSWORD 'skill_2022'" | sudo -u postgres psql -a -f -
    echo "Restart postgresql "
    /etc/init.d/postgresql-8.4 restart