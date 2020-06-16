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
    
    @IBOutlet weak var notesTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //similar to viewdidload
        notesTable.setNumberOfRows(15, withRowType: "tableRow") // tableRow is identifier
        
        for rowIndex in 0 ..< 10 {
            guard let row = notesTable.rowController(at: rowIndex) as? tableNotesCell else { continue }
            row.tableNotesTextLbl.setText("Hello, row \(rowIndex)")
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK: IBActions

    @IBAction func addNewNoteBtnPressed() {
        
    }
}
