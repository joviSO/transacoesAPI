# README
Bem não tenho muita criatividade para documentação então serei o mais objetivo que eu conseguir, esse desafio foi bem interessante, foi a primeira vez que trabalho usando JWT
realmente me prendeu muito nesse periodo do teste, a questão do swagger estarei deixando pra proxima, e os testes dos principais endpoints estão feitos a pesar de eu não conseguir passar eles, pois precisavam
do token gerado pelo authenticateApplication

## Ruby

Versão do Ruby: 3.3.1
Versão do Rails: 7.1.3

## Servidor utilizado

Puma

## Como acessar o Servidor
abra o terminal, entre na pasta do projeto e rode o comando:

rails s
Esse projeto foi configurado pra rodar em
http://localhost:3001

## Comando para povoar o Banco de dados

certifique-se que você tenha o Postgresql instalado e configurado

Primeiramente rode o comando:

rails db:create \\\criará o banco de dados com o nome de acodo com o do projeto:

rails db:migrate \\\esse comando fará com que as mudanças das migraçoes sejam persistidas no banco:

rails db:seed \\\criei um pequeno script para gerar alguns usuarios e transações para poder testar:

Esse seed tras um usuario por padrão teste@teste.com, as senhas do seed por padrão são 123123
