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
   // var itemArray = ["Read a book", "Write article", "List app"]
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
               newItem2.title = "Find "
               itemArray.append(newItem2)
        
        let newItem3 = Item()
               newItem3.title = " Mike"
               itemArray.append(newItem3)
        
        //fetch data from background
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }

    }
    
    
    //MARK:- Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Did movie the checkMark from didSelectRowAt
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        /*
         //used Ternary operator instead of below ifelse code
         if item.done == true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }*/
        
        
        return cell
    }
    
    
    //MARK:- TableVieww Deleagate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //writen in single line instead of below ifelse code`
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        /*if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }*/
        
        tableView.reloadData()
        
        //onclick on cell animation
        tableView.deselectRow(at: indexPath, animated: true)
         
        //To Mark and Unmark :CheckMark
           /* if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }*/

    }
    
    //MARK: - ADD New Item

    @IBAction func addButtonPresswd(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //This will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            //adding new list in array
            self.itemArray.append(newItem)
            
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

