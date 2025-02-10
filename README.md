# Tabela de Conteúdos
1. [Screenshots](#screenshots)
2. [Funcionalidades](#funcionalidades)
3. [Bônus Implementados](#bônus-implementados)
4. [Principais Gems](#principais-gems)
5. [Como Executar](#como-executar)
6. [Testes Automatizados](#testes-automatizados)
7. [Comandos Úteis do Makefile](#comandos-úteis-do-makefile)

## Screenshots

<img width="1454" alt="image" src="https://github.com/user-attachments/assets/d1048640-48d3-40e1-8a98-fbcddd30b0f9" />

## Funcionalidades
1. **Autenticação**
  - Login e logout para administradores.
2. **Gerenciamento de Administradores**
  - Adicionar, listar, editar e excluir administradores.
3. **Gerenciamento de Empresas**
  - Adicionar, listar, editar e excluir empresas.
4. **Gerenciamento de Convites**
  - Adicionar, listar, editar e excluir convites.
  - Filtro de convites por:
    - Nome do usuário convidado
    - Empresa
    - Intervalo de datas

## Bônus Implementados
- **Filtros Avançados para Convites:**
  - Filtragem por nome (do usuário) e email.
  - Filtragem por empresa e por intervalo de datas.
- **Docker:**
  - Configuração do ambiente de desenvolvimento utilizando Docker.
- **Testes Automatizados:**
  - Cobertura completa com RSpec, Factory Bot e Shoulda Matchers.
- **Organização do Código:**
  - Uso de namespaces e casos de uso para melhor separação de responsabilidades.

## Principais Gems
- `devise`: Gerenciamento de autenticação para administradores.
- `rspec-rails`: Framework de testes.
- `factory_bot_rails`: Criação de dados para testes.
- `shoulda-matchers`: Matchers adicionais para testes de modelos e controllers.
- `cssbundling-rails`: Integração com Tailwind CSS.

## Como Executar

### Via Docker Compose (Recomendado)
1. Construir e Iniciar os Contêineres:
  ```sh
  docker compose build
  docker compose up -d
  ```
2. Acessar a Aplicação:
  Abra [http://localhost:3000](http://localhost:3000) no navegador.
3. Parar a Aplicação:
  ```sh
  docker compose down
  ```

### Execução Manual (Sem Docker)
1. Instale Ruby (3.3.1 ou superior), PostgreSQL e Node.js.
2. Configure o arquivo `config/database.yml` e crie o banco de dados.
3. Instale as dependências:
  ```sh
  bundle install
  ```
4. Configure o banco:
  ```sh
  bin/rails db:setup
  ```
5. Inicie o servidor:
  ```sh
  bin/rails server
  ```
6. Acesse [http://localhost:3000](http://localhost:3000).

## Testes Automatizados

Para executar a suíte de testes:

### Dentro do Docker
```sh
docker compose exec -e RAILS_ENV=test web bundle exec rspec
```

### Ou Localmente
```sh
bundle exec rspec
```

## Comandos Úteis do Makefile

O projeto inclui um Makefile para facilitar tarefas do dia a dia:
- `make start`: Inicia todos os serviços (contêiner web, PostgreSQL, etc.).
- `make stop`: Para e remove os contêineres.
- `make bash`: Abre um shell interativo dentro do contêiner web.
- `make console`: Abre o console Rails dentro do contêiner web.
- `make tests`: Executa a suíte de testes com RSpec.
- `make logs`: Exibe os logs dos serviços.
- `make clean`: Remove contêineres, imagens e volumes órfãos.

Para ver todos os comandos disponíveis, execute:
```sh
make help
```

---

Feito com ❤️, Ruby on Rails e Tailwind CSS
Projeto desenvolvido para o Desafio Backend da VIK
