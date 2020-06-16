//
//  InterfaceController.swift
//  NotesApp WatchKit Extension
//
//  Created by Sal B Amer on 6/16/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    //MARK: IBOutlets
    
    @IBOutlet var notesTable: WKInterfaceTable!
    
    var notes = [String]()
    
    //saved path for document directory with notes label in path
    var savePath = InterfaceController.getDocumentsDirectory().appendingPathComponent("notes")
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
                
        //Unarchive saved data and display array as string
//        notes = NSKeyedUnarchiver.unarchiveObject(withFile: savePath) as? [String] ?? [String]() -- DEPRICATED
        do { //updated for swift5
            let data = try Data(contentsOf: savePath)
            notes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] ?? [String]()
            print(self.savePath)
        } catch {
            // do nothing; notes is already an empty array
        }
        
        //similar to viewdidload
              notesTable.setNumberOfRows(notes.count, withRowType: "tableRow") // tableRow is identifier
        
        for rowIndex in 0 ..< notes.count {
            set(row: rowIndex, to: notes[rowIndex])
        }
    }
    
    func set(row rowIndex: Int, to text: String) {
        guard let row = notesTable.rowController(at: rowIndex) as? tableNotesCell else { return }
        row.tableNotesTextLbl.setText(text)
    }
    
    
    //MARK: IBActions

    @IBAction func addNewNoteBtnPressed() {
        
        //setup user dictation - request user input - [unowned self]  to avoid retaincycles
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { [unowned self] result in
            
            // convert the returned item into string else return
            guard let result = result?.first as? String else { return }
            
            //insert new row at the end of table
            self.notesTable.insertRows(at: IndexSet(integer: self.notes.count), withRowType: "tableRow")
            
            //give new row correct text
            self.set(row: self.notes.count, to: result)
            
            //append new note to existing array
            self.notes.append(result)
            
            // Key Archiver for not updated deprecated method 
//            NSKeyedArchiver.archiveRootObject(self.notes, toFile: self.savePath) // Depricated
//            print(self.savePath)
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: self.notes, requiringSecureCoding: false)
                try data.write(to: self.savePath)
                print(self.savePath)
            } catch {
                print("Failed to save data: \(error.localizedDescription).")
            }
        }
    }
    
    // similar to prepare for segue - pass data to detailview - send data
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        return ["index" : String(rowIndex + 1), "note" : notes[rowIndex]]
    }
    
    // Request Document directory
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    

}
