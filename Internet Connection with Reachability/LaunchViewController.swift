//
//  LaunchViewController.swift
//  Internet Connection with Reachability
//
//  Created by Mehrdad Ahmadian on 2021-12-27.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: - Properties
    let network: NetworkManager = NetworkManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }

        NetworkManager.isReachable { _ in
            self.showMainPage()
        }
    }

    // MARK: - Helper Methods
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }

    private func showMainPage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "MainController", sender: self)
        }
    }
}

