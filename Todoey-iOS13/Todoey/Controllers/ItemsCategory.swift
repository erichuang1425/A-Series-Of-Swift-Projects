//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ItemsCategory:SwipeTableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    let realm = try! Realm()
    var itemArray:Results<Items>?
    var initialColor = UIColor()
    var categoryInitialColor = UIColor()
    
    var selectedCategory:Category?{
        didSet{
            loadItems()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        initialColor = UIColor.randomFlat()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = categoryInitialColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
     
        navigationItem.title = selectedCategory?.name
        navigationController?.navigationBar.backgroundColor = initialColor
        tableView.backgroundColor = initialColor.lighten(byPercentage: 0.3)
        searchBar.barTintColor = initialColor
        textFieldInsideSearchBar?.textColor = ContrastColorOf(initialColor, returnFlat: true)
        
    }
    
    
    func loadItems(){
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[ categoryPredicate, additionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
//
//        do{
//            itemArray = try context.fetch(request)
//            try print(context.fetch(request))
//
//        }catch{
//            print("Error while fetching data",error)
//        }
         tableView.reloadData()
        
    }
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            if textField.text == "" || textField.text == nil{
                alert.title = "Blank - Enter your new item."
                self.present(alert, animated: true, completion: nil)
            }else{
                if let currentCategory = self.selectedCategory{
                    do{
                        try self.realm.write{
                            let newItem = Items()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    }catch{
                        print("Error saving new items: \(error)")
                    }
                    
                }
               
            self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (itemTextField) in
            itemTextField.placeholder = "Create New Item"
            textField = itemTextField
            
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write{
                    realm.delete(item)
                }
            }catch{
                    print("Error while saving done status: \(error)")
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = itemArray?[indexPath.row]{
            cell.textLabel?.text = item.title
            if let color = initialColor.lighten(byPercentage: CGFloat(indexPath.row) / CGFloat( itemArray!.count) / 2.0){
                
                cell.backgroundColor = color
                
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
        }else{
            cell.textLabel?.text = "No item added"
        }
        return cell
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray?.count ?? 1
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()

//        let request: NSFetchRequest<Items> = Items.fetchRequest()
//            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//            request.sortDescriptors = [sortDescriptor]
//            loadItems(with:request, predicate: predicate)
//        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
}
            
              

