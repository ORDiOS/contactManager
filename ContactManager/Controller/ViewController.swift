//
//  ViewController.swift
//  ContactManager
//
//  Created by Oleksandr Revebtsov on 2022-06-04.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var contactsTableView: UITableView!
    private var names = [String]()
    private var sectionTitle = [String]()
    private var namesDict = [String: [String]]()
    
    private let jsonParser = JSONParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableActivityIndicator.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
  
        // check data in RealDB
        if DataBaseManager.shared.dataBaseIsEmpty() {
            loadData()
           
        } else {
            prepareDataForTableView()
            setSectionTitle()
            contactsTableView.reloadData()
        }
    }
}


extension ViewController {
    
    func loadData() {
        tableActivityIndicator.isHidden = false
        tableActivityIndicator.startAnimating()
        guard let url = URL(string: Constants.apiUrl) else { return }
        
        jsonParser.downloadData(of: ListofContacts.self, from: url) { (result) in
            switch result {
            case .failure(let error):
                if error is DataError {
                    print("DataError = \(error)")
                } else {
                    print(error.localizedDescription)
                }
            case .success(let jsonResult):
                DispatchQueue.main.async {
                    print(jsonResult)
                    DataBaseManager.shared.save(contacts: jsonResult.contacts)
                    self.prepareDataForTableView()
                    self.setSectionTitle()
                    self.contactsTableView.reloadData()
                    
                    self.tableActivityIndicator.isHidden = true
                    self.tableActivityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func prepareDataForTableView() {
        let dataFromDb = DataBaseManager.shared.getContacts()
        for result in dataFromDb {
            names.append(result.firstName ?? "")
        }
    }
    
    func setSectionTitle() {
        sectionTitle = Array(Set(names.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({namesDict[$0] = [String]()})
        names.forEach({namesDict[String($0.prefix(1))]?.append($0)})
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = namesDict[sectionTitle[indexPath.section]]?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    
}
