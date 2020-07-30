//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Todd Crandall on 7/29/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    //MARK: - Property
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    var dueDate: Date?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = datePicker
//        dueDate = task?.due
        
//        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func userTappedView(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        self.dueDateTextField.resignFirstResponder()
        self.notesTextField.resignFirstResponder()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let notes = notesTextField.text else { return }
        if let task = task {
            TaskController.sharedInstance.updateTaskWIth(task: task, name: name, notes: notes, due: datePicker.date)
        } else {
            TaskController.sharedInstance.createTaskWith(name: name, notes: notes, due: datePicker.date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDate = sender.date
        dueDateTextField.text = dueDate?.stringValue()
    }
    
    func updateViews() {
        guard let task = task else { return }
        nameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        notesTextField.text = task.notes
        datePicker.date = task.due ?? Date()
//        tableView.reloadData()
    }
}
