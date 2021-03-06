//
//  DetailInterfaceController.swift
//  NotesApp WatchKit Extension
//
//  Created by Sal B Amer on 6/16/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    //MARK: IBOUtlet
    @IBOutlet weak var noteDetailsLabel: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // recieve data from mainVC
        if let contextDictionary = context as? [String : String] {
            noteDetailsLabel.setText(contextDictionary["note"] ?? "")
            let index = contextDictionary["index"] ?? "1"
            setTitle("Note \(index)")
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

}
