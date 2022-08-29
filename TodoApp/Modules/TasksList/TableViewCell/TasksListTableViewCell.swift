//
//  TasksListTableViewCell.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 07/07/22.
//

import UIKit

class TasksListTableViewCell: UITableViewCell {
    @IBOutlet weak var taskName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func bindData(name : String?) {
        taskName.text = name
    }
}
