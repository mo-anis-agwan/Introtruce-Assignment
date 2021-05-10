//
//  UsersTableViewController.swift
//  Introtruce
//
//  Created by Anis on 10/05/21.
//

import UIKit
import XLPagerTabStrip
import FirebaseFirestoreSwift
import Firebase


class UsersTableViewController: UITableViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Users")
    }
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchUsers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if users.count > 0 {
            return users.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.UserCell, for: indexPath) as! UserTableViewCell

        // Configure the cell...
        let user = users[indexPath.row]
        cell.user = user
        cell.configure(user: user)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func fetchUsers() {
        
        db.collection(K.FStore.UsersCollection).order(by: K.User.createdDate, descending: true).addSnapshotListener { (querySnaphot, error) in
            self.users = []
            
            if let err = error {
                print(err.localizedDescription)
            } else {
                if let snapshotDocuments = querySnaphot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        let user = User(
                            uid: data[K.User.uid] as! String,
                            first_name: data[K.User.first_name] as! String,
                            last_name: data[K.User.last_name] as! String,
                            dob: data[K.User.dob] as! String,
                            gender: data[K.User.gender] as! String,
                            country: data[K.User.country] as! String,
                            state: data[K.User.state] as! String,
                            home_town: data[K.User.home_town] as! String,
                            phone_number: data[K.User.phone_number] as! String,
                            tel_number: data[K.User.tel_number] as! String,
                            profileLink: data[K.User.profileLink] as? String,
                            createdDate: data[K.User.createdDate] as? Date )
                        self.users.append(user)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
//        downloadAllUsersFromFirebase { (allFirebaseUsers) in
//
//            self.users = allFirebaseUsers
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

func downloadAllUsersFromFirebase(completion: @escaping (_ allUsers: [User]) -> Void ) {
    print("Downloading all users")
    var users: [User] = []
    
    db.collection(K.FStore.UsersCollection).limit(to: 500).getDocuments { (querySnapshot, error) in
        
        guard let document = querySnapshot?.documents else {
            print("no documents in all users")
            return
        }
        
        let allUsers = document.compactMap { (queryDocumentSnapshot) -> User? in
            return try? queryDocumentSnapshot.data(as: User.self)
        }

        for user in allUsers {
            print(user.first_name)
            users.append(user)
        }
        completion(users)
    }
}
