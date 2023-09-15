# MultiTCPServerClient
MultiTCPServerSuite: A robust TCP framework enabling efficient multiplexed server-client communications. Designed for high-concurrency scenarios, ensuring optimal data transfer with minimal latency. Ideal for applications demanding real-time interactions.



# 🔀 MultiTCPServerSuite

🌐 A robust TCP framework enabling efficient multiplexed server-client communications. Ideal for high-concurrency scenarios and applications demanding real-time interactions.

```sql
                 Server (Using select)
         +-------------------------+
         |                         |
         |       FD_SET            |  
         |     +-------+           |     
         |     | FD 1  |-----------+-----+-----------+
         |     +-------+  select   |     |  Client 1  |
         |                         |     +-----------+
         |                         |
         |     +-------+           |      
         |     | FD 2  |-----------+-----+-----------+
         |     +-------+           |     |  Client 2  |
         |                         |     +-----------+
         |                         |
         |     +-------+           |     +-----------+
         |     | FD N  |-----------+-----+  Client N  |
         |     +-------+           |     +-----------+
         |                         |
         +-------------------------+


```

---

## 📚 Table of Contents
1. [Features](#-features)
2. [Installation](#-installation)
3. [Usage](#-usage)
4. [Technical Breakdown](#-technical-breakdown)
    - [struct sockaddr_in](#struct-sockaddr_in)
    - [inet_ntoa](#inet_ntoa)
    - [ntohs](#ntohs)
5. [Contributing](#-contributing)
6. [License](#-license)

---

## 🌟 Features

# TCP Server-Client Calculation Service

# Detailed Explanation of TCP Server-Client Calculation Service

## Project Structure

The project is composed of multiple C files and headers that contribute to the functioning of the overall TCP Server-Client Calculation Service.

---

### Server (`tcp_server.c`)

#### How it works

1. The server initiates by defining variables and data structures, including a socket file descriptor `sockfd` and a `client` variable that will hold the size of the client's address.
2. It initializes a socket using the `socket()` function call and binds it to a specific port and IP address using `bind()`.
3. The server then starts listening for incoming connections with the `listen()` function.
4. When a client connects, `accept()` is called, and a new file descriptor `connfd` is returned to handle this specific client.
5. The server receives the data packet from the client via the `recvfrom()` function. It performs the arithmetic operation (addition) and prepares the result.
6. Finally, the result is sent back to the client through `sendto()`.

---

### Client (`tcp_client.c`)

#### How it works

1. Similar to the server, the client starts by defining variables and data structures, including a socket descriptor `sockfd`.
2. It initializes a client socket and connects to the server using the `connect()` function.
3. The client then enters a loop (`PROMPT_USER` label) where it prompts the user to enter two integers.
4. These integers are sent to the server via the `sendto()` function.
5. The client then receives the calculated result from the server using `recvfrom()` and displays it.

---

### Shared Components

1. `datastruct.h`: Defines the data structures used for packets that will be sent from the client to the server and vice versa.
2. `declarations.h`: Contains macros for server and client settings like the port number and IP addresses.
3. `headers.h`: Consolidates all the headers needed for the project. These include standard C library headers and specialized headers for network programming.

---

## Key Questions and Answers

### 1. How does the program handle client disconnection gracefully?
**************************
It is worth noting that the current implementation does not handle client disconnection gracefully. An improvement would be to check for returned values from `recvfrom()` and `sendto()` calls to ensure that the client is still connected before attempting further data transmission or reception.

---

### 2. How does the server handle multiple client connections?
**************************
In the current code, the server does not handle multiple clients concurrently. One possible improvement could be to use `fork()` or multi-threading to handle multiple client connections simultaneously.

---

## Areas for Improvement and Further Development

1. Implementation of client disconnection handling.
2. Extension to handle multiple clients concurrently.
3. Improved error handling and reporting.
4. Secure data transmission using SSL/TLS.



---

## 📥 Installation

```bash
git clone https://github.com/ANSANJAY/MultiTCPServerClient
```
``` bash

make tcp_server
make tcp_client

```

---

## 🚀 Usage

Run the client and server in parallel termainals.

```
./tcp_server
./tcp_client

```

![](./Screenshot%20from%202023-08-28%2018-41-45.png)

---

## 🔍 Technical Breakdown

### `struct sockaddr_in`
This structure is used in sockets for defining an endpoint address. It specifies the address family, IP address, and port for the socket.

```c
struct sockaddr_in {
    short            sin_family;   // e.g. AF_INET
    unsigned short   sin_port;     // e.g. htons(3490)
    struct in_addr   sin_addr;     // contains only one field, s_addr
    char             sin_zero[8];  // padding
};
```

## Socket Programming Explanation

### Understanding `server_addr` Configuration in Server Socket

The `server_addr` struct is configured in the following way in the server-side code to set up the socket endpoint.

#### `server_addr.sin_family = AF_INET;`

- **server_addr**: This is a struct of type `sockaddr_in`, often used in sockets for defining an endpoint address, in this case, for the server.
  
- **sin_family**: This is a field in the struct `sockaddr_in` that specifies the address family used by the socket.
  
- **AF_INET**: This constant represents the address family for IPv4.
  
Here, the code specifies that the server socket will operate over IPv4.

---

#### `server_addr.sin_port = SERVER_PORT;`

- **sin_port**: This is another field in the `sockaddr_in` struct that stores the port number.

- **SERVER_PORT**: This is a constant defined elsewhere in the code that specifies which port number to use.

Here, the code specifies that the server socket will listen for incoming connections on the port defined by `SERVER_PORT`.

---

#### `server_addr.sin_addr.s_addr = INADDR_ANY;`

- **sin_addr**: This is another struct embedded within `sockaddr_in` that holds the Internet address.

- **s_addr**: This field in the `in_addr` struct contains the IP address for the socket in Network Byte Order.

- **INADDR_ANY**: This is a constant representing any IP address.

Here, `INADDR_ANY` means that the server socket is willing to accept connections targeted at any of the available network interfaces. In other words, it listens to all interfaces rather than a specific one.

---

In summary, these three lines configure the `server_addr` struct to specify that:

1. The server should use IPv4 (`AF_INET`).
2. It should listen on a specific port (`SERVER_PORT`).
3. It should accept incoming connections on all network interfaces (`INADDR_ANY`).

---

## Understanding the `accept` Function in Socket Programming

The `accept` function is used on the server side to accept a new incoming connection from a client.

### Syntax of `accept`

The syntax of `accept` is generally as follows:

```c
int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
```

- `sockfd`: The original socket file descriptor that the server is using to listen for incoming connections.
- `addr`: A pointer to a `sockaddr` struct where information about the incoming client will be stored.
- `addrlen`: A pointer to a `socklen_t` variable that will be filled with the size of the `addr` structure.

### In Our Specific Code

In the code `comm_socket_fd = accept(master_sock_tcp_fd, (struct sockaddr *)&client_addr, &addr_len);`:

#### `comm_socket_fd`

- This is a new socket file descriptor returned by `accept` for the specific incoming client connection. All communication with this client should happen through this new descriptor, leaving the original (`master_sock_tcp_fd`) free to accept other incoming connections.

#### `master_sock_tcp_fd`

- This is the original socket file descriptor that the server is using to listen for incoming connections. It was probably created and bound to an address and port using `socket` and `bind`.

#### `(struct sockaddr *)&client_addr`

- **`client_addr`** is a variable of type `struct sockaddr_in` that will hold the **client's address** information. The `accept` function fills this structure with this info.

#### `&addr_len`

- `addr_len` is a variable of type `socklen_t`. `accept` will set its value to the size of the address stored in `client_addr`.

In summary, the `accept` function accepts an incoming client connection, creates a new socket for that client (`comm_socket_fd`), and retrieves the client's address information, storing it in `client_addr`.

---

### `inet_ntoa`
This function converts an (IPv4) Internet network address into an ASCII string in Internet standard dotted-decimal format.

```c
#include <arpa/inet.h>
char *inet_ntoa(struct in_addr in);
```

### `ntohs`
Stands for "Network To Host Short." This function converts a short (2-byte) value from network byte order to host byte order. Typically used with the `sin_port` member of the `sockaddr_in` structure.

```c
#include <netinet/in.h>
uint16_t ntohs(uint16_t netshort);
```
## Understanding the `recvfrom` Function in Socket Programming

The `recvfrom` function is commonly used in UDP server-client communication but can also be used in TCP. This function receives data from a socket whether or not it is connection-oriented.

### Syntax of `recvfrom`

Here's the general syntax of the `recvfrom` function:

```c
ssize_t recvfrom(int sockfd, void *buf, size_t len, int flags, struct sockaddr *src_addr, socklen_t *addrlen);
```

- `sockfd`: The socket file descriptor from which data is to be received.
- `buf`: The buffer to store the incoming data.
- `len`: The length in bytes of the buffer.
- `flags`: Optional flags (usually set to 0).
- `src_addr`: A pointer to a `sockaddr` structure that will be filled with the **source address of the received packet**
- `addrlen`: A pointer to a `socklen_t` variable that will be filled with the size of the `src_addr` structure.

### In Our Specific Code

In the specific line `sent_recv_bytes = recvfrom(comm_socket_fd, (char *)data_buffer, sizeof(data_buffer), 0, (struct sockaddr *)&client_addr, &addr_len);`:

#### `sent_recv_bytes`

- This variable will store the number of bytes actually received from the client.

#### `comm_socket_fd`

- This is the socket file descriptor returned by `accept` for the specific incoming client connection. All communication with this client should happen through this descriptor.

#### `(char *)data_buffer`

- `data_buffer` is the buffer where the incoming data will be stored.

#### `sizeof(data_buffer)`

- This represents the size of `data_buffer`, telling `recvfrom` how much data at most to read into the buffer.

#### `0`

- Flags are set to 0, meaning no special behavior is required.

#### `(struct sockaddr *)&client_addr`

- `client_addr` is a `struct sockaddr_in` variable that will hold the client's address information, filled by `recvfrom`.

#### `&addr_len`

- `addr_len` is of type `socklen_t` and holds the length of the client address structure.

### Additional Debugging Information

The line `printf("Server recvd %d bytes from client %s:%u\n", sent_recv_bytes, inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));` is used for debugging and information purposes. It prints:

- `sent_recv_bytes`: The number of bytes received from the client.
- **`inet_ntoa(client_addr.sin_addr)`**: The IP address of the client.
- **`ntohs(client_addr.sin_port)`**: The port number of the client, converted from network byte order to host byte order.


---

## 🤝 Contributing
Feel free to raise issues or submit pull requests. All contributions are welcome!

---

## 📜 License
This project is licensed under the MIT License. See `LICENSE` for more details.

---

🙌 Thanks for checking out MultiTCPServerSuite!
