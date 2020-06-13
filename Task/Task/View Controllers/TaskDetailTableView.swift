//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Kristin Samuels  on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var task: Task?
    var dueDateValue: Date?

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dueDateTextField: UITextField!
    @IBOutlet var notesTextField: UITextView!

    @IBOutlet var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateViews()
    }

    /// come back to and try and clean up messy code
    @IBAction func saveButtonTapped(_ sender: Any) {
//        if let task = task,
//            let name = nameTextField.text, !name.isEmpty,
//            let notes = notesTextField.text, !notes.isEmpty,
//            let dueDate = dueDateValue {
//            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDate)
//        } else {
//            let name = nameTextField.text ?? "task"
//            let notes = notesTextField.text
//            let dueDate = dueDateValue
//            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDate)
        guard let name = nameTextField.text, !name.isEmpty,
            let notes = notesTextField.text, !notes.isEmpty else {return}

        let dueDate = dueDateValue
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDate)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDate)
        }
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }

    @IBAction func userTappedVIew(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        dueDatePicker.resignFirstResponder()
    }

    func updateViews() {
        guard let task = task else {return}
        nameTextField.text = task.name
        notesTextField.text = task.notes
        dueDateTextField.text = task.due?.stringValue()
        tableView.reloadData()

    }

}
