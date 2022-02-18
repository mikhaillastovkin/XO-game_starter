//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Михаил Ластовкин on 14.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var segmenControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toGameViewController",
              let destination = segue.destination as? GameViewController
        else { return }
        destination.state = selectState()
    }


    func selectState() -> State {
        switch segmenControl.selectedSegmentIndex {
        case 0:
            return .human
        case 1:
            return .computer
        case 2:
            return .fiveToFive
        default:
            return .human
        }
    }

    @IBAction func pressStartButton(_ sender: Any) {
        performSegue(withIdentifier: "toGameViewController", sender: self)
    }
}
