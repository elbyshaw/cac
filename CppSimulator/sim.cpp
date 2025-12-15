#include <stdio.h>
#include <cstdlib>

// QUESTION: How to handle overflow?
// I just added a maximum possible input data value here
// but obviously that wouldn't occur

u_int32_t NUM_INPUTS = 4;
u_int32_t DATA_MAX = 16;

int main(int argc, char *argv[]) {
    //========== PRELIMINARY DATA ==============

    // sequence of inputs coming from the north
    u_int32_t north_values[NUM_INPUTS];
    // sequence of inputs coming from the west
    u_int32_t west_values[NUM_INPUTS];
    // sequence of outputs going to the south
    u_int32_t south_values[NUM_INPUTS];
    // sequence of outputs going to the east
    u_int32_t east_values[NUM_INPUTS];

    // Holds the stationary value in this systolic array
    // Corresponds to A[x][y] in the implementation in pptx
    // Gets loaded in during preliminary phase
    u_int32_t stationary_register; 

    
    //========== INPUTS & OUTPUTS ================
    
    // Input arriving from the north
    // Corresponds to C[x][y] in the implementation in pptx
    u_int32_t north_input;

    // Input arriving from the west
    // Corresponds to B[x][y] in the implementation in pptx
    u_int32_t west_input;


    // Output leaving to the south
    // Should equal the newly calculated C partial sum
    u_int32_t south_output;

    // Output leaving to the east
    // Should equal the B input from the west this cycle
    u_int32_t east_output;



    // ========= DATA ASSIGNMENT ============

    // Assigns random values to north inputs
    for (unsigned int i = 0; i < NUM_INPUTS; i++) {
        north_values[i] = rand() % DATA_MAX;
        west_values[i] = rand() % DATA_MAX;
    }

    // Assigns random value to the stationary data
    stationary_register = rand() % DATA_MAX;


    // ============ CALCULATIONS =============

    for (unsigned int i = 0; i < NUM_INPUTS; i++) {
        // Assigning for this cycle
        north_input = north_values[i];
        west_input = west_values[i];

        // Here we get the partial sum = A[x1][y1] * B[x2][y2]
        u_int32_t mult_result = (stationary_register * west_input);

        // Then combined partial sum = partial_sum + C[x3][y3]
        u_int32_t add_result = north_input + mult_result;

        south_output = add_result;
        east_output = west_input;

        south_values[i] = south_output;
        east_values[i] = east_output;
    }
    

    // ============ PRINTING RESULTS ==============

    // Prints input values
    printf("Input Values: \n");
    for (unsigned int i = 0; i < NUM_INPUTS; i++) {
        printf("Cycle: %d \t North Value: %d \t West Value: %d \n",
            i, north_values[i], west_values[i]);
        
    }
    printf("Stationary Value: %d \n", stationary_register);
    printf("\n \n");

    //Prints output values
    printf("Output Values: \n");
    for (unsigned int i = 0; i < NUM_INPUTS; i++) {
        printf("Cycle: %d \t South Value: %d \t East Value: %d \n",
            i, south_values[i], east_values[i]);
    }
}