# EnterpriseLikeK8s / Antigravity Finance

Este repositório reúne uma aplicação de finanças pessoais em formato de dashboard, com backend em FastAPI, frontend estático, banco de dados relacional, observabilidade com Prometheus/Grafana e infraestrutura pronta para Kubernetes e AWS com Terraform/Terragrunt.

O projeto foi pensado como uma referência prática para um ambiente "enterprise-like", com foco em:

- API REST robusta para gestão de transações financeiras
- Interface web simples e responsiva
- Persistência local ou via PostgreSQL
- Métricas para monitoramento
- Deploy com Docker, Kubernetes e infraestrutura como código

---

## Visão geral

A aplicação permite registrar receitas e despesas, visualizar estatísticas financeiras, acompanhar metas de economia e consultar métricas do serviço. Ela pode rodar localmente para desenvolvimento ou ser implantada em ambientes containerizados e cloud-native.

O projeto é composto por:

- Backend: FastAPI + SQLAlchemy
- Banco de dados: SQLite por padrão, PostgreSQL opcional
- Frontend: HTML/CSS/JavaScript estático
- Observabilidade: Prometheus + Grafana
- Deploy: Docker Compose, Kubernetes e Terraform/Terragrunt

---

## Funcionalidades

- Cadastro, listagem e remoção de transações
- Categorização entre receita e despesa
- Cálculo de saldo líquido e despesas por categoria
- Gestão de metas de economia
- Endpoint de saúde para validação de disponibilidade
- Endpoint de métricas para integração com Prometheus
- Interface web para interação rápida

---

## Arquitetura

A estrutura do projeto segue uma separação clara entre aplicação, infraestrutura e observabilidade:

```text
app/                  # Backend, frontend estático e configuração de execução
manifests/           # Manifestos Kubernetes
terraform/           # Terraform/Terragrunt para provisionamento AWS
```

Fluxo principal:

1. O usuário acessa a interface web.
2. A aplicação envia requisições ao backend FastAPI.
3. O backend persiste os dados no SQLite (local) ou PostgreSQL (externo).
4. O endpoint /metrics expõe métricas para Prometheus.
5. O Grafana consome esses dados para dashboards.

---

## Estrutura do repositório

```text
.
├── app/
│   ├── database.py
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── server.py
│   ├── test_api.py
│   └── public/
│       ├── app.js
│       ├── index.html
│       └── styles.css
├── manifests/
│   ├── deployment.yaml
│   └── service.yaml
└── terraform/
    ├── bootstrap/
    └── infrastructure/
```

### Descrição dos principais arquivos

- app/server.py: aplicação FastAPI, rotas da API e servir frontend
- app/database.py: modelos, inicialização do banco e operações CRUD
- app/public/: frontend estático em HTML/CSS/JavaScript
- app/docker-compose.yml: execução local com PostgreSQL, FastAPI, Prometheus e Grafana
- manifests/: templates Kubernetes para deploy e serviço
- terraform/: infraestrutura como código para AWS com Terraform/Terragrunt

---

## Requisitos

Antes de rodar, certifique-se de ter instalado:

- Python 3.10+
- pip
- Docker e Docker Compose (para execução em containers)
- Kubernetes (opcional, para testes locais com kubectl)
- Terraform e Terragrunt (opcional, para provisionamento da infraestrutura)

---

## Executando localmente

### 1. Criar ambiente virtual

```bash
cd app
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 2. Rodar a aplicação

```bash
python server.py
```

A aplicação fica disponível em:

- http://localhost:8000
- http://localhost:8000/healthz
- http://localhost:8000/metrics

### 3. Banco de dados

Por padrão, o projeto usa SQLite armazenado localmente no arquivo finance.db dentro da pasta app.

Para usar PostgreSQL, defina a variável de ambiente:

```bash
export DATABASE_URL="postgresql://usuario:senha@host:5432/nome_do_banco"
```

Se a variável não existir, o sistema usará SQLite automaticamente.

---

## Executando com Docker Compose

A partir da pasta app:

```bash
cd app
docker compose up --build
```

Serviços disponibilizados:

- Aplicação web: http://localhost:8000
- PostgreSQL: localhost:5432
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

Credenciais padrão do Grafana:

- Usuário: admin
- Senha: admin

---

## Executando com Kubernetes

Os manifests em manifests/ podem ser usados para deploy em um cluster Kubernetes.

```bash
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
```

Observações importantes:

- O deployment usa uma imagem do ECR AWS como exemplo.
- O service expõe a aplicação via LoadBalancer.
- Em um ambiente real, é necessário ajustar a imagem, namespace, secrets e configurações de rede.

---

## Infraestrutura com Terraform/Terragrunt

A pasta terraform contém estruturas para provisionar recursos na AWS.

### Estrutura

- terraform/bootstrap: recursos iniciais como S3, DynamoDB, IAM e OIDC
- terraform/infrastructure/global: recursos compartilhados do ambiente
- terraform/infrastructure/envs/: ambientes dev, staging e prod com módulos de VPC e EKS

### Exemplo de fluxo

```bash
cd terraform/infrastructure/envs/dev
terragrunt run-all plan
terragrunt run-all apply
```

A configuração pode ser ajustada conforme a sua conta AWS, região e necessidades de segurança.

---

## Endpoints da API

### Saúde

- GET /healthz

Retorna status da aplicação.

### Métricas

- GET /metrics

Exibe métricas em formato Prometheus.

### Transações

- GET /api/transactions
- POST /api/transactions
- DELETE /api/transactions

Parâmetros do GET:

- search: filtro por descrição
- type: all, income ou expense
- category: nome da categoria

Exemplo de payload para POST:

```json
{
  "description": "Compras do mês",
  "amount": 125.50,
  "type": "expense",
  "category": "Food",
  "date": "2026-06-29"
}
```

### Estatísticas

- GET /api/stats

Retorna:

- total_income
- total_expense
- net_balance
- categories
- db_type
- db_scope

### Metas de economia

- GET /api/goals
- POST /api/goals

---

## Testes

O projeto inclui um script de testes de integração para validar os principais endpoints.

```bash
cd app
python test_api.py
```

Os testes verificam:

- carregamento da interface web
- listagem de transações
- criação de transação
- cálculo de estatísticas
- endpoint de métricas
- remoção de transação

---

## Observabilidade

A aplicação expõe métricas HTTP via Prometheus. O stack do Docker Compose inclui:

- Prometheus para coleta de métricas
- Grafana para visualização e dashboards

As métricas principais incluem:

- total de requisições HTTP
- latência das requisições
- status code por endpoint

---

## Segurança e boas práticas

Algumas boas práticas já aplicadas no projeto:

- uso de variáveis de ambiente para configuração
- validação de entrada com Pydantic
- CORS habilitado para desenvolvimento
- health check para orquestração e balanceamento
- containerização com imagens dedicadas

Para ambientes de produção, recomenda-se:

- trocar credenciais padrão
- configurar secrets para banco e serviços externos
- habilitar autenticação no Grafana
- usar TLS e políticas de rede mais restritivas

---

## Contribuindo

Contribuições são bem-vindas. Para colaborar:

1. Faça um fork do projeto
2. Crie uma branch para a sua mudança
3. Realize as alterações e teste localmente
4. Abra um pull request descrevendo o que foi alterado

---

## Licença

Este projeto está licenciado sob a licença MIT, uma licença livre e permissiva que permite uso, cópia, modificação, fusão, publicação, distribuição e uso comercial, desde que o aviso de copyright e esta licença sejam preservados.

Veja o arquivo LICENSE para mais detalhes.
