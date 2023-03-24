//
//  DetailViewController.swift
//  MVCDemo
//
//  Created by Balaganesh on 23/03/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "\(user.name)"
        addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city) - \(user.address.zipcode)."
    }
}
