//
//  ViewController.swift
//  FindDuplicatePhoneNumber
//
//  Created by Артур Агеев on 05.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    let names = [
        "Jon",
        "Dick",
        "Rich",
        "Duck",
        "Smooya"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped me")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
}
