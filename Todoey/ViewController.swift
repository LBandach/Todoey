//
//  ViewController.swift
//  Todoey
//
//  Created by user on 20.07.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    let itemArray = ["asdas","sfsdf","sdfsdf"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: TableView Methods
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

