//
//  CategoryViewController.swift
//  Todoey-iOS12
//
//  Created by Dieter Bergmann on 31.10.18.
//  Copyright © 2018 Dieter Bergmann. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    // Erzeugen eines neunen realm Database Objektes
    let realm = try! Realm()
    // Auto-updating Container für Catogory-Elemtene
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Laden aller aktuellen Category-Elemete
        loadCategories()
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Nil-Coalescing Operator (a ?? b) unwrapps an optional a if is not nil otherwise it returns a default value b
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Erzeugen einer Instanz des Ziel-ViewControllers (TodoListViewController)
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            // Übergeben der im CategoryViewController selektierten category an das entsprechende Property
            // im TodoListViewController
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new cetegory"
        }
        
        present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Data Manipilation Methods
    func save(category: Category) {
        do {
            // Übergeben von Änderungen an Realm
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        // Holen aller Category-Elemte die in Realm gespeichert sind
        categories = realm.objects(Category.self)
        
        // reloadData ruft alle Datasource Methoden auf
        tableView.reloadData()
    }
    
    // MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
}


