CC = g++
PROG_NAME = calc

OUT_DIR = bin
BUILD_DIR = build

SRC = src
INCLUDE_DIR = include

ifeq ($(OS),Windows_NT)
	EXT = .exe
else
	EXT = 
endif

OUT = $(OUT_DIR)/$(PROG_NAME)$(EXT)

FILES = $(patsubst $(SRC)/%.cpp,%.cpp,$(wildcard $(SRC)/*.cpp))
OBJS = $(foreach file,$(subst .cpp,.o,$(FILES)),$(BUILD_DIR)/$(file))

TESTS = $(patsubst tests/%.cpp,%.cpp,$(wildcard tests/*.cpp))
TEST_OBJS = $(foreach file,$(subst .cpp,.o,$(TESTS)),$(BUILD_DIR)/$(file))

all: build_dirs $(OBJS)
	$(CC) -I$(INCLUDE_DIR) -o $(OUT) $(OBJS) main.cpp

tests: build_dirs $(OBJS) $(TEST_OBJS)
	$(CC) -I$(INCLUDE_DIR) -Itests -o $(OUT) $(TEST_OBJS) $(OBJS) testmain.cpp
	$(OUT)

$(BUILD_DIR)/%.o: $(SRC)/%.cpp
	$(CC) -I$(INCLUDE_DIR) -c $< -o $@

$(BUILD_DIR)/%.o: tests/%.cpp
	$(CC) -I$(INCLUDE_DIR) -c $< -o $@

build_dirs:
	-mkdir $(BUILD_DIR)
	-mkdir $(OUT_DIR)

run:
	$(OUT)

clean:
	-rm -f $(OBJS) $(OUT)
