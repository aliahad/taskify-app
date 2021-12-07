//
//  CompleteTaskViewController.swift
//  taskify-app
//
//  Created by Ali Ahad
//

import UIKit

class CompleteTaskViewController: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskNumOfHours: UILabel!
    @IBOutlet weak var taskHourRate: UILabel!
    @IBOutlet weak var taskLocation: UILabel!
    @IBOutlet weak var taskStartDate: UILabel!
    @IBOutlet weak var tasker: UILabel!
    @IBOutlet weak var ratingControl: UISegmentedControl!
    @IBOutlet weak var feedback: UITextField!
    
    var task: Task? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitle.text = task?.title
        taskDescription.text = task?.description
        taskNumOfHours.text = String(Int16(task!.hours))
        taskHourRate.text = String(Int16(task!.ratePerHour))
        taskLocation.text = task?.location?.name
        taskStartDate.text = formatDate(date: (task?.startDate)!)
        tasker.text = task?.requester?.name
    }
    
    @IBAction func completeTask(_ sender: UIButton) {
        
        let rating = ratingControl.selectedSegmentIndex + 1
        
        let taskFeedback = TaskFeedback(context: context)
        taskFeedback.rating = Int16(rating)
        taskFeedback.review = feedback.text
        taskFeedback.date = Date()
        taskFeedback.task = task
        
        do {
            try context.save()
        } catch {
            print("Error while saving task feedback")
        }
        
        task?.status = "COMPLETED"
        
        do {
            try context.save()
        } catch {
            print("Error while updating task")
        }
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter.string(from: date)
    }
}
