//
//  ApplyTaskViewController.swift
//  taskify-app
//
//  Created by Ali Ahad
//

import UIKit
import CoreData

class ApplyTaskViewController: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskPostedBy: UILabel!
    @IBOutlet weak var taskNumOfHours: UILabel!
    @IBOutlet weak var taskHourRate: UILabel!
    @IBOutlet weak var taskStartDate: UILabel!
    @IBOutlet weak var taskLocation: UILabel!
    
    @IBOutlet weak var proposalDescription: UITextField!
    
    var task: Task? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitle.text = task?.title
        taskDescription.text = task?.description
        taskNumOfHours.text = String(Int16(task!.hours))
        taskHourRate.text = String(Int16(task!.ratePerHour))
        taskPostedBy.text = task?.requester?.name
        taskStartDate.text = formatDate(date: (task?.startDate)!)
    }
    
    @IBAction func submitProposal(_ sender: UIButton) {
        
        let taskProposal = TaskProposal(context: context)
        taskProposal.details = proposalDescription.text
        taskProposal.status = "PENDING"
        taskProposal.submissionDate = Date()
        
        taskProposal.task = task
        taskProposal.tasker = fetchUser()
        
        do {
            try context.save()
        } catch {
            print("Error while saving proposal")
        }
        
        task?.status = "PENDING"
        
        do {
            try context.save()
        } catch {
            print("Error while updating task")
        }
    }
    
    private func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "email == %@", Configs.loggedInUserEmail)
        
        do {
            let user = try context.fetch(request)
            return user[0]
        } catch {
            print("Error while getting user")
            return nil
        }
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter.string(from: date)
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
