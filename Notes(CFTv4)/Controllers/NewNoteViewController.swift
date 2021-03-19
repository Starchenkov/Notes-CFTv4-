//
//  NewNoteViewController.swift
//  Notes(CFTv4)
//
//  Created by Sergey Starchenkov on 19.03.2021.
//

import UIKit

class NewNoteViewController: UITableViewController {
    
    var selectedNote: Note?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }

    func saveNote() {
        if selectedNote != nil {
            selectedNote?.title = titleTextField.text!
            selectedNote?.text = textTextView.text
            dataManager.saveData()
        }else {
            dataManager.addNewNote(title: titleTextField.text!, text: textTextView.text)
        }
    }
    
    @IBAction func cancelButtonCation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupEditScreen() {
        if selectedNote != nil {
            titleTextField.text = selectedNote?.title
            textTextView.text = selectedNote?.text
            navigationItem.title = "Edit note"
            navigationItem.leftBarButtonItem = nil
            saveButton.isEnabled = true
        }
    }
}

// MARK: - TextField Delegate

extension NewNoteViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldChanged() {
        if titleTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        }else {
            saveButton.isEnabled = false
        }
    }
    
}
