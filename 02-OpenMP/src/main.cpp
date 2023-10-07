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

double sequentiel2(double* A, double* B, double* S, unsigned long int size) {
    double sum=0;
    for (unsigned long int i = 0; i < size; i++) {
        sum += A[i]*B[i];
    }
    return sum;
}

double parallele(double* A, double* B, double*S, unsigned long int size) {
    #pragma omp parallel for schedule(static)
        for (unsigned long int i = 0; i < size; i++) {
            S[i] = (A[i] + B[i])/2;
        }
    return S[4];
}

double parallele2(double* A, double* B, double* S, unsigned long int size) {
    #pragma omp parallel for schedule(static)
        for (unsigned long int i = 0; i < size; i++) {
            S[i] = A[i] * B[i];
        }
    double sum=0;
    #pragma omp parallel for reduction(+:sum)
    for(unsigned long int i = 0; i < size; i++) {
        sum += S[i];
    }
    return sum;
}

double parallele2nored(double* A, double* B, double* S, unsigned long int size) {
    #pragma omp parallel for schedule(static)
        for (unsigned long int i = 0; i < size; i++) {
            S[i] = A[i] * B[i];
        }
    double sum=0;
    int n=omp_get_num_threads();
    #pragma omp parallel for lastprivate(sum)
    for (int k=0; k<n; k++) {
        int ssum=0;
        for(unsigned long int i = k*size/n; i < size; i++) {
            ssum += S[i];
        }
        #pragma omp atomic
        sum+=ssum;
    }
    return sum;
}

int main() {
    
    /* initialize random seed: */
    srand (time(NULL));
    unsigned short int cores = 16; // au cas ou
    
    int maxCores = omp_get_max_threads();

    std::cout << " Moyenne avec cache chaud " << cores <<":"<< maxCores << std::endl;
    
    double * seq_duration;
    seq_duration = (double *) malloc((32*1024*1024/8192) * sizeof(double)); 
    long int size_iterator = 0;
    for (auto cores =2; cores <= maxCores; cores+=2) {
        omp_set_num_threads(cores);
        size_iterator = -1;

        for(unsigned long long size = 8192/sizeof(double); size<(32*1024*1024)/sizeof(double);size = size + std::max(1024, int(size*0.1))) {
            size_iterator += 1;
            unsigned long long iter = 45;

            // Création des données de travail
            double * A,* B, * S1,* S2;
            A = (double *) malloc(size * sizeof(double));
            B = (double *) malloc(size * sizeof(double));

            S1 = (double *) malloc(size * sizeof(double)); // Résultat Séquentiel
            S2 = (double *) malloc(size * sizeof(double)); // Résultat Parallèle

            double s1 = 0;
            double s2 = 0;

            for (unsigned long int i = 0; i < size; i++) {
                A[i] = (double)(rand() % 360 - 180.0);
                B[i] = (double)(rand() % 360 - 180.0);
            }
        
            auto result = 0.0f; //utilisé pour s'assurer que le compilateur nu supprime pas les données
            std::chrono::high_resolution_clock::time_point t0;
            std::chrono::high_resolution_clock::time_point t1;
            double min_duration = DBL_MAX;
            
            seq_duration[size_iterator] = 12345.6789;
            for (auto it =0; it < iter; it++) {
                t0 = std::chrono::high_resolution_clock::now();
                s1 = sequentiel2(A, B, S1, size);
                result += s1;
                t1 = std::chrono::high_resolution_clock::now();
                seq_duration[size_iterator] = std::min(seq_duration[size_iterator],std::chrono::duration<double>(t1-t0).count());
            }
            seq_duration[size_iterator] = seq_duration[size_iterator]/(size);

            double par_duration = 12345.6789;
            for (auto it =0; it < iter; it++) {
                t0 = std::chrono::high_resolution_clock::now();
                s2 = parallele2(A, B, S1, size);
                result += s2;
                t1 = std::chrono::high_resolution_clock::now();
                par_duration = std::min(par_duration,std::chrono::duration<double>(t1-t0).count());
            }
            par_duration = par_duration/(size);

            std::cout << 8*size/1024 << " " << seq_duration[size_iterator] << " " << par_duration << " ";
            std::cout << seq_duration[size_iterator]/par_duration << " " << cores << " " << result << " " << std::endl;
            
            /*** Validation ***/
            bool valide = false;
            for (unsigned long int i = 0; i < size; i++) {
                if(s1 == s2) {
                    valide = true;
                }
                else {
                    valide = false;
                    break;
                }
            }
            std::cerr << valide << " " << cores << ",";

            // Libération de la mémoire : indispensable
            free(A);
            free(B);

            free(S1);
            free(S2);    
        }
    }
    free(seq_duration);
    return 0;
}
