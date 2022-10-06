//
//  ViewController.swift
//  FindDuplicatePhoneNumber
//
//  Created by Артур Агеев on 05.10.2022.
//
import Contacts
import ContactsUI
import UIKit


class ViewController: UIViewController, CNContactPickerDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var contactsInfo = [
        "All contacts",
                "Duplicate Names",
                "Duplicate Numbers",
                "No Name",
                "No Email",
                "No Number"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}
//MARK:- UITableView methods
extension ViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "infoVC", sender: self)
        
        
        print("tapped me")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contactsInfo[indexPath.row]
        
        return cell
    }
}
