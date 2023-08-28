# MultiTCPServerClient
MultiTCPServerSuite: A robust TCP framework enabling efficient multiplexed server-client communications. Designed for high-concurrency scenarios, ensuring optimal data transfer with minimal latency. Ideal for applications demanding real-time interactions.



# 🔀 MultiTCPServerSuite

🌐 A robust TCP framework enabling efficient multiplexed server-client communications. Ideal for high-concurrency scenarios and applications demanding real-time interactions.

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
- Multiplexed communication.
- High concurrency handling.
- Low latency.

---

## 📥 Installation

```
git clone [repository-url](https://github.com/ANSANJAY/MultiTCPServerClient)
cd MultiTCPServerSuite
make
```

---

## 🚀 Usage

```
./server
./client <server-ip>
```

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

---

## 🤝 Contributing
Feel free to raise issues or submit pull requests. All contributions are welcome!

---

## 📜 License
This project is licensed under the MIT License. See `LICENSE` for more details.

---

🙌 Thanks for checking out MultiTCPServerSuite!
```
