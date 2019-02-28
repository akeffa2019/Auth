//
//  anomViewController.swift
//  authForApp
//
//  Created by Shaima on 09/06/1440 AH.
//  Copyright © 1440 Shaima. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class anomViewController: UIViewController {
    
    var idText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func anom(_ sender: Any) {
        
        Auth.auth().signInAnonymously { (user, error) in if let error = error { print("Sign in failed: ", error.localizedDescription) } else { print ("Signed in: ", user!.user.uid)
           // self.idText = user!.user.uid
             let uid = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            
     
            
            //-------
            let docRef =  db.collection("test").addDocument(data: ["Age": "20"])
            
         
               docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
            
            
            
            //--------
            
            
            db.collection("anom").document(uid).setData(["ID": uid, "Name": "Shaima", "Test Q": 10])
            
            
            
            }
            }
            
    }
        
       // let uid = Auth.auth().currentUser!.uid
      
    
}
    

    
    

