//
//  PostsTableViewController.swift
//  Internet Connection with Reachability
//
//  Created by Mehrdad Ahmadian on 2021-12-27.
//

import Alamofire
import UIKit

class PostsTableViewController: UITableViewController {

    // MARK: - Properties
    var items: [Film] = []
    let network = NetworkManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Latest Films"
        tableView.delegate = self
        tableView.dataSource = self
        // Fetch the posts and reload the table
        fetchFilms()

        network.reachability.whenUnreachable = { _ in
            self.showOfflinePage()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Return the number of posts available
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.director
        return cell
    }
}

extension PostsTableViewController {

    func fetchFilms() {
        AF.request("https://swapi.dev/api/films")
            .validate()
            .responseDecodable(of: Films.self) { response in
                guard let films = response.value else { return }
                self.items = films.all
                self.tableView.reloadData()
            }
    }

    private func showOfflinePage() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
}
