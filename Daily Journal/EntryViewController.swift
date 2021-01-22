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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryTextView.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Make an entry
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let entry = Entry(context: context)
            entry.date = datePicker.date
            entry.text = entryTextView.text
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}
