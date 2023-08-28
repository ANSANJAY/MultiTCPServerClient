#! /bin/bash
CC=gcc

tcp_client:tcp_client.o
	${CC} -o tcp_client tcp_client.o

tcp_server:tcp_server.o
	${CC} -o tcp_server tcp_server.o

tcp_client.o:tcp_client.c declarations.h headers.h datastruct.h
	${CC} -c tcp_client.c

tcp_server.o:tcp_server.c declarations.h headers.h datastruct.h
	${CC} -c tcp_server.c

clean:
	rm *.o
	rm tcp_server
	rm tcp_client