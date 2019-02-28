//
//  signupViewController.swift
//  authForApp
//
//  Created by Shaima on 06/06/1440 AH.
//  Copyright © 1440 Shaima. All rights reserved.
//

import UIKit
import FirebaseAuth
//import FirebaseDatabase
import FirebaseFirestore

class signupViewController: UIViewController {
 
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupAction(_ sender: Any) {
        
        if name.text == "" && email.text == "" && password.text == "" && confirmPassword.text == "" {
            
            let alertController = UIAlertController(title: "Embty", message: "Please write all faild text!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else if self.password.text != self.confirmPassword.text {
                    let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                  //  let ref = Database.database().reference()
                   // let usersReference = ref.child("users")
                    let uid = Auth.auth().currentUser!.uid
                  //  let newUserReference = usersReference.child(uid)
                  //  newUserReference.setValue(["username": self.name.text!, "email": self.email.text!])
                  //  print("description: \(newUserReference.description())")
                    
                    //-----------------------------------
                    let db = Firestore.firestore()
                    
                    db.collection("info").document(uid).setData(["Name": self.name.text!, "Email": self.email.text!, "Password": self.password.text!])
                    
                    let docRef = db.collection("info").document(uid)
                    
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data: \(dataDescription)")
                        } else {
                            print("Document does not exist")
                        }
                    }
                    //---------------
                    
                    docRef.getDocument { (document, error) in
                        if let nameData = document.flatMap({
                            $0.data().flatMap({ (data) in
                                return self.name.text!
                            })
                        }) {
                            print("Name: \(nameData)")
                            
                        } else {
                            print("Document does not exist")
                        }
                    }

                    
                }
            })
            
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
