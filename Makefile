# Nome do container do MySQL no Docker
CONTAINER_NAME=mysql_db
DB_USER=root
DB_PASS=root
DB_NAME=sistema_bancario

# Caminho para os arquivos SQL
SCHEMA=./sql/schema.sql
SCHEMADROP=./sql/schema_drop.sql
SCHEMACADASTRO=./sql/schema_cadastro.sql
SCHAMAALTERSTATUS=./sql/schema_alter_status.sql
INSERTS=./sql/inserts.sql

# Apaga tabelas
drop-tables:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) < $(SCHEMADROP)

# Cria as tabelas
create-tables:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) < $(SCHEMA)

# Apaga e recria o schema e popula com dados iniciais
reset-db:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) < $(SCHEMA)
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) $(DB_NAME) < $(INSERTS)

# Executa apenas o seed (dados iniciais)
inserts:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) $(DB_NAME) < $(INSERTS)

add-cliente:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) < $(SCHEMACADASTRO)

alter-status-conta:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) < $(SCHAMAALTERSTATUS)

toggle-status: alter-status-conta
	@if [ -z "$(ACCOUNT_ID)" ]; then \
		echo "ERRO: É necessário fornecer o ID da conta. Exemplo: make toggle-status ACCOUNT_ID=10"; \
		exit 1; \
	fi
	
	@echo "Executando CALL alter_status_conta($(ACCOUNT_ID)) na base $(DB_NAME)..."
	# Executa o comando CALL diretamente no container MySQL, usando a variável corrigida
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) $(DB_NAME) -e "CALL alter_status_conta($(ACCOUNT_ID));"

