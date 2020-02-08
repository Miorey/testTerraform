
TF_EXEC?=terraform

zip_lambda:
	mkdir -p dist
	cd dist && rm -f *.zip && zip -jr gg_server_info.zip ../lambda/gg_server_info/*

init:
	cd infra && $(TF_EXEC) init

rebuild_all: zip_lambda
	cd infra && $(TF_EXEC) destroy
	cd infra && $(TF_EXEC) apply

