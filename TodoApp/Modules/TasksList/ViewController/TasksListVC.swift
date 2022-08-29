//
//  ViewController.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//

import UIKit
import CoreData
class TasksListVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tasksListTableView: UITableView!
    @IBOutlet weak var emptyTableViewLabel: UILabel!
    // MARK: - Internal Properties
    let tasksListViewModel = TaskaListViewModel()
    private var datesAndTasks = [String : [Tasks]]()
    private var allTasks = [Tasks]()
    private var dates = [String]()
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksListTableView.delegate = self
        tasksListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        tasksListViewModel.loadTasks()
        (tasksListViewModel.tasksData.isEmpty) ? (emptyTableViewLabel.isHidden = false) : (emptyTableViewLabel.isHidden = true)
        setUpTableViewSections()
        self.tasksListTableView.reloadData()
    }
}
// MARK: - Custom Methods
private extension TasksListVC {
    // create dictionary that have dates and their respective tasks
    func setUpTableViewSections() {
        allTasks = tasksListViewModel.tasksData.sorted(by: {$0.taskDate ?? "" > $1.taskDate ?? ""})
        dates = Array(Set(tasksListViewModel.tasksData.compactMap({$0.taskDate})))
        CommonFunctions.sortDates(dates: &dates)
        dates.forEach({
            datesAndTasks[$0] = [Tasks]()
        })
        allTasks.forEach({
            datesAndTasks[$0.taskDate ?? ""]?.append($0)
        })
    }
}
// MARK: - IBActions
private extension TasksListVC {
    @IBAction func createButtonPressed(_ sender: UIBarButtonItem) {
        let controller = CreateTaskVC.instantiate(fromAppStoryboard: .main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - Table view Delegate and DataSource
extension TasksListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesAndTasks[dates[section]]?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (dates.isEmpty) ? 0 : dates.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !dates.isEmpty {
            return CommonFunctions.titleHeader(date: dates[section])
        }
        return String()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StringConstant.TableViewIdentifier.tasksListTableViewCell.rawValue, for: indexPath) as? TasksListTableViewCell else {return UITableViewCell()}
        cell.bindData(name: datesAndTasks[dates[indexPath.section]]?[indexPath.row].taskTitle)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = TaskDetailsVC.instantiate(fromAppStoryboard: .main)
        controller.id = datesAndTasks[dates[indexPath.section]]?[indexPath.row].taskId
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let index = tasksListViewModel.tasksData.firstIndex(where: {$0.taskId == datesAndTasks[dates[indexPath.section]]?[indexPath.row].taskId}){
                datesAndTasks.removeValue(forKey: tasksListViewModel.tasksData[index].taskDate ?? String())
                //tableView.deleteRows(at: [indexPath], with: .fade)
                if let first = dates.firstIndex(where: {$0 == tasksListViewModel.tasksData[index].taskDate}){
                    dates.remove(at: first)
                }
                let task = tasksListViewModel.tasksData[index]
                tasksListViewModel.delete(task)
                setUpTableViewSections()
            }
            tasksListTableView.reloadData()
        }
    }
}
