//
//  ApplyTaskViewController.swift
//  taskify-app
//
//  Created by Ali Ahad
//

import UIKit

class ApplyTaskViewController: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskPostedBy: UILabel!
    @IBOutlet weak var taskNumOfHours: UILabel!
    @IBOutlet weak var taskHourRate: UILabel!
    @IBOutlet weak var taskStartDate: UILabel!
    
    @IBOutlet weak var proposalDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitProposal(_ sender: UIButton) {
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
