//
//  ViewController.swift
//  Todoey
//
//  Created by user on 20.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem: Item = Item()
        newItem.title = "asdaS"
        let newItem1: Item = Item()
        newItem1.title = "asdaSa"
        let newItem2: Item = Item()
        newItem2.title = "asdaSb"
        let newItem3: Item = Item()
        newItem3.title = "asdaSc"
        itemArray.append(newItem)
        itemArray.append(newItem1)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
        
        if let item = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = item
        }
        
    }

    //MARK: TableView Methods
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: Add button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var passedItem = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = passedItem.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            passedItem = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    


}

