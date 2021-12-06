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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func fetchTaskData() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()

        do {
            self.taskList = try context.fetch(request)
            self.taskTableView.reloadData()
        } catch {
            print ("Error getting user")
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
        cell.taskDate.text = formatter.string(from: task.startTime!)
        
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
