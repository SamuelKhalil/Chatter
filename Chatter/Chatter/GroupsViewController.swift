//
//  File.swift
//  Chatter
//
//  Created by Samuel Khalil on 7/27/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//


import UIKit
import Firebase
class GroupsViewController: UITableViewController {

    
    //var Groups = ["Just Friends", "Messages","Jokes"]
    var groupCreated = ""
    var GroupArray: [Message] = [Message] ()
    
    override func viewDidLoad() {
        GroupNames()
        self.tableView.reloadData()
        
        super.viewDidLoad()
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupArray.count
    }
    
    //TODO: Populate All Groups From Firebase
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath)
        cell.textLabel?.text = GroupArray[indexPath.row].Group

        return cell
        
    }
    
    //TODO: WHEN ROW IS SELECTED
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        groupCreated = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        
        self.performSegue(withIdentifier: "GoToChat", sender: self)
    }
    
    //TODO: ADD new Group
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
     var  textField = UITextField ()
     let alert = UIAlertController(title: "Add New Chatter Group", message: "", preferredStyle: .alert)
        
      let action = UIAlertAction(title: "Add Group", style: .default) { (action) in
        
        //MARK:- what will happen once the user press the add button on alert
        self.groupCreated = textField.text!
        let text = self.groupCreated
        let message = Message()
        message.Group = text
        
        self.GroupArray.append(message)
        
        self.tableView.reloadData()
        
        }
        
        //TODO: Create the pop up to add new group
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Group"
            textField = alertTextField
        }
            alert.addAction(action)

            present(alert, animated: true, completion: nil)
    }
    
    // TODO: Moving the the  new Group to the ChatViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as! ChatViewController
        vc.newGroup = self.groupCreated
        
    }
    //TODO: Groups Retrival
    func GroupNames()  {
        _ = Database.database().reference().observe(.childAdded, with: { (snapShot) in
            let allGroups = snapShot.key
            let text = allGroups
            let message = Message()
            message.Group = text
            
            self.GroupArray.append(message)
            
            self.tableView.reloadData()
        })
    }
    
}
