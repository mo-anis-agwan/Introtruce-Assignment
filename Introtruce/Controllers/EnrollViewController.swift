//
//  EnrollViewController.swift
//  Introtruce
//
//  Created by Anis on 10/05/21.
//

import UIKit
import XLPagerTabStrip

class EnrollViewController: UIViewController, IndicatorInfoProvider {
    
    //MARK:- IBOutlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var homeTownField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var telNumberField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBActions
    @IBAction func addUserBtnPressed(_ sender: Any) {
        let user = User(uid: UUID().uuidString, first_name: firstNameField.text!, last_name: lastNameField.text!, dob: dobField.text!, gender: genderField.text!, country: countryField.text!, state: stateField.text!, home_town: homeTownField.text!, phone_number: phoneNumberField.text!, tel_number: telNumberField.text!, profileLink: "", createdDate: Date())
        
        print(user)
        if (!checkUserFirestore(user: user)) {
            saveUserFirestore(user: user)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Enroll")
    }
    
}
