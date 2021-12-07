//
//  ProposalViewController.swift
//  taskify-app
//
//  Created by Niraj Sutariya
//

import UIKit
import CoreData

class ProposalViewController: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskNumOfHours: UILabel!
    @IBOutlet weak var taskHourRate: UILabel!
    @IBOutlet weak var taskLocation: UILabel!
    @IBOutlet weak var taskStartDate: UILabel!
    @IBOutlet weak var taskProposalFrom: UILabel!
    @IBOutlet weak var proposalDetails: UILabel!
    
    var taskProposal: TaskProposal?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let task = taskProposal?.task
        
        taskTitle.text = task?.title
        taskDescription.text = task?.description
        taskNumOfHours.text = String(Int16(task!.hours))
        taskHourRate.text = String(Int16(task!.ratePerHour))
        taskLocation.text = task?.location?.name
        taskProposalFrom.text = taskProposal?.tasker?.name
        taskStartDate.text = formatDate(date: (task?.startDate)!)
    }
    
    @IBAction func acceptProposal(_ sender: UIButton) {
        taskProposal?.status = "ACCEPTED"
        taskProposal?.task?.status = "IN_PROGRESS"
        taskProposal?.task?.tasker = taskProposal?.tasker
        
        do {
            try context.save()
        } catch {
            print("Error while updating task")
        }
    }
    
    @IBAction func declineProposal(_ sender: UIButton) {
        taskProposal?.status = "DECLINED"
        taskProposal?.task?.status = "CREATED"
        
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
