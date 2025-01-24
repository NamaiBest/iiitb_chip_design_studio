
/*
* EcoMender Bot (EB): Task 2B Path Planner
*
* This program computes the valid path from the start point to the end point.
* Make sure you don't change anything outside the "Add your code here" section.
*/

#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <limits.h>
// #define V 32

#ifdef __linux__ // for host pc

    #include <stdio.h>

    void _put_byte(char c) { putchar(c); }

    void _put_str(char *str) {
        while (*str) {
            _put_byte(*str++);
        }
    }

    void print_output(uint8_t num) {
        if (num == 0) {
            putchar('0'); // if the number is 0, directly print '0'
            _put_byte('\n');
            return;
        }

        if (num < 0) {
            putchar('-'); // print the negative sign for negative numbers
            num = -num;   // make the number positive for easier processing
        }

        // convert the integer to a string
        char buffer[20]; // assuming a 32-bit integer, the maximum number of digits is 10 (plus sign and null terminator)
        uint8_t index = 0;

        while (num > 0) {
            buffer[index++] = '0' + num % 10; // convert the last digit to its character representation
            num /= 10;                        // move to the next digit
        }
        // print the characters in reverse order (from right to left)
        while (index > 0) { putchar(buffer[--index]); }
        _put_byte('\n');
    }

    void _put_value(uint8_t val) { print_output(val); }

    void set_heuristic(uint8_t* parent_cost, uint8_t* parent_node,uint8_t* ptr,uint8_t* ptr1, uint8_t* i) {
        for (*i = 0;*i<35;(*i)++) {
            if(*(ptr+2*(*i)) == *parent_node && *(ptr1 + *(ptr+2*(*i)+1)) == 0xff) {
                *(ptr1 + *(ptr+2*(*i)+1)) = *parent_cost + 1;
            } else if (*(ptr+2*(*i)+1) == *parent_node && *(ptr1 + *(ptr+2*(*i))) == 0xff) {
                *(ptr1 + *(ptr+2*(*i))) = *parent_cost + 1;
            }
        }
    }

    void propagate_costs(uint8_t end_node, uint8_t* parent_cost,uint8_t* ptr,uint8_t* ptr1,uint8_t* i,uint8_t* j) {
            *(ptr1 + end_node) = *parent_cost;  
            while ((*parent_cost) != 50) {
                for(*j =0;*j<32;(*j)++){
                    if(*(ptr1 + *j)==*parent_cost) {
                        set_heuristic(parent_cost,j,ptr,ptr1,i);
                    }
                }
                (*parent_cost)++;
            }

        }

    void find_path(uint8_t start_node,uint8_t end_node,uint8_t* ptr,uint8_t* ptr1,uint8_t* ptr2, uint8_t* idx, uint8_t* next_node, uint8_t* i){
            *(ptr2 + *idx) = start_node;
            while(true) {
                if(start_node == end_node){
                    return;
                }
                *next_node = start_node;
                for(*i=0;*i<35;(*i)++) {
                    if(*(ptr+2*(*i)) == start_node) {
                        if(*(ptr1 + *(ptr+2*(*i)+1)) < *(ptr1 + *next_node)) {
                            *next_node = *(ptr+2*(*i)+1);
                        }
                    } else if(*(ptr+2*(*i)+1) == start_node) {
                        if(*(ptr1 + *(ptr+2*(*i))) < *(ptr1 + *next_node)) {
                            *next_node = *(ptr+2*(*i));
                        }
                    }
                }
                start_node = *next_node;
                (*idx)++;
                *(ptr2 + *idx) = start_node;
            }
        }



#else  // for the test device

    void _put_value(uint8_t val) { }
    void _put_str(char *str) { }

    void set_heuristic(uint8_t* parent_cost, uint8_t* parent_node,uint8_t* ptr,uint8_t* ptr1, uint8_t* i) {
        for (*i = 0;*i<35;(*i)++) {
            if(*(ptr+2*(*i)) == *parent_node && *(ptr1 + *(ptr+2*(*i)+1)) == 0xff) {
                *(ptr1 + *(ptr+2*(*i)+1)) = *parent_cost + 1;
            } else if (*(ptr+2*(*i)+1) == *parent_node && *(ptr1 + *(ptr+2*(*i))) == 0xff) {
                *(ptr1 + *(ptr+2*(*i))) = *parent_cost + 1;
            }
        }
    }

void propagate_costs(uint8_t end_node, uint8_t* parent_cost,uint8_t* ptr,uint8_t* ptr1,uint8_t* i,uint8_t* j) {
        *(ptr1 + end_node) = *parent_cost;  
        while ((*parent_cost) != 50) {
            for(*j =0;*j<32;(*j)++){
                if(*(ptr1 + *j)==*parent_cost) {
                    set_heuristic(parent_cost,j,ptr,ptr1,i);
                }
            }
            (*parent_cost)++;
        }

    }

void find_path(uint8_t start_node,uint8_t end_node,uint8_t* ptr,uint8_t* ptr1,uint8_t* ptr2, uint8_t* idx, uint8_t* next_node, uint8_t* i){
        *(ptr2 + *idx) = start_node;
        while(true) {
            if(start_node == end_node){
                return;
            }
            *next_node = start_node;
            for(*i=0;*i<35;(*i)++) {
                if(*(ptr+2*(*i)) == start_node) {
                    if(*(ptr1 + *(ptr+2*(*i)+1)) < *(ptr1 + *next_node)) {
                        *next_node = *(ptr+2*(*i)+1);
                    }
                } else if(*(ptr+2*(*i)+1) == start_node) {
                    if(*(ptr1 + *(ptr+2*(*i))) < *(ptr1 + *next_node)) {
                        *next_node = *(ptr+2*(*i));
                    }
                }
            }
            start_node = *next_node;
            (*idx)++;
            *(ptr2 + *idx) = start_node;
        }
    }

#endif



// main function
int main(int argc, char const *argv[]) {

    #ifdef __linux__

        const uint8_t START_POINT   = atoi(argv[1]);
        const uint8_t END_POINT     = atoi(argv[2]);
        uint8_t NODE_POINT          = 0;
        uint8_t CPU_DONE            = 0;

    #else
        // Address value of variables for RISC-V Implementation
        #define START_POINT         (* (volatile uint8_t * ) 0x02000000)
        #define END_POINT           (* (volatile uint8_t * ) 0x02000004)
        #define NODE_POINT          (* (volatile uint8_t * ) 0x02000008)
        #define CPU_DONE            (* (volatile uint8_t * ) 0x0200000c)

    #endif

    // array to store the planned path
    // uint8_t path_planned[32];
    // index to keep track of the path_planned array
    // uint8_t idx = 0;

    /* Functions Usage

    instead of using printf() function for debugging,
    use the below function calls to print a number, string or a newline

    for newline: _put_byte('\n');
    for string:  _put_str("your string here");
    for number:  _put_value(your_number_here);

    Examples:
            _put_value(START_POINT);
            _put_value(END_POINT);
            _put_str("Hello World!");
            _put_byte('\n');
    */

    // ############# Add your code here #############
    // prefer declaring variable like this
    #ifdef __linux__
    uint32_t graph[18];
    graph[0] = 0x07060806;
    graph[1] = 0x00060906;
    graph[2] = 0x0a000100;
    graph[3] = 0x02010b01;
    graph[4] = 0x04020302;
    graph[5] = 0x1a0a0502;
    graph[6] = 0x0b0a180a;
    graph[7] = 0x0c0b130b;
    graph[8] = 0x0e0c0d0c;
    graph[9] = 0x100e0f0e;
    graph[10] = 0x12101110;
    graph[11] = 0x14131312;
    graph[12] = 0x16151512;
    graph[13] = 0x18171715;
    graph[14] = 0x1e171918;
    graph[15] = 0x1c1e1f1e;
    graph[16] = 0x1a1c1d1c;
    graph[17] = 0xffff1b1a;
    uint32_t heuristic_cost[8];
    uint8_t* ptr = (uint8_t *)&graph[0];
    uint8_t* ptr1 = (uint8_t *)&heuristic_cost[0];
    uint32_t path_planned[8];
    uint8_t* ptr2 = (uint8_t *)&path_planned[0];
    uint8_t idx = 0;
    uint8_t i;
    uint8_t j;
    uint8_t next_node;
    uint8_t parent_cost = 0;
    for (i = 0;i<32;i++) {
        *(ptr1+i) = 0xff;
    }
    

    // propagate_costs(END_POINT,&parent_cost,graph,heuristic_cost,&flag,&i,&j,&nodeA,&nodeB);
    // find_path(START_POINT,END_POINT,graph,heuristic_cost,path_planned,&idx,&next_node,&nodeA,&nodeB,&i);
    propagate_costs(END_POINT,&parent_cost,ptr,ptr1,&i,&j);
    find_path(START_POINT,END_POINT,ptr,ptr1,ptr2,&idx,&next_node,&i);
        
    #else
        uint32_t *graph = (uint32_t *) 0x02000010;
        graph[0] = 0x07060806;
        graph[1] = 0x00060906;
        graph[2] = 0x0a000100;
        graph[3] = 0x02010b01;
        graph[4] = 0x04020302;
        graph[5] = 0x1a0a0502;
        graph[6] = 0x0b0a180a;
        graph[7] = 0x0c0b130b;
        graph[8] = 0x0e0c0d0c;
        graph[9] = 0x100e0f0e;
        graph[10] = 0x12101110;
        graph[11] = 0x14131312;
        graph[12] = 0x16151512;
        graph[13] = 0x18171715;
        graph[14] = 0x1e171918;
        graph[15] = 0x1c1e1f1e;
        graph[16] = 0x1a1c1d1c;
        graph[17] = 0xffff1b1a;
        uint32_t *heuristic_cost = (uint32_t *) 0x02000058;  
        heuristic_cost[0] = 0xffffffff;    
        heuristic_cost[1] = 0xffffffff;    
        heuristic_cost[2] = 0xffffffff;    
        heuristic_cost[3] = 0xffffffff;    
        heuristic_cost[4] = 0xffffffff;    
        heuristic_cost[5] = 0xffffffff;    
        heuristic_cost[6] = 0xffffffff;    
        heuristic_cost[7] = 0xffffffff;    
        uint32_t *path_planned = (uint32_t *) 0x02000078;
        path_planned[0] = 0x00000000;    
        path_planned[1] = 0x00000000;    
        path_planned[2] = 0x00000000;    
        path_planned[3] = 0x00000000;    
        path_planned[4] = 0x00000000;    
        path_planned[5] = 0x00000000;    
        path_planned[6] = 0x00000000;    
        path_planned[7] = 0x00000000;  
        uint8_t* idx = (uint8_t *) 0x02000098;
        *idx = 0;
        uint8_t* i = (uint8_t *) 0x0200009c;
        *i = 0;
        uint8_t* j = (uint8_t *) 0x020000a0;
        *j = 0;
        uint8_t* next_node = (uint8_t *) 0x020000a4;
        *next_node = 0;
        uint8_t* parent_cost = (uint8_t *) 0x020000a8;
        *parent_cost = 0;
        uint8_t* ptr = (uint8_t *)&graph[0];
        uint8_t* ptr1 = (uint8_t *)&heuristic_cost[0];
        uint8_t* ptr2 = (uint8_t *)&path_planned[0];
        // for (*i = 0;*i<32;(*i)++) {
        //     *(ptr1 + *i) = 0xff;
        // }
        // for (*i = 0;*i<32;(*i)++) {
        //     *(ptr2 + *i) = 0;
        // }

        propagate_costs(END_POINT,parent_cost,ptr,ptr1,i,j);
        find_path(START_POINT,END_POINT,ptr,ptr1,ptr2,idx,next_node,i);

        // propagate_costs(END_POINT,parent_cost,graph,heuristic_cost,i,j);
        // find_path(START_POINT,END_POINT,graph,heuristic_cost,path_planned,idx,next_node,i);
        


    #endif

    // ##############################################

    // the node values are written into data memory sequentially.
    for (*i = 0; *i <= *idx; (*i)++) {
        NODE_POINT = *(ptr2 + *i);
    }
    // Path Planning Computation Done Flag
    CPU_DONE = 1;

    #ifdef __linux__    // for host pc

        _put_str("######### Planned Path #########\n");
        for (int i = 0; i <= idx; i++) {
            _put_value(*(ptr2+i));
        }
        _put_str("################################\n");

    #endif

    return 0;
}

