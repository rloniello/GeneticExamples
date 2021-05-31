//
//  GeneticTableViewCell.swift
//  NthLetterGuess
//
//  Created by Russell on 5/30/21.
//

import UIKit
import Genetics

class GeneticTableViewCell: UITableViewCell {
    @IBOutlet weak var chromosomeLabel: UILabel!
    @IBOutlet weak var fitnessLabel: UILabel!
    
    
    func configure(from member: Genetic) {
        self.chromosomeLabel.adjustsFontSizeToFitWidth = true
        self.chromosomeLabel.text = "\"\(member.chromosomeToString())\""
        self.fitnessLabel.text = String(format: "%.3f", member.fitness)
    }
}
