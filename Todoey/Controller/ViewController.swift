//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import  SwipeCellKit
class ViewController: UITableViewController {
    lazy var realm = try! Realm()
    var todoItems: Results<Item>?
    var headerTitle: String = ""
    var category: CategoryList?  {
        didSet {
            loadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(CustomTableCell.self, forCellReuseIdentifier: "custom")
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        navigationController?.navigationBar.largeContentTitle = headerTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
        self.refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }else {
            tableView.addSubview(self.refreshControl!)
        }
        self.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc func refresh(_ sender:AnyObject){
        self.refreshControl?.endRefreshing()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text  = "no item added"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write({
                    item.done = !item.done
                })
            }catch  {
                print("error \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let  alert = UIAlertController(title: "Modal", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (alertAction) in
            switch alertAction.title {
            case "add item":
                if let title = textField.text, textField.text?.isEmpty == false {
                    do {
                        try self.realm.write({
                            let item  = Item()
                            item.title = title
                            item.dateCreated = Date()
                            self.category?.items.append(item)
                        })
                    } catch {
                        print("error \(error)")
                    }
                    self.tableView.reloadData()
                }
                break
            case .none:
                break
            case .some(_):
                break
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "write some text"
            textField = alertTextField
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }

    
    func loadData() {
        todoItems = category?.items.sorted(byKeyPath: "title", ascending: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = category?.items.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}



