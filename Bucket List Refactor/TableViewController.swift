//
//  ViewController.swift
//  Bucket List Refactor
//
//  Created by admin on 15/12/2021.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController , SavingItemDelegate{
 
    var items = [String]()
    var itemsArr : Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getallTasks()
        
    }
    
    //https://saudibucketlistapi.herokuapp.com/tasks/
    
    //http://127.0.0.1:8080/myTasks/
    
    func getallTasks(){
        AF.request("https://saudibucketlistapi.herokuapp.com/tasks/").responseDecodable(of: [Task].self) { response in
            guard let tasksArr = response.value else {return}
            self.items = tasksArr.map{ task in
                return task.objective
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateTask(){
        
    }
    
//    func getTasks(){
//        URLSession.shared.dataTask(with: URL(string:"http://localhost:8080/myTasks/")!, completionHandler: {
//            data, response, error in
//            do {
//                let result = try JSONDecoder().decode([Task].self, from: data!)
//                print(result)
//
//            }catch{
//                print(error)
//            }
//        }).resume()
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let destination = segue.destination as! ViewController
            destination.delegate = self
        }else if sender is NSIndexPath {
            let destination = segue.destination as! ViewController
            destination.delegate = self
            
            let currentIndex = sender as! NSIndexPath
            let currentItem = items[currentIndex.row]
            destination.itemIndex = currentIndex
            destination.itemtext = currentItem
        }
    }
    
    func saveItem(controller: ViewController, itemText: String, itemIndex: NSIndexPath?) {
        if let itemIndex = itemIndex {
          items[itemIndex.row] = itemText
        }else{
            items.append(itemText)
        }
        tableView.reloadData()
    }
    
 
}



