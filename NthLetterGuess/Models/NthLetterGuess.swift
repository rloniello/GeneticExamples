//
//  NthLetterGuess.swift
//  NthLetterGuess
//
//  Created by Russell on 5/30/21.
//

import Foundation
import Genetics

/// A Genetic Object with an N-number of character traits as Integers.
struct NthLetterObject: Genetic {
    
    static var genome: [Gene] = [Gene]()
    var fitness: Double = 0.0
    var chromosome: [Trait] = [Trait]()
    
    init() { }
    
    init(chromosome: [Trait]) {
        self.chromosome = chromosome
    }

    func reproduce(with other: Genetic) throws -> NthLetterObject {
        let another = NthLetterObject(chromosome: other.chromosome)
        return try self.revolvingRandomCrossover(with: another, proportion: 0.7, shouldDifferProportion: true)
    }
    

    static func setGenome(to length: UInt) {
        var genome = [Gene]()
        var alleles = [Trait]()
        // all characters a-z, A-Z, 0-9, and special characters as Int's
        // number of permutations for a ten letter object: 94! / (84) = 10^144
        // http://www.asciitable.com/
        for value in 32...126 {
            // Integers can be converted to Characters using Unicode.Scalar(_:)
            alleles.append(Trait(Character(Unicode.Scalar(value)!)))
        }

        for index in 0..<length {
            genome.append(Gene(named: "Trait - \(index + 1)", alleles: alleles))
        }

        NthLetterObject.genome = genome
    }
    
}
