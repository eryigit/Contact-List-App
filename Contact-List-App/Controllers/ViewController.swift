
import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var personTableView: UITableView!
    
    var memberList = [Members]()
    override func viewDidLoad() {
        super.viewDidLoad()
        personTableView.dataSource = self
        personTableView.delegate = self
        searchBar.delegate = self
        navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllPerson()
        personTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! PersonDetailViewController
            detailVC.person = memberList[index!]
        }
        if segue.identifier == "toEditVC" {
            let editVC = segue.destination as! EditPersonViewController
            editVC.person = memberList[index!]
        }
    }
    func getAllPerson(){
        do{
            memberList = try context.fetch(Members.fetchRequest())
        }catch{
            printContent(error)
        }
    }
    func searchList(person_name:String){
        let fetchRequest:NSFetchRequest<Members> = Members.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "person_name CONTAINS %@", person_name)
        do {
            memberList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = memberList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! PersonTableViewCell
        cell.personDetailLabel.text = "\(person.person_name!) - \(person.person_number!)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let person = self.memberList[indexPath.row]
            self.context.delete(person)
            appDelegate.saveContext()
            self.getAllPerson()
            self.personTableView.reloadData()
            
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            self.performSegue(withIdentifier: "toEditVC", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction , editAction])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            getAllPerson()
        }else {
            searchList(person_name: searchText)
        }
        personTableView.reloadData()
    }
}

