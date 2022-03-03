//
//  Seeker.swift
//  TruthSeekers
//
//  Created by Russell on 5/27/21.
//

import Genetics

struct Seeker: Genetic {
    var fitness: Double = 0.0
    
    var chromosome: [Trait] = []
    
    static var genome: [Gene] = [
        // This Gene will be false 2/3's of the time.
        Gene(named: "", alleles: [Trait(true), Trait(false), Trait(false)]),
        // Same with this one, but it is represented as an Int instead.
        Gene(named: "", alleles: [Trait(1), Trait(0), Trait(0)]),
        // Traits can also have a range of values,
        // but it is up to you to determine how to deal with them in GeneticOperations.
        Gene(named: "", alleles: [Trait(1.0), Trait(0.8), Trait(0.7), Trait(0.6)]),
        // The Gene List can be as long as you desire.
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        // Genes can also be calculated or generated.
        Seeker.generateEyeTrait()
    ]
    
    func reproduce(with other: Genetic) throws -> Seeker {
        let another = Seeker(chromosome: other.chromosome)
        return try self.revolvingRandomCrossover(with: another)
    }
    
    static func generateEyeTrait() -> Gene {
        Gene(named: "Has Eyes", alleles: [Trait(true), Trait(false)])
    }
    
    func printChromosome() -> String {
        var output = ""
        for trait in chromosome {
            if ((trait.value as? Bool ?? false) == true) {
                output += "1"
            } else {
                output += "0"
            }
        }
        return output
    }
}
