//
//  RequesterTaskViewController.swift
//  taskify-app
//
//  Created by Sohail Shiraj.
//

import UIKit
import CoreData

class RequesterTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var taskFilterControl: UISegmentedControl!
    
    var taskList: [Task] = [];
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RequesterTaskViewCell", bundle: nil)
        taskTableView.register(nib, forCellReuseIdentifier: "RequesterTaskViewCell")
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        fetchTaskData()
    }
    
    private func fetchTaskData(status: String? = nil) {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        if (status != nil) {
            request.predicate = NSPredicate(format: "status == %@", status!)
        }
        
        do {
            self.taskList = try context.fetch(request)
            self.taskTableView.reloadData()
        } catch {
            print ("Error getting user")
        }
        
    }
    
    @IBAction func taskFilterChanged(_ sender: UISegmentedControl) {
        let selectedIndex = taskFilterControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            fetchTaskData()
        case 1:
            fetchTaskData(status: "CREATED")
        case 2:
            fetchTaskData(status: "IN_PROGRESS")
        case 3:
            fetchTaskData(status: "COMPLETED")
        default:
            fetchTaskData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "RequesterTaskViewCell",
                                                     for: indexPath) as! RequesterTaskViewCell
        
        //GetData and place it in xib file
        
        let task = self.taskList[indexPath.row]
        cell.taskTitle.text = task.title
        cell.taskDescription.text = task.detail
        cell.taskHourRate.text = String(task.ratePerHour)
        cell.taskNumOfHours.text = String(task.hours)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        cell.taskDate.text = formatter.string(from: task.startDate!)
        
        //add styling
        self.taskTableView.rowHeight = 85.0
        return cell
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
