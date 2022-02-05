startdb:
	docker start postgres14.1

createdb:
	docker exec -it postgres14.1 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres14.1 dropdb simple_bank

postgres:
	docker run --name postgres14.1 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14.1-alpine

migrate/up:
	migrate -path db/migrations -database "postgres://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrate/down:
	migrate -path db/migrations -database "postgres://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose  down

sqlc/gen:
	sqlc generate

sqlc/check:
	sqlc check

.PHONY: createdb dropdb postgres migrate/up migrate/down startdb sqlc/generate sqlc/check