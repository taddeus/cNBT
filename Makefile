# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# Lukas Niederbremer <webmaster@flippeh.de> and Clark Gaebel <cg.wowus.cg@gmail.com>
# wrote this file. As long as you retain this notice you can do whatever you
# want with this stuff. If we meet some day, and you think this stuff is worth
# it, you can buy us a beer in return.
# -----------------------------------------------------------------------------

BIN := nbtreader
LIB := libnbt.a
CHECK := check

CFLAGS := -g -Wcpp -Wall -Wextra -std=c99 -pedantic -fPIC
LDFLAGS := -L.
LDLIBS := -lnbt -lz

.PHONY: all test clean

all: $(LIB) $(BIN)

nbtreader: main.o
%: %.c

$(LIB): buffer.o nbt_loading.o nbt_parsing.o nbt_treeops.o nbt_util.o
	ar -rcs $@ $^

test: $(CHECK)
	cd testdata && ls -1 *.nbt | xargs -n1 valgrind ../$(CHECK) && cd ..

clean:
	rm -f *.o $(BIN) $(LIB) $(CHECK)
