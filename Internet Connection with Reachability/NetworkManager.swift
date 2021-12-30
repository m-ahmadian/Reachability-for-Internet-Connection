//
//  NetworkManager.swift
//  Internet Connection with Reachability
//
//  Created by Mehrdad Ahmadian on 2021-12-27.
//

import Foundation
import Reachability

class NetworkManager: NSObject {

    // MARK: - Properties
    var reachability: Reachability!
    static let sharedInstance = NetworkManager()

    // MARK: - Initializer
    override init() {
        super.init()
        // Initialize reachability
        reachability = try! Reachability()

        // Register an observer for the network status
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)

        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    // MARK: - Helper Methods
    @objc func networkStatusChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Reachable via Wifi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
        }
    }

    static func stopNotifier() -> Void {
        // Stop the network status notifier
        (NetworkManager.sharedInstance.reachability).stopNotifier()
    }

    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }

    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }

    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }

    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
}
