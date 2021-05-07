## Repositório bootcamp Engenharia de Dados - How Bootcamps

### Sobre Terraform

Para executar o terraform primeiro deve-se alterar o _profile_ em _provider_. No meu caso já tenho o AWS Cli 
configurado, então é só especificar qual _profile_ quero usar. Caso tenha apenas o _profile_ **default** não
é necessário especificar, o terraform já reconhece.

Se não tiver instalado o AWS Cli siga o passo a passo nesse 
link https://docs.aws.amazon.com/pt_br/cli/latest/userguide/install-cliv2.html

``` hcl
provider "aws" {
  profile = "<seu_profile>"
  region = "<sua_regiao_de_preferencia>"
}
```

Para executar o terraform navegue até a pasta pelo terminal, logo depois:

- Inicie o terraform:
```text
terraform init
```

- Verifique as configurações que serão aplicadas:
```text
terraform plan
```

- Aplique as configurações, irá pedir para confirmar e basta digitar ___sim___:
```text
terraform apply
```

- Para destruir o que foi implementado, basta digitar:
```text
terraform destroy
```