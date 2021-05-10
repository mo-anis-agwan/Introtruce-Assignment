//
//  UserTableViewCell.swift
//  Introtruce
//
//  Created by Anis on 10/05/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var didDelete: () -> () = { }
    var user: User?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        print("delete at \(String(describing: user?.first_name))")
        DispatchQueue.main.async {
            self.deleteUser(self.user!)
        }
    }
    
    func configure(user: User) {
        userNameLabel.text = "\(user.first_name) \(user.last_name)"
        userDescriptionLabel.text = "\(user.gender) | \(user.dob) | \(user.home_town)"
    }
    
    func deleteUser(_ user: User) {
        db.collection(K.FStore.UsersCollection).document(user.phone_number).delete() {
            err in
            if let err = err {
                print("Error removing user, \(err.localizedDescription)")
            } else {
                print("document successfully removed")
            }
        }
    }
    
}
