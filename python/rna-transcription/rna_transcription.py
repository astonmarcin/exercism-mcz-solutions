translations = {
    "G": "C",
    "C": "G",
    "T": "A",
    "A": "U",
}

def to_rna(dna_strand):
    output = ""
    for nucleotide in dna_strand:
        output += translations[nucleotide]
    return output

