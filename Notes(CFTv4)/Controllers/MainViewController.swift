//
//  MainViewController.swift
//  Notes(CFTv4)
//
//  Created by Sergey Starchenkov on 19.03.2021.
//

import Foundation
import UIKit

class MainViewController: UITableViewController {
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserDefaults.standard.bool(forKey: "isFirstRun") {
            UserDefaults.standard.set(true, forKey: "isFirstRun")
            dataManager.loadDemoNote()
        }else {
            dataManager.loadNote()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getCountNote()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = dataManager.getNote(noteIndex: indexPath.row)
        cell.textLabel?.text = note.title
        return cell
    }

    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.delete(noteIndex: indexPath.row)
            dataManager.loadNote()
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    @IBAction func unwindSequeToMain (seque: UIStoryboardSegue) {
        let sVC = seque.source as! NewNoteViewController
        sVC.saveNote()
        dataManager.loadNote()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNotesDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let newNoteVC = segue.destination as! NewNoteViewController
            newNoteVC.selectedNote = dataManager.getNote(noteIndex: indexPath.row)
        }
    }
}
