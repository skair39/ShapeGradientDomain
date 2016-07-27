SHAPE_GRADIENT_DOMAIN_TARGET=ShapeGradientDomain
NORMAL_SMOOTH_TARGET=NormalSmooth

SHAPE_GRADIENT_DOMAIN_SOURCE=ShapeGradientDomain/ShapeGradientDomain.cpp
NORMAL_SMOOTH_SOURCE=NormalSmooth/NormalSmooth.cpp


CFLAGS += -fpermissive -fopenmp -Wno-deprecated -Wno-unused-result -Wno-format -msse2 -std=c++14 -DUSE_EIGEN
LFLAGS += -lgomp -lpthread

CFLAGS_DEBUG = -DDEBUG -g3
LFLAGS_DEBUG =

CFLAGS_RELEASE = -O3 -DRELEASE -funroll-loops -ffast-math
LFLAGS_RELEASE = -O3 

SRC = ./
BIN = Bin/
BIN_O = ./
INCLUDE = /usr/include/ -I.

CC=gcc
CXX=g++
MD=mkdir

SHAPE_GRADIENT_DOMAIN_OBJECTS=$(addprefix $(BIN_O), $(addsuffix .o, $(basename $(SHAPE_GRADIENT_DOMAIN_SOURCE))))
NORMAL_SMOOTH_OBJECTS=$(addprefix $(BIN_O), $(addsuffix .o, $(basename $(NORMAL_SMOOTH_SOURCE))))

all: CFLAGS += $(CFLAGS_RELEASE)
all: LFLAGS += $(LFLAGS_RELEASE)
all: $(BIN)
all: $(BIN)$(SHAPE_GRADIENT_DOMAIN_TARGET)
all: $(BIN)$(NORMAL_SMOOTH_TARGET)

debug: CFLAGS += $(CFLAGS_DEBUG)
debug: LFLAGS += $(LFLAGS_DEBUG)
debug: $(BIN)
debug: $(BIN)$(SHAPE_GRADIENT_DOMAIN_TARGET)
debug: $(BIN)$(NORMAL_SMOOTH_TARGET)

clean:
	rm -f $(BIN)$(SHAPE_GRADIENT_DOMAIN_TARGET)
	rm -f $(BIN)$(NORMAL_SMOOTH_TARGET)
	rm -f $(SHAPE_GRADIENT_DOMAIN_OBJECTS)
	rm -f $(NORMAL_SMOOTH_OBJECTS)

$(BIN):
	$(MD) -p $(BIN)

$(BIN)$(SHAPE_GRADIENT_DOMAIN_TARGET): $(SHAPE_GRADIENT_DOMAIN_OBJECTS)
	$(CXX) -o $@ $(SHAPE_GRADIENT_DOMAIN_OBJECTS) $(LFLAGS)

$(BIN)$(NORMAL_SMOOTH_TARGET): $(NORMAL_SMOOTH_OBJECTS)
	$(CXX) -o $@ $(NORMAL_SMOOTH_OBJECTS) $(LFLAGS)

$(BIN_O)%.o: $(SRC)%.c
	$(CC) -c -o $@ $(CFLAGS) -I$(INCLUDE) $<

$(BIN_O)%.o: $(SRC)%.cpp
	$(CXX) -c -o $@ $(CFLAGS) -I$(INCLUDE) $<


