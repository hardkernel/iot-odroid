DIR=$(DESTDIR)/opt/iot
LIBDIR=$(DESTDIR)/usr/lib

COMPILELIBDIR=./lib
LIBNAME=paho-mqtt3a

all: iot

.PHONY: all install clean distclean

iot: iotmain.c cpustat.c mac.c mqttPublisher.c jsonator.c iot.h
	export LIBRARY_PATH=$(COMPILELIBDIR):$(LIBRARY_PATH)
	$(CC) iotmain.c cpustat.c mac.c mqttPublisher.c jsonator.c -o $@ -l$(LIBNAME) -lpthread -lm -L $(COMPILELIBDIR) -I .
	strip $@

install: iot
	mkdir -p $(LIBDIR)
	mkdir -p $(DIR)
	install iot $(DIR)/iot
	cp $(COMPILELIBDIR)/libpaho-mqtt3a.so.1.0 $(LIBDIR)/libpaho-mqtt3a.so.1.0
	ln -s libpaho-mqtt3a.so.1.0 $(LIBDIR)/libpaho-mqtt3a.so.1
	ln -s libpaho-mqtt3a.so.1 $(LIBDIR)/libpaho-mqtt3a.so
	install iotGetDeviceID.sh $(DIR)/iotGetDeviceID.sh
	cp README.md $(DIR)/README

clean:
	rm -f iot