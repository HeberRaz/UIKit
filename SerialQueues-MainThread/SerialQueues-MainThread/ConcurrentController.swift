//
//  ConcurrentController.swift
//  SerialQueues-MainThread
//
//  Created by Heber Alvarez on 12/02/24.
//

import UIKit

final class ConcurrentController: UIViewController {
    let queue = DispatchQueue(label: "com.app.concurrentQueue", attributes: .concurrent)
    let images = [UIImage](repeating: UIImage(), count: 5)

    private let controlButton: UIButton = {
        let button = UIButton()
        button.setTitle("Control Button", for: .normal)
        return button
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Heavy task", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addControlButton()
        addButton()
    }

    private func addControlButton() {
        controlButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlButton)
        NSLayoutConstraint.activate([
            controlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controlButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -56),
            controlButton.heightAnchor.constraint(equalToConstant: 48),
            controlButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
        controlButton.backgroundColor = .systemGreen
        controlButton.addTarget(self, action: #selector(handleControlButtonTapAction), for: .touchUpInside)
    }

    private func addButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleTapAction), for: .touchUpInside)
    }

    @objc private func handleTapAction() {
        for image in images {
            queue.async { [unowned self] in
                self.compute(image)
            }
        }
    }

    @objc private func handleControlButtonTapAction() {
        print("Control button tapped")
    }

    private func compute(_ image: UIImage) {
        var counter = 0
        for _ in 0...20_000_000 {
            counter += 1
        }
    }
}
