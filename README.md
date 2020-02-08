# testTeerafor
Terraform example

### Run the example
Setup your `~/.aws/credentials` with your access key / secret key
This example is performed with **Terraform v0.12.19**

To init the `infra` folder execute `make init`
To deploy your infra execute `make rebuild_all`

To execute one of those command with a different version of terraform:
`make TF_EXEC=my_old_terraform  rebuild_all`