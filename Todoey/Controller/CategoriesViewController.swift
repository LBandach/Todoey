//
//  CategoriesViewController.swift
//  Todoey
//
//  Created by user on 03.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoriesViewController: UITableViewController {

    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80
    }
    
    //MARK: Table View DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if categoryArray?.count == 0 {
//            return 1
//        }
        return categoryArray?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
//        if categoryArray?.count == 0 {
//            cell.textLabel?.text = "No Categories added yet"
//        } else {
//            cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
//        }
        cell.delegate = self
        return cell
    }
    
    //MARK: Data Manipulation Methods

    func save(category: Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        } catch{
            print("saving error\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories(){
        categoryArray = realm.objects(Category.self)
        self.tableView.reloadData()
    }
    
    //MARK: Add New Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var passedText = UITextField()
        
        let alert = UIAlertController(title: "Type in your categroy", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add new category", style: .default) { (action) in
            
            let newItem = Category()
            newItem.name = passedText.text!
            self.save(category: newItem)
        }
        alert.addTextField { (alertText) in
            alertText.placeholder = "create new category"
            passedText = alertText
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
}

//MARK: - Swipe Cell Delegate Methods

extension CategoriesViewController: SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let categoryForDelition = self.categoryArray?[indexPath.row]{
                do{
                    try self.realm.write {
                        self.realm.delete(categoryForDelition)
                    }
                } catch{
                    print("deleting error\(error)")
                }
                //tableView.reloadData()
            }
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}






















