//
//  OfflineViewController.swift
//  Internet Connection with Reachability
//
//  Created by Mehrdad Ahmadian on 2021-12-27.
//

import UIKit

class OfflineViewController: UIViewController {

    // MARK: - Properties
    let network = NetworkManager.sharedInstance

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // If the network is reachable, show the main controller
        network.reachability.whenReachable = { _ in
            self.showMainController()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Helper Methods

    private func showMainController() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "MainController", sender: self)
        }
    }

}
