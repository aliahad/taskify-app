//
//  AddTaskViewController.swift
//  taskify-app
//
//  Created by Sohail Shiraj.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDetail: UITextField!
    @IBOutlet weak var taskHours: UITextField!
    @IBOutlet weak var taskPayPerHour: UITextField!
    @IBOutlet weak var taskStartDate: UIDatePicker!
    @IBOutlet weak var taskTitleErrorLabel: UILabel!
    @IBOutlet weak var taskDetailErrorLabel: UILabel!
    @IBOutlet weak var taskHoursErrorLabel: UILabel!
    @IBOutlet weak var taskPayPerHourErrorLabel: UILabel!
    @IBOutlet weak var taskStartDateErrorLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        initialize();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initialize() {
        resetForm();
    }
    
    @IBAction func addTask(_ sender: Any) {
        if (validate()) {
            let task = Task(context: self.context)
            task.title = taskTitle.text
            task.detail = taskDetail.text
            task.hours = Int16(taskHours.text!)!
            task.ratePerHour = Int16(taskPayPerHour.text!)!
            task.startDate = taskStartDate.date ?? Date()
            task.creationDate = Date()
            task.status = "CREATED"
            //task.location = Location()
            //task.feeback = TaskFeedback()
            let user: User? = fetchUser()
            
            if(user != nil){
                task.requester = user
            }
            
            print("sohail")
            print(user)
            print(task)
            
            do {
                try context.save()
            } catch {
                print("Error whle saving user \(error)")
            }
        }
    
    }
    
    private func fetchUser() -> User? {
        let email = Configs.loggedInUserEmail
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "email == %@", email)

        var user: User
        do {
            let userList = try context.fetch(request)
            user = userList[0]
            return user
        } catch {
            print ("Error getting user")
            return nil
        }
    }
    
    private func resetForm() {
        taskTitle.text = ""
        taskDetail.text = ""
        taskHours.text = ""
        taskPayPerHour.text = ""
        
        resetErrors()
    }
    
    private func resetErrors() {
        taskDetailErrorLabel.text = ""
        taskDetailErrorLabel.isHidden = true
        
        taskTitleErrorLabel.text = ""
        taskTitleErrorLabel.isHidden = true
        
        taskHoursErrorLabel.text = ""
        taskHoursErrorLabel.isHidden = true
        
        taskPayPerHourErrorLabel.text = ""
        taskPayPerHourErrorLabel.isHidden = true
        
        taskStartDateErrorLabel.text = ""
        taskStartDateErrorLabel.isHidden = true
    }
    
    private func validate() -> Bool {
        resetErrors()
        
        var isValid = true;
        
        if (taskTitle.text == "") {
            taskTitleErrorLabel.text = "*Title is required"
            taskTitleErrorLabel.isHidden = false
            isValid = false
        }
        
        if (taskDetail.text == "") {
            taskDetailErrorLabel.text = "*Details are required"
            taskDetailErrorLabel.isHidden = false
            isValid = false
        }
        
        if (taskHours.text != "" && !ValidateHour()) {
            taskHoursErrorLabel.text = "*Invalid Hours"
            taskHoursErrorLabel.isHidden = false
            isValid = false
        }
        
        if (taskPayPerHour.text == "" && !ValidatePay()) {
            taskPayPerHourErrorLabel.text = "*Pay per hour is required"
            taskPayPerHourErrorLabel.isHidden = false
            isValid = false
        }
        
        return isValid
    }
    
    private func ValidateHour() -> Bool {
        let pattern = #"^\d+$"#
        
        let result = taskHours.text!.range(
            of: pattern,
            options: .regularExpression
        )
        
        return (result != nil)
    }
    
    private func ValidatePay() -> Bool {
        let pattern = #"^\d+$"#
        
        let result = taskPayPerHour.text!.range(
            of: pattern,
            options: .regularExpression
        )
        
        return (result != nil)
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
