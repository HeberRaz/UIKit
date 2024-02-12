//
//  ViewController.swift
//  SerialQueues-MainThread
//
//  Created by Heber Alvarez on 12/02/24.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func UITestButtonAction(_ sender: Any) {
        print("--> Action")
    }
    
    @IBAction func handleTapAction(_ sender: Any) {
        compute()
    }

    private func compute() {
        var counter = 0
        for _ in 0...10_000_000 {
            counter += 1
        }
    }
}

