//
//  EditProfileViewController.swift
//  taskify-app
//
//  Created by Jignesh Kumavat.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userContact: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        fetchUserData()
    }
    
    private func fetchUserData() {
        let email = Configs.loggedInUserEmail
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "email == %@", email)

        do {
            let user = try context.fetch(request)
            populateData(user: user[0])
        } catch {
            print ("Error getting user")
        }
        
    }
    
    private func populateData(user: User) {
        if(user != nil){
            userName.text = user.name
            userEmail.text = user.email
            userContact.text = user.contact
            userPassword.text = user.password
        }
        
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        let email = Configs.loggedInUserEmail
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let user = try context.fetch(request)
            let objUpdate = user[0] as! NSManagedObject
            objUpdate.setValue(userName.text, forKey: "name")
            objUpdate.setValue(userEmail.text, forKey: "email")
            objUpdate.setValue(userContact.text, forKey: "contact")
            objUpdate.setValue(userPassword.text, forKey: "password")
            try context.save()
        } catch {
            print ("Error while saving")
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
