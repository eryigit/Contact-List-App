

import UIKit

class PersonDetailViewController: UIViewController {
    

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var person: Members?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = person{
            personNameLabel.text = p.person_name
            phoneNumberLabel.text = p.person_number
        }
       
    }
    



}
