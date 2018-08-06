//
//  CategoriesViewController.swift
//  Todoey
//
//  Created by user on 03.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UITableViewController {

    var categoryArray: [Category] = []

    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: Table View DataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    //MARK: Data Manipulation Methods

    func saveCategories(){
        
        do{
        try context.save()
        } catch{
            print("saving error\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
        try categoryArray = context.fetch(request)
        }catch{
            print("loading error\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    //MARK: Add New Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var passedText = UITextField()
        
        let alert = UIAlertController(title: "Type in your categroy", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add new category", style: .default) { (action) in
            
            let newItem = Category(context: self.context)
            newItem.name = passedText.text
            self.categoryArray.append(newItem)
        
            self.saveCategories()
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
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
    }
    
    
    
    

    
}
























