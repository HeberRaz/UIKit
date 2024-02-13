//
//  ViewController.swift
//  Semaphores
//
//  Created by Heber Alvarez on 12/02/24.
//

import UIKit

class SemaphoreViewController: UIViewController {
    let semaphore = DispatchSemaphore(value: Constant.maxCurrent)
    let downloadQueue = DispatchQueue(label: Constant.downloadQueue, qos: .background, attributes: .concurrent)
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func handleTapAction(_ sender: Any) {
        for i in 0..<15 {
            downloadQueue.async { [unowned self] in
                // Lock shared resource access
                semaphore.wait()

                // Expensive task
                self.download(i + 1)

                // Update UI on the main thread always
                DispatchQueue.main.async { [unowned self] in
                    self.tableView.reloadData()
                    // Release the lock
                    self.semaphore.signal()
                }

            }
        }
    }

    private func download(_ songId: Int) {
        var counter = 0
        // Simulate semi-random download items.
        for _ in 0..<Int.random(in: 999_999...10_000_000) {
            counter += songId
        }
    }

    struct Constant {
        static let maxCurrent = 3 // Or 1 if you want strictly ordered downloads!
        static let downloadQueue = "com.app.downloadQueue"
    }
}

