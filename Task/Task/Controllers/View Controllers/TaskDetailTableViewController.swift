//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Kristin Samuels  on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    var task: Task? {
        didSet {
            // this causes the app to crash. The viewDidLoad method handles this
            // updateViews()
        }
    }
    var dueDateValue: Date?
    
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateTask() 
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        view.resignFirstResponder()
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
    }
    @IBAction func datePickedValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dueDateTextField.inputView = dueDatePicker
        updateViews()
    }
    
    func updateViews() {
        guard let task = task else { return }
        nameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        notesTextView.text = task.notes
    }
    
    func updateTask() {
        guard let name = nameTextField.text else { return }
        let note = notesTextView.text
         
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: note, due: dueDateValue)
        } else {
            TaskController.shared.add(taskWithName: name, notes: note, due: dueDateValue)
        }
    }
}
