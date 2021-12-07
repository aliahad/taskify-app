//
//  ProposalViewController.swift
//  taskify-app
//
//  Created by Niraj Sutariya
//

import UIKit

class ProposalViewController: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskNumOfHours: UILabel!
    @IBOutlet weak var taskHourRate: UILabel!
    @IBOutlet weak var taskLocation: UILabel!
    @IBOutlet weak var taskStartDate: UILabel!
    @IBOutlet weak var taskProposalFrom: UILabel!
    @IBOutlet weak var proposalDetails: UILabel!
    
    var task: Task?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func acceptProposal(_ sender: UIButton) {
        task?.status = "IN_PROGRESS"
        
        do {
            try context.save()
        } catch {
            print("Error while updating task")
        }
    }
    
    @IBAction func declineProposal(_ sender: UIButton) {
        task?.status = "CREATED"
        
        do {
            try context.save()
        } catch {
            print("Error while updating task")
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
