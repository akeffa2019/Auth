//
//  updateInfoViewController.swift
//  authForApp
//
//  Created by Shaima on 11/06/1440 AH.
//  Copyright © 1440 Shaima. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class updateInfoViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateInfo(_ sender: Any) {
        let uid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        
        db.collection("info").document(uid).updateData(["Name": self.name.text!, "Email": self.email.text!, "Password": self.password.text!
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
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

}
