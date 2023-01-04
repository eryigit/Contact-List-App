

import UIKit

class EditPersonViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var editPersonNameTextField: UITextField!
    @IBOutlet weak var editPhoneNumberTextField: UITextField!
    
    var person: Members?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = person{
            editPersonNameTextField.text = p.person_name
            editPhoneNumberTextField.text = p.person_number
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if let p = person, let name = editPersonNameTextField.text, let number = editPhoneNumberTextField.text {
            p.person_number = number
            p.person_name = name
            appDelegate.saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
}
