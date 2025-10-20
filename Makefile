# Nome do container do MySQL no Docker
CONTAINER_NAME=mysql_db
DB_USER=root
DB_PASS=root
DB_NAME=sistema_bancario

# Caminho para os arquivos SQL
SCHEMA=./sql/schema.sql
SCHEMADROP=./sql/schema-drop.sql
INSERTS=./sql/inserts.sql

CADASTROPF=./sql/clientePF/schema-cadastroPF.sql
CADASTROPJ=./sql/clientePJ/schema-cadastroPJ.sql

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

add-CPF:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) $(DB_NAME) < $(CADASTROPF)

add-CNPJ:
	docker exec -i $(CONTAINER_NAME) mysql -u $(DB_USER) -p$(DB_PASS) $(DB_NAME) < $(CADASTROPJ)
