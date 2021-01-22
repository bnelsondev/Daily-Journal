//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by Bryan Nelson on 1/21/21.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTextView.isScrollEnabled = false

        if entry == nil {
            // Create entry
        } else {
            // Fill in info about existing entry
            entryTextView.text = entry!.text
            if let dateToBeShown = entry!.date {
                datePicker.date = dateToBeShown
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Make an entry
        if entry == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let entry = Entry(context: context)
                entry.date = datePicker.date
                entry.text = entryTextView.text
                
            }
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(entry!)
                try? context.save()
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
