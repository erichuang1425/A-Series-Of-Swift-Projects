//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Eric Huang on 7/15/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        tableView.separatorStyle = .none

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
           
        cell.delegate = self
//           if let item = itemArray?[indexPath.row] {
//
//               cell.textLabel?.text = item.title
//
//               cell.accessoryType = (item.checked) ? .checkmark : .none
//           }else{
//
//               cell.textLabel?.text = "No item added."
//           }
           
           return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
           
           guard orientation == .right else {return nil}
           
           let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            self.updateModel(at:indexPath)
            
           }
        deleteAction.image = UIImage(named: "delete-icon")
        
           return [deleteAction]
       }
       
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
           var options = SwipeOptions()
           options.expansionStyle = .destructive
           options.transitionStyle = .drag
           return options
    }
    
    func updateModel(at indexPath: IndexPath){
        
    }
}


