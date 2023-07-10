INTRA_USER = dselmy
ADRESS = $(INTRA_USER).42.fr
DATA_DIR = /home/$(INTRA_USER)/data

all: $(DATA_DIR) up

$(DATA_DIR):
	@echo "Making $(DATA_DIR)"
	@sudo mkdir $(DATA_DIR)
	@sudo mkdir $(DATA_DIR)/wordpress
	@sudo mkdir $(DATA_DIR)/database

up:
	@echo "Setting up host adress: " $(ADRESS)
	# for WSL also edit 'Windows/System32/drivers/etc/hosts'
	@sudo sed -i "0,/localhost/{s//$(ADRESS)/g}" /etc/hosts
	@echo "Building docker-compose"
	@sudo docker-compose -f ./srcs/docker-compose.yml up
	# @sudo docker-compose --verbose -f ./srcs/docker-compose.yml up

re: 
	@sudo docker-compose -f ./srcs/docker-compose.yml up --build
check:
	docker ps -a
	docker images ls -a
	docker volume ls
	docker network ls

clean:
	-@docker-compose -f ./srcs/docker-compose.yml down;
	-@docker rm -f $$(docker ps -a -q)
	@echo "-- Removed Docker containers"
	-@docker rmi -f $$(docker images -qa) 
	@echo "-- Removed Docker images"
	-@docker volume rm $$(docker volume ls -q)
	@echo "-- Removed Docker volumes"
	-@docker network rm $$(docker network ls -q)
	@echo "Unsetting host adress"
	@sudo sed -i "s/$(ADRESS)/localhost/g" /etc/hosts

fclean: clean
	sudo rm -rf $(DATA_DIR)
