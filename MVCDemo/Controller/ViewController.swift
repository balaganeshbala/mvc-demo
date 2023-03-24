//
//  ViewController.swift
//  MVCDemo
//
//  Created by Balaganesh on 23/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAllUsers { [weak self] users in
            self?.users = users
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func fetchAllUsers(completion: @escaping ([User]) -> Void) {
        
        let url = "https://jsonplaceholder.typicode.com/users"
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let usersData = data else {
                completion([])
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: usersData)
                completion(users)
            } catch {
                print(error)
                completion([])
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") ?? UITableViewCell()
        cell.textLabel?.text = user.name
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = users[indexPath.item]
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.user = selectedUser
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
