//
//  InfoVC.swift
//  FindDuplicatePhoneNumber
//
//  Created by Артур Агеев on 06.10.2022.
//

import UIKit
import Contacts


//MARK:- Public
class InfoVC: UIViewController {
   
    var contacts = [FetchedContact]()
    
    @IBOutlet var tableViewInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
//        tableViewInfo.delegate = self
//        tableViewInfo.dataSource = self
    }
    private func fetchContacts() {
        print("Attempting to fetch contacts")
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            
            if granted {
                print("access granted")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        print(contact.givenName)
                        self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
    //MARK:- Find Duplicates Contacts In Given Contacts Array
    func findDuplicateContacts(Contacts contacts : [CNContact], completionHandler : @escaping (_ result : [Array<CNContact>]) -> ()){
        let arrfullNames : [String?] = contacts.map{CNContactFormatter.string(from: $0, style: .fullName)}
        var contactGroupedByDuplicated : [Array<CNContact>] = [Array<CNContact>]()
        if let fullNames : [String] = arrfullNames as? [String]{
            let uniqueArray = Array(Set(fullNames))
            var contactGroupedByUnique = [Array<CNContact>]()
            for fullName in uniqueArray {
                let group = contacts.filter {
                    CNContactFormatter.string(from: $0, style: .fullName) == fullName
                }
                contactGroupedByUnique.append(group)
            }
            for items in contactGroupedByUnique{
                if items.count > 1 {
                    contactGroupedByDuplicated.append(items)
                }
            }
        }
        completionHandler(contactGroupedByDuplicated)
    }
    
    // MARK: - Table view data source
       func numberOfSections(in tableView: UITableView) -> Int {
          // return the number of sections
          return 1
      }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // return the number of rows
          return contacts.count
      }

       func tableView(_ tableViewInfo: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableViewInfo.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

          // Configure the cell...
          cell.textLabel?.text = contacts[indexPath.row].firstName + " " + contacts[indexPath.row].lastName
          cell.detailTextLabel?.text = contacts[indexPath.row].telephone
          
          return cell
      }
    
}
    
