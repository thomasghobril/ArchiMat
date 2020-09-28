#include <chrono>
#include <random>
#include <iostream>
#include <float.h>
#include <omp.h>


double sequentiel(double* A, double* B, double* S, unsigned long int size) {
    for (unsigned long int i = 0; i < size; i++) {
        S[i] = (A[i] + B[i])/2;
    }
    return S[4];
}

double parallele(double* A, double* B, double*S, unsigned long int size) {
    #pragma omp parallel for schedule(static)
        for (unsigned long int i = 0; i < size; i++) {
            S[i] = (A[i] + B[i])/2;
        }
    return S[4];
}

int main(int argc, char* argv[]) {
    
    /* initialize random seed: */
    srand (time(NULL));
    unsigned short int cores = atoi(argv[1]);
    
    int maxCores = omp_get_max_threads();
    std::cout << " Moyenne avec cache chaud " << cores <<":"<< maxCores << std::endl;
   
   for (auto cores =2; cores <= maxCores; cores+=2) {
       omp_set_num_threads(cores);

    for(unsigned long long size = 8192/8; size<(32*1024*1024)/8;size = size + std::max(1024, int(size*0.1))) {
        unsigned long long iter = 45;

    // Création des données de travail
    double * A,* B,* C,* S1,* S2, * A1,* B1,* A2,* B2;
    A1 = (double *) malloc(size * sizeof(double));
    B1 = (double *) malloc(size * sizeof(double));
    A2 = (double *) malloc(size * sizeof(double));
    B2 = (double *) malloc(size * sizeof(double));

    S1 = (double *) malloc(size * sizeof(double)); // Résultat Séquentiel
    S2 = (double *) malloc(size * sizeof(double)); // Résultat Parallèle


    for (unsigned long int i = 0; i < size; i++) {
        A1[i] = (double)(rand() % 360 - 180.0);
        B1[i] = (double)(rand() % 360 - 180.0);
        A2[i] = (double)(rand() % 360 - 180.0);
        B2[i] = (double)(rand() % 360 - 180.0);

    }

   
    auto result = 0.0f; //utilisé pour s'assurer que le compilateur nu supprime pas les données
    std::chrono::high_resolution_clock::time_point t0;
    std::chrono::high_resolution_clock::time_point t1;
    double min_duration = DBL_MAX;
    
    
    t0 = std::chrono::high_resolution_clock::now();
    for (auto it =0; it < iter; it++) {
        if (it%2==0) {A=A1;B=B1;} else {A=A2;B=B2;}
        result += sequentiel(A, B, S1, size);
    }
    t1 = std::chrono::high_resolution_clock::now();
    double seq_duration = std::chrono::duration<double>(t1-t0).count();
    seq_duration /= (size*iter);

 
        t0 = std::chrono::high_resolution_clock::now();
        for (auto it =0; it < iter; it++) {
            if (it%2==0) {A=A1;B=B1;} else {A=A2;B=B2;}
            result += parallele(A, B, S2, size);
        }
        t1 = std::chrono::high_resolution_clock::now();
        double par_duration = std::chrono::duration<double>(t1-t0).count();
        par_duration /= (size*iter);    
    
        std::cout << 8*size/1024 << " " << seq_duration << " " << par_duration << " ";
        std::cout << seq_duration/par_duration << " " << cores << " " << result << " " << std::endl;
    
    /*** Validation ***/
    bool valide = false;
    for (unsigned long int i = 0; i < size; i++) {
        if(S1[i] == S2[i]) {
            valide = true;
        }
        else {
            valide = false;
            break;
        }
    }

    // Libération de la mémoire : indispensable

    free(A1);
    free(B1);
    free(A2);
    free(B2);
    free(S1);
    free(S2);    
}
}
    return 0;
}
