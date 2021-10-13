# README

Código da API rails para o desafio da EasyLive

# Descrição

Plataforma backend Ruby on Rails. Por decisão de aumentar a segurança, as rotas da API (de products e de cart) são fechadas e reservadas para usuários cadastrados, conforme descrito na documentação.
Para acessar uma rota protegida por autenticação, feita usando a gem devise-token-auth, é preciso incluir nos headers de cada requisição:

```
uid
client
access-token
```

, sendo que uid equivale ao email do usuário cadastrado. É possível obtê-las no login ou signup, assim como na rota de validate_token.

Para a inserção de produtos, foi criado um sistema de inserção. No painel de administração, o admin deve inserir uma loja com o nome que desejar e a URL dela. Caso a URL seja válida, é feito a coleta e inserção automática de produtos. Caso não seja, retornará um erro e a loja não será inserida. O sistema de inclusão foi implementado para APIs da VTEX e MercadoLivre, conforme pedido no desafio.

As lojas devem ser inseridas no seguinte formato:

VTEX: https://url_da_loja/

Não precisa colocar o link da API deles após a barra.

Ex: Insira https://www.fossil.com.br/ como URL para a loja Fossil, que o sistema coletará todos os seus items (já está no db:seed)

MercadoLivre:

Para fins de processamento, foi definido que cada vendedor do mercado livre conta como uma loja, devendo sua url ser:

https://www.mercadolivre.com.br/perfil/nome_do_vendedor

Ex: O vendedor NVFULLCOMM deve ter sua URL inserida como:

https://www.mercadolivre.com.br/perfil/NVFULLCOMM

# Acesso

Foi feito deploy no servidor do heroku, e o link de acesso é:

https://desafio-easy-live-rails.herokuapp.com/

Pra testar a API, foi criado pelo db:seed o user com as credenciais:

user@user.com
senha: 12345678

, que retornará o uid, client e access-token devidos para as próximas requisições.

As rotas da API estão listadas no root, documentadas com a gem apipie.
Com exceção do painel de administração, todas as rotas se encontram em /api/v1/

# Painel de Administração

Usei a gem Admistrate. A rota de acesso é
https://desafio-easy-live-rails.herokuapp.com/myadminpanel/
, e precisa estar logado como admin.

Pra impedir que qualquer pessoa acesse o painel de administração, retirei a de de signup. Novos admins devem ser criados diretamente pelo console do rails.

Pra testar o painel, foi criado pelo db:seed o admin com as credenciais:

admin@admin.com
senha: 12345678

Decidi que administradores podem remover usuários no painel, mas não podem remover outros administradores.

# Iniciando o Sistema

Renomeie o arquivo .env.example para .env, e preencha as variáveis com seu user e senha do mysql.

Para iniciar o servidor:

```
bundle install
rails db: create
rails db:migrate
rails db:seed
# Reindexar Product para o searchkick
rails c
Product.reindex
exit
rails s -p 3000
```

É preciso estar com o elasticsearch instalado e ativo, por conta do sistema de pesquisa.
Para ver os emails enviados em development, instale e ative o mailcatcher com o comando:

```
mailcatcher
```

Caso decida usar o frontend NextJS desenvolvido em localhost, deve-se subi-lo na porta 3001, para não conflitar com o rails e também por conta do valor da variável config.default_password_reset_url no arquivo de initializer/devise_token_auth.rb, definido como ‘http://localhost:3001/reset-token’ para ambiente de dev. Sem isso não será possível utilizar a rota de recuperar a senha na plataforma frontend.

O email usado em produção para recuperar a senha é o meu cmendesdf@gmail.com
