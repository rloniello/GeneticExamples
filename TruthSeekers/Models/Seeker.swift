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
    ]
    
    func reproduce(with other: Genetic) throws -> Seeker {
        let another = Seeker(chromosome: other.chromosome)
        return try self.revolvingRandomCrossover(with: another)
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
