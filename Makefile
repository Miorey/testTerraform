
TF_EXEC?=terraform

zip_lambda:
	mkdir -p dist
	cd dist && rm -f *.zip && zip -jr gg_server_info.zip ../lambda/gg_server_info/*

test:
	cd infra && $(TF_EXEC) init \
		-backend-config "bucket=cba-terraform-test-bucket" \
		-backend-config "key=terraform/$(EnvName)/iip_opcua_connector_state.json"

rebuild_all: zip_lambda
	cd infra && $(TF_EXEC) destroy
	cd infra && $(TF_EXEC) apply

