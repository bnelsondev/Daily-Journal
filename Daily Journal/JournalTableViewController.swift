//
//  JournalTableViewController.swift
//  Daily Journal
//
//  Created by Bryan Nelson on 1/21/21.
//

import UIKit

class JournalTableViewController: UITableViewController {
    
    var entries: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let entriesFromCoreData = try? context.fetch(Entry.fetchRequest()) as? [Entry] {
                entries = entriesFromCoreData
                tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cell = UITableViewCell()

        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.text

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController {
            
        }
    }
}
