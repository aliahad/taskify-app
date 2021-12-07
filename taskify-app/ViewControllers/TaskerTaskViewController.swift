//
//  TaskerTaskViewController.swift
//  taskify-app
//
//  Created by Ali Ahad
//

import UIKit
import CoreData

class TaskerTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskFilterControl: UISegmentedControl!
    @IBOutlet weak var taskTableView: UITableView!
    
    var taskList: [Task] = [];
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TaskerTaskViewCell", bundle: nil)
        taskTableView.register(nib, forCellReuseIdentifier: "TaskerTaskViewCell")
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        fetchTaskData(status: "CREATED")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTaskData(status: "CREATED")
    }
    
    private func fetchTaskData(status: String? = nil, useEmail: Bool = false) {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        if (status != nil && useEmail) {
            request.predicate = NSPredicate(format: "status == %@ AND tasker.email == %@", status!, Configs.loggedInUserEmail)
        } else if (status != nil) {
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
            fetchTaskData(status: "CREATED")
        case 1:
            fetchTaskData(status: "PENDING")
        case 2:
            fetchTaskData(status: "IN_PROGRESS", useEmail: true)
        case 3:
            fetchTaskData(status: "COMPLETED", useEmail: true)
        default:
            fetchTaskData(status: "CREATED")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskerTaskViewCell",
                                                     for: indexPath) as! TaskerTaskViewCell
        
        //GetData and place it in xib file
        
        let task = self.taskList[indexPath.row]
        
        cell.taskTitle.text = task.title
        cell.taskDescription.text = task.detail
        cell.taskHourRate.text = String(task.ratePerHour)
        cell.taskNumOfHours.text = String(task.hours)
        cell.taskPostedBy.text = "Posted by \(task.requester?.name)"
        cell.taskLocation.text = task.location?.city
        cell.taskDate.text = formatDate(date: task.startDate!)
        
        //add styling
        self.taskTableView.rowHeight = 90.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.taskList[indexPath.row].status == "CREATED") {
            if let viewController = storyboard?.instantiateViewController(identifier: "ApplyTaskViewController") as?
                ApplyTaskViewController{
                    viewController.task = self.taskList[indexPath.row]
                
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
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
