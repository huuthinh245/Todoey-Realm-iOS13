//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by thinh on 12/2/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
class CategoryViewControllerTableViewController: SwipeTableViewController {
    var dataCategory: Results<CategoryList>?
    lazy var realm =  try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCategory?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = dataCategory?[indexPath.row]
        cell.textLabel?.text = item?.name ?? "no categories added yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController {
            if let index = tableView.indexPathForSelectedRow {
                destinationVC.category = dataCategory?[index.row]
                destinationVC.title = dataCategory?[index.row].name
            }
        }
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add catogry", message: "type category", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if action.title == "Add Category" {
                let field = alert.textFields?.first!
                if let text = field?.text, field?.text?.isEmpty == false {
                    let category = CategoryList()
                    category.name = text
                    self.saveData(category)
                    self.tableView.reloadData()
                }
            }
        }
        alert.addAction(action)
        alert.addTextField(configurationHandler: nil)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        let data = realm.objects(CategoryList.self)
        dataCategory = data
    }
    
    func  saveData(_ category: CategoryList) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("save error \(error)")
        }
    }
    
    override func updateModel(_ indexPath: IndexPath) {
        super.updateModel(indexPath)
        print(indexPath.row)
        do {
            try self.realm.write({
                self.realm.delete(self.dataCategory![indexPath.row])
            })
        } catch {
            print("error \(error)")
        }
        //self.tableView.reloadData()
    }
}

