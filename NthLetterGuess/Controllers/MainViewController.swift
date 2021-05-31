//
//  MainViewController.swift
//  NthLetterGuess
//
//  Created by Russell on 5/27/21.
//

import UIKit
import Genetics

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var naturalEnviroment: NaturalEnvironment? = nil
    
    // MARK: - Subviews
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var bestGuessLabel: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var viewPopulationButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Genetic Operations
    // (In order of execution)
    var fitnessCalculation: GeneticOperation = { _ in }
    
    lazy var pauseOperation: GeneticOperation = { population in
        // Pause execution.
        self.naturalEnviroment?.shouldContinue = false
        population.sort(by: {$0.fitness > $1.fitness})
        if (1.0 <= population[0].fitness) {
            // A fitness of 1.0 is found!
            self.proceedButton.setTitle("Clear", for: .normal)
        }
        let text = "\(population[0].chromosomeToString()) - Fitness: \(String(format: "%.3f",population[0].fitness))"
        self.updateUI(text)
    }
    
    let selectionMethod = SelectionMethods.BasicTournamentSelection()
    
    let mutationOperation: GeneticOperation = { population in
        guard var population = population as? [NthLetterObject] else {
            return
        }
    
        for (index, _) in population.enumerated() {
            do {
                try population[index].lamarckMutation(withRespectTo: population, limit: 2)
            } catch {
                population[index].mutate()
            }
        }
    }
    
    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.targetTextField.delegate = self
        self.bestGuessLabel.adjustsFontSizeToFitWidth = true
        self.resetButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "viewPopulation":
                if let populationTableViewController = segue.destination as? PopulationTableViewController {
                    self.naturalEnviroment?.population.sort(by: {$0.fitness > $1.fitness})
                    populationTableViewController.population = self.naturalEnviroment?.population ?? []
                }
            default:
                return
        }
    }
    
    // MARK: - Class Methods
    @IBAction func handleTapsOf(_ button: UIButton) {
        switch button {
            case proceedButton:
                if (proceedButton.title(for: .normal) == "Clear") {
                    self.resetUI()
                    return
                }
                self.proceedButton.isEnabled = false
                
                if (!(self.naturalEnviroment?.shouldContinue ?? true)) {
                    naturalEnviroment?.continue()
                } else {
                    if let targetText = targetTextField.text, targetText.count > 0 {
                        self.start(to: targetText)
                    }
                }
            case resetButton:
                self.resetUI()
            default:
                return
        }
    }
    
    func start(to target: String) {
        self.proceedButton.setTitle("Continue", for: .normal)
        
        self.fitnessCalculation = FitnessMethods.hammingDistance(to: target)
        NthLetterObject.setGenome(to: UInt(target.count))
        
        let operations = [fitnessCalculation, pauseOperation, selectionMethod, mutationOperation]
        self.naturalEnviroment = NaturalEnvironment(for: NthLetterObject.self, operations: operations)
        self.viewPopulationButton.isEnabled = true
        self.naturalEnviroment?.start()
    }
    
    private func updateUI(_ text: String) {
        DispatchQueue.main.async {
            self.bestGuessLabel.text = text
            self.generationLabel.text = "Generation: \(self.naturalEnviroment?.currentIteration ?? 0)"
            self.proceedButton.isEnabled = true
        }
    }
    
    private func resetUI() {
        DispatchQueue.main.async {
            self.targetTextField.text = ""
            self.bestGuessLabel.text = "Best Guess - Fitness: 0.0"
            self.generationLabel.text = "Generation: 0"
            self.proceedButton.isEnabled = false
            self.viewPopulationButton.isEnabled = false
            self.resetButton.isHidden = true
            self.resetButton.isEnabled = false
            self.proceedButton.setTitle("Start", for: .normal)
            self.naturalEnviroment = nil
            self.naturalEnviroment?.shouldContinue = true
        }
    }

    
}

// MARK: UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.proceedButton.isEnabled = (!(textField.text?.isEmpty ?? true)) ? true : false
        textField.resignFirstResponder()
        self.resetButton.isHidden = false
        self.resetButton.isEnabled = true
        return true
    }
    

}
