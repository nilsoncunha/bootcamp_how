# Repositório bootcamp Engenharia de Dados - How Bootcamps

## Terraform
Para executar o terraform primeiro deve-se alterar o _profile_ em _provider_. No meu caso já tenho o AWS Cli 
configurado, então é só especificar qual _profile_ quero usar. Caso tenha apenas o _profile_ **default** não
é necessário especificar, o terraform já reconhece

``` hcl
provider "aws" {
  profile = "<seu_profile>"
  region = "<sua_regiao_de_preferencia>"
}
```