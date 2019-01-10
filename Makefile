SRC_NAME =	main.c 

NAME = scop

CC = gcc

# CFLAGS = -Wall -Wextra -Werror
# CFLAGS = -Wall -Wextra -g -fsanitize=address

OBJ_PATH = obj/

OBJ_NAME = $(SRC_NAME:.c=.o)

SRC_PATH = src/

SRC = $(addprefix $(SRC_PATH),$(SRC_NAME))

OBJ = $(addprefix $(OBJ_PATH),$(OBJ_NAME))

LIBGLFW = glfw-3.2.1

all : $(NAME)

$(NAME) : $(LIBGLFW) $(OBJ_PATH) $(OBJ)
	@echo ""
	@$(CC) $(OBJ) $(LFLAGS) -o $@ 
	@echo "\x1b[32;01m$@ SUCCESSFULLY CREATED !\x1b[32;00m"

$(OBJ_PATH):
	@mkdir -p $@

$(OBJ_PATH)%.o: $(SRC_PATH)%.c
	@echo "\x1b[32;01m.\x1b[32;00m\c"
	@$(CC) $(CFLAGS) $(INC) -o $@ -c $<

$(LIBGLFW) :
	@if [ ! -d "./$(LIBGLFW)" ]; then \
		curl -LO https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip; \
		unzip *.zip; \
		mv *.zip "./$(LIBGLFW)"; \
		cd $(LIBGLFW); \
		cmake docs; \
		make; \
		echo "\033[32mLib $(LIBGLFW) compiled\033[0m"; \
	fi

clean:
	@printf "%-50s" "deleting objects..." 
	@rm -rf $(OBJ)
	@rm -rf $(OBJ_PATH)
	@printf "\033[1;32m[OK]\033[0m\n"

fclean: clean
	@printf "%-50s" "deleting executable..." 
	@rm -rf $(NAME)
	@printf "\033[1;32m[OK]\033[0m\n"

re: fclean all

cleanlib: 
	@printf "%-50s" "deleting libs..." 
	@rm -rf $(LIBGLFW)
	@printf "\033[1;32m[OK]\033[0m\n"