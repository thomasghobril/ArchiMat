# ---------------------------- #
# -- SortieDeCache Makefile -- #
# ---------------------------- #

# -- File list ----------
FILE = main.cpp


# -- Paths ----------
SRC_PATH = src
OBJ_PATH = obj
EXE_PATH = exe
INC_PATH = include

# -- Macros ----------
CC = g++

# -- Flags ----------
C_OPTIMISATION_FLAGS = -O3 -std=c++17 -g

C_INC_FLAGS = -I$(INC_PATH)

CFLAGS = $(C_OPTIMISATION_FLAGS) $(C_INC_FLAGS)
LDFLAGS = $(C_OPTIMISATION_FLAGS) $(C_INC_FLAGS)

# -- Final product ----------
PRODUCT   = SortieDeCache.exe

# -- src and obj List ----------
SRC = $(addprefix ${SRC_PATH}/, $(FILE))
OBJ = $(addprefix ${OBJ_PATH}/, $(addsuffix .o, $(basename $(FILE))))

# -- Base rules ----------
$(OBJ_PATH)/%.o : $(SRC_PATH)/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@

#-----Main rule ----------
$(EXE_PATH)/$(PRODUCT): $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS) $(INC) $(LIB_LIB_PATH) -lm

# -- Cleanup ----------
clean:
	rm -f $(OBJ)
