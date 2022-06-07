//
//  ViewController.swift
//  ContactManager
//
//  Created by Oleksandr Revebtsov on 2022-06-04.
//

import UIKit

class ViewController: UIViewController {
    var names = [String]()
    var sectionTitle = [String]()
    var namesDict = [String: [String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        names = ["Alexandra",  "Alison",  "Amanda",  "Amelia",  "Amy",  "Andrea",  "Angela",  "Anna",  "Anne",  "Audrey",  "Ava",  "Bella",  "Bernadette",  "Carol",  "Caroline",  "Carolyn",  "Chloe",  "Claire",  "Deirdre",  "Diana",  "Diane",  "Donna",  "Dorothy",  "Elizabeth",  "Ella",  "Emily",  "Emma",  "Faith",  "Felicity",  "Fiona",  "Gabrielle",  "Grace",  "Hannah",  "Heather",  "Irene",  "Jan",  "Jane",  "Jasmine",  "Jennifer",  "Jessica",  "Joan",  "Joanne",  "Julia",  "Karen",  "Katherine",  "Kimberly",  "Kylie",  "Lauren",  "Leah",  "Lillian",  "Lily",  "Lisa",  "Madeleine",  "Maria",  "Mary",  "Megan",  "Melanie",  "Michelle",  "Molly",  "Natalie",  "Nicola",  "Olivia",  "Penelope",  "Pippa",  "Rachel",  "Rebecca",  "Rose",  "Ruth",  "Sally",  "Samantha",  "Sarah",  "Sonia",  "Sophie",  "Stephanie",  "Sue",  "Theresa",  "Tracey",  "Una",  "Vanessa",  "Victoria",  "Virginia",  "Wanda",  "Wendy",  "Yvonne",  "Zoe",  "Adam",  "Adrian",  "Alan",  "Alexander",  "Andrew",  "Anthony",  "Austin",  "Benjamin",  "Blake",  "Boris",  "Brandon",  "Brian",  "Cameron",  "Carl",  "Charles",  "Christian",  "Christopher",  "Colin",  "Connor",  "Dan",  "David",  "Dominic",  "Dylan",  "Edward",  "Eric",  "Evan",  "Frank",  "Gavin",  "Gordon",  "Harry",  "Ian",  "Isaac",  "Jack",  "Jacob",  "Jake",  "James",  "Jason",  "Joe",  "John",  "Jonathan",  "Joseph",  "Joshua",  "Julian",  "Justin",  "Keith",  "Kevin",  "Leonard",  "Liam",  "Lucas",  "Luke",  "Matt",  "Max",  "Michael",  "Nathan",  "Neil",  "Nicholas",  "Oliver",  "Owen",  "Paul",  "Peter",  "Phil",  "Piers",  "Richard",  "Robert"
        ]
        sectionTitle = Array(Set(names.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({namesDict[$0] = [String]()})
        names.forEach({namesDict[String($0.prefix(1))]?.append($0)})
        
    }
}
extension ViewController: UITableViewDelegate {
    
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

