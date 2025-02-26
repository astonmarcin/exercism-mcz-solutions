#!/usr/bin/env bash

main() {
    rna=$1
    
    ## break RNA to codons
    codons=
    for (( i=0; i<${#rna}; i++ )); do
        char=${rna:$i:1}
        if (( i % 3 == 0 )); then
            codons+=" $char"
        else
            codons+="$char"
        fi
    done

    ## decode codons into proteins
    proteins=
    for codon in $codons; do
        case $codon in
            "AUG")
                proteins+="Methionine "
                ;;
            "UUU" | "UUC")
                proteins+="Phenylalanine "
                ;;
            "UUA" | "UUG")
                proteins+="Leucine "
                ;;
            "UCU" | "UCC" | "UCA" | "UCG")
                proteins+="Serine "
                ;;
            "UAU" | "UAC")
                proteins+="Tyrosine "
                ;;
            "UGU" | "UGC")
                proteins+="Cysteine "
                ;;
            "UGG")
                proteins+="Tryptophan "
                ;;
            "UAA" | "UAG" | "UGA")
                break
                ;;
            *)
                echo "Invalid codon"
                exit 1
                ;;
        esac
    done
    
    ## print an answer
    echo "${proteins%?}"
}

main "$@"