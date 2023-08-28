typedef struct _test_struct{
    
    unsigned int a;
    unsigned int b;
} test_struct_t;


typedef struct result_struct_{

    unsigned int c;

} result_struct_t;

test_struct_t test_struct;
result_struct_t res_struct; // tcpserver

test_struct_t client_data;
result_struct_t result; // tcpclient