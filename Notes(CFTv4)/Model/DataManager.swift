//
//  DataManager.swift
//  Notes(CFTv4)
//
//  Created by Sergey Starchenkov on 19.03.2021.
//

import UIKit
import CoreData

class DataManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var notesArray = [Note]()
    
    func loadDemoNote() {
        addNewNote(title: "Моя тестовая заметка", text: "Текст тестовой заметки")
        loadNote()
    }
    
    func addNewNote(title: String, text: String?) {
        let newNote = Note(context: context)
        newNote.title = title
        newNote.text = text
        saveData()
    }
    
    func loadNote() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do{
            notesArray = try context.fetch(request)
        }catch {
            print ("Error loadNote \(error)")
        }
    }
    
    func delete(noteIndex: Int) {
        context.delete(notesArray[noteIndex])
        saveData()
    }
    
    func getNote(noteIndex: Int) -> Note {
        return notesArray[noteIndex]
    }
    
    func getCountNote() -> Int {
        return notesArray.count
    }
    
   func saveData() {
        do {
            try context.save()
        }catch {
            print(error)
        }
    }
}
