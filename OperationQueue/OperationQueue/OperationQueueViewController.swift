//
//  OperationQueueViewController.swift
//  OperationQueue
//
//  Created by Heber Alvarez on 13/02/24.
//

/*
 GCD is greate when we want to dispatch one-off tasks or closures into a queue in an 'set-it-and-forget-it' fashion, and it provides a very lightweight way of doing so.
 But what if we want to create a repeatable, structured, long-running task that produces associated state or data?, And what if we want to model this chain of operations such that they can be cancelled, suspended and tracked, while still working with a closure-friendly API?

 This would be quite cumbersome to achieve with GCD. We want a more modular way of defining a group of tasks while maintaining readability and also exposing a greater amount of control. In this case, we can use Operation obects and queue them onto an OperationQueue, which is a high-level wrapper around DispatchQueue.

 We may want to create dependencies between tasks and we can define them concretly as Operation objects, or units of work, and pushing them onto our own queue.

 The Operation and OperationQueue have a number of properties that can be observed, using KVO, this way we can monitor the state of our Operation or OperationQueue.

 Operations can be paused, resumed and cancelled. Once we dispatch a task using GCD, we no longer have control or insight into the execution of that task. The Operation API is more flexible in that respect, giving the developer control over operation's life cycle.

 OperationQueue allows us to specify the maximum number of queued operations that can run simultaneously, giving us a finer degree of control over the concurrency aspects.
 Reference: https://www.viget.com/articles/concurrency-multithreading-in-ios/
 */

import UIKit

class OperationQueueViewController: UIViewController {
    var queue = OperationQueue()
    var rawImage: UIImage? = nil
    @IBOutlet weak var imageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        let filterOperation = getFilterOperation()
        let downloadOperation = getDownloadOperation()
        filterOperation.addDependency(downloadOperation)
        [downloadOperation, filterOperation].forEach({ queue.addOperation($0) })

        // Do any additional setup after loading the view.
    }

    func getDownloadOperation() -> BlockOperation {
        let image = Downloader.downloadImage(from: Constant.imageUrl)
        let blockOperation = BlockOperation {
            OperationQueue.main.addOperation { [weak self] in
                self?.rawImage = image
            }
        }
        return blockOperation
    }

    func getFilterOperation() -> BlockOperation {
        let filteredImage = ImageProcessor.addGaussianBlur(self.rawImage)
        let blockOperation = BlockOperation {
            OperationQueue.main.addOperation {
                self.imageView.image = filteredImage
            }
        }
        return blockOperation
    }

    struct Constant {
        static let imageUrl = URL(string: "https://example.com/portrait.jpg")!
    }
}

