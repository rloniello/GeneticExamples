//
//  main.swift
//  TruthSeekers
//
//  Created by Russell on 5/27/21.
//

import Foundation
// MARK: Step 1
import Genetics

// MARK: Step 1
// Define an object that conforms to Genetic.
// And an Enviroment that will support it.
var naturalEnviroment: NaturalEnvironment? = nil

// MARK: Step 3
// Define a Genetic Object, see ./Models/Seeker.swift

// MARK: Step 4
// Define your Genetic Operators as GeneticOperations.
// All Genetic Operations take an array of Genetic Objects and return nothing.
// Usually a Genetic Algorithm contains methods to:
// 1 - Calculate fitness
// 2 - Selection + Reproduction
// 3 - Mutation
// 4 - End Condition Check

let calculateFitness: GeneticOperation = { population in
    for (index, member) in population.enumerated() {
        var totalFitness:Double = 0.0
        for trait in member.chromosome {
            totalFitness += Double(trait.value as? Int ?? 0) / Double(Seeker.genome.count)
        }
        population[index].fitness = totalFitness
    }
}

// You can use a built-in methods for selection or define your own.
let selectionMethod: GeneticOperation = SelectionMethods.BasicTournamentSelection()

let mutationMethod: GeneticOperation = { population in
    for (index, _) in population.enumerated() {
        // Do something else before mutation.
        population[index].mutate()
    }
}

let pauseOperation: GeneticOperation = { population in
    population.sort(by: {$0.fitness > $1.fitness})
    guard let mostFit = population.first as? Seeker else  { return }
    // Update the UI or perform other tasks...
    print("Generation \(naturalEnviroment!.currentIteration)")
    print("Most Fit: \(mostFit.printChromosome()) : \(String(format: "%.3f",mostFit.fitness)) ")
    // like check to see if the GA has reach an optimal solution.
    if (mostFit.fitness >= 1.0) {
        naturalEnviroment?.stop()
    }
}

// MARK: Step 5
// Define a natural enviroment to run your operations on a population of your objects.
// By default, Populations will initalize with 1000 members with random chromosomes.
let operations = [calculateFitness, pauseOperation, selectionMethod, mutationMethod]
naturalEnviroment = NaturalEnvironment(for: Seeker.self, operations: operations)

// And Then Run..
naturalEnviroment?.start()
