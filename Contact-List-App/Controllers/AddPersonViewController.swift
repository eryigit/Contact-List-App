
import UIKit

class AddPersonViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    

    @IBAction func addButton(_ sender: Any) {
        if let name = personNameTextField.text, let phoneNumber = phoneNumberTextField.text {
            let person = Members(context: context)
            person.person_name = name
            person.person_number = phoneNumber
            appDelegate.saveContext()
            navigationController?.popViewController(animated: true)
        }
        
    }
    

}
