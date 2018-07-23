#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "---- DEBUG"
echo "DATABASE_TYPE=${DATABASE_TYPE}"
echo "DATABASE_ENDPOINT=${DATABASE_ENDPOINT}"
echo "DATABASE_NAME=${DATABASE_NAME}"
echo "DATABASE_USER=${DATABASE_USER}"
echo "DATABASE_PASSWORD=${DATABASE_PASSWORD}"


echo "---- Replacing values in temp grafana conf file"
sudo sed -i 's/DATABASE_TYPE/${DATABASE_TYPE}/g' /tmp/grafana.ini
sudo sed -i 's/DATABASE_ENDPOINT/${DATABASE_ENDPOINT}/g' /tmp/grafana.ini
sudo sed -i 's/DATABASE_NAME/${DATABASE_NAME}/g' /tmp/grafana.ini
sudo sed -i 's/DATABASE_USER/${DATABASE_USER}/g' /tmp/grafana.ini
sudo sed -i 's/DATABASE_PASSWORD/${DATABASE_PASSWORD}/g' /tmp/grafana.ini

echo "--- Replacing values in temp grafana datasource yaml file"
sudo sed -i 's|PROMETHEUS_URL|${PROMETHEUS_URL}|g' /tmp/prometheus.yaml

echo "--- Moving the conf file where it belongs"
sudo mv /tmp/grafana.ini /etc/grafana/grafana.ini
sudo chown root:grafana /etc/grafana/grafana.ini

echo "--- Moving the datasource yaml file where it belongs"
sudo mv /tmp/prometheus.yaml /etc/grafana/provisioning/datasources/prometheus.yaml
sudo chown root:grafana /etc/grafana/provisioning/datasources/prometheus.yaml

echo "--- Moving the dashboard files where they belong..."
sudo mv /tmp/dashboards/* /usr/share/grafana/public/dashboards/
sudo chown root:grafana /usr/share/grafana/public/dashboards/*

echo "--- Starting grafana service"
sudo /bin/systemctl start grafana-server.service

echo "--- Done"
