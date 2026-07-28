i2b2_webclient_image_tag="${1:-master}"
i2b2_core_server_branch="${2:-master}"
i2b2_data_branch="${3:-master}"

core_server_image=$docker_username/$docker_reponame:i2b2-core-server_$i2b2_core_server_branch
pgsql_image=$docker_username/$docker_reponame:i2b2-data-pgsql_$i2b2_data_branch


if [ "$HAS_SECRETS" = "true" ]; then
    sed -i "s|i2b2/i2b2-core-server:\${I2B2_CORE_SERVER_TAG}|${core_server_image}|g" docker-compose.yml
    sed -i "s|i2b2/i2b2-data-pgsql:\${I2B2_DATA_PGSQL_TAG}|$pgsql_image|g" docker-compose.yml

echo $i2b2_webclient_image_tag
sed -i "s|i2b2/i2b2-webclient:\${I2B2_WEBCLIENT_TAG}|$i2b2_webclient_image_tag|g" docker-compose.yml

#removing old test containers 
#docker rm -f $(docker ps -a -q)

# docker compose up -d 
# docker ps 
# #waiting for core-server and database to get started
# sleep 100

#start the test container  and run test cases 
