export DEBEZIUM_VERSION=1.9
source ./venv41/bin/activate
docker compose -f docker-compose-postgres.yaml up -d
if [[ $1 == 'trunc' ]]
then
	python3 clean_bigquery.py
fi
echo""
echo "Waiting ........."
echo ""
sleep 20
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @postgres-connection-credential.json
echo""
echo "Waiting ........."
sleep 5
python3 consumer_to_bigquery.py

### python3 apiPeoplePostgres/server.py
### gcloud compute ssh --project=ambient-antenna-369806 --zone=europe-west9-a ud-instance-2 -- -NL 5001:localhost:5001
