//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by Bryan Nelson on 1/21/21.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var bottomTextViewConstraint: NSLayoutConstraint!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //entryTextView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        if entry == nil {
            // Create entry
            if entry == nil {
                if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    entry = Entry(context: context)
                    entry?.date = datePicker.date
                    entry?.text = "Today was ..."
                    entryTextView.becomeFirstResponder()
                }
            }
        }
        
        entryTextView.text = entry?.text
        if let dateToBeShown = entry?.date {
            datePicker.date = dateToBeShown
        }
        entryTextView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @objc func keyboardWillShow (_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomTextViewConstraint.constant = keyboardHeight
        }
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
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}
