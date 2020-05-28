//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //List of Table from Array
    var itemArray = ["Read a book", "Write article", "List app"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch data from background
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }

    }
    
    
    //MARK:- Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK:- TableVieww Deleagate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //onclick on cell animation
        tableView.deselectRow(at: indexPath, animated: true)
         
        //To Mark and Unmark :CheckMark
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

    }
    
    //MARK: - ADD New Item

    @IBAction func addButtonPresswd(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //This will happen once the user clicks the Add Item button on our UIAlert
            
            //adding new list in array
            self.itemArray.append(textField.text!)
            
            //to store data after terminating app and call than in viewdidload
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)  
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

