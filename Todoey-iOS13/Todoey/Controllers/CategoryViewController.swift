//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Eric Huang on 7/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class CategoryViewController:SwipeTableViewController {
    
    let realm = try! Realm()
    var initialColor = UIColor()
    
    var categoryArray:Results<Category>?
        
    override func viewDidLoad() {
            super.viewDidLoad()
        loadCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialColor = UIColor.randomFlat()
        navigationController?.navigationBar.backgroundColor = initialColor
    }
    
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add New Category", style: .default) { (action) in
                let newCategory = Category()
                newCategory.name = textField.text!
                self.saveCheckedData(category: newCategory)
                
                self.tableView.reloadData()
            }
            
            alert.addTextField { (categoryTextField) in
                categoryTextField.placeholder = "Create New Category"
                textField = categoryTextField
                
            }
            alert.addAction(action)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            }))
            
            present(alert, animated: true, completion: nil)
    }
    
    
    func saveCheckedData(category: Category){
            do{
                try realm.write{
                    realm.add(category)
                }
                
            }catch{
                print("Error saving category data type",error,"while deselecting row.")
            }
    }
        
    
    func loadCategory(){
            categoryArray = realm.objects(Category.self)

             tableView.reloadData()
            
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = categoryArray?[indexPath.row]{
            do{
                try realm.write{
                    realm.delete(category)
                }
            }catch{
                    print("Error while saving done status: \(error)")
            }
            
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoryArray?.count ?? 1
    }
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categoryArray?[indexPath.row]{
            cell.textLabel?.text = category.name
            if let color = initialColor.lighten(byPercentage: CGFloat(indexPath.row) / CGFloat( categoryArray!.count)/2.0){
                
                cell.backgroundColor = color
                
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            
            
            
        }else{
            cell.textLabel?.text = "No category added"
        }
        
       
        
        
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            performSegue(withIdentifier: "goToItems", sender: self)
            
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ItemsCategory
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            destinationVC.categoryInitialColor = initialColor
        }
    
    }
}
