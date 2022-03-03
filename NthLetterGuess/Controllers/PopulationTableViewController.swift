//
//  PopulationTableViewController.swift
//  NthLetterGuess
//
//  Created by Russell on 5/30/21.
//

import UIKit
import Genetics

class PopulationTableViewController: UITableViewController {

    var population: [Genetic] = [Genetic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return population.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "geneticCell", for: indexPath) as? GeneticTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(from: self.population[indexPath.row])
        
        return cell
    }

}

