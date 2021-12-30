//
//  ViewController.swift
//  Bucket List Refactor
//
//  Created by admin on 15/12/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var itemtext:String?
    var itemIndex:NSIndexPath?

    @IBOutlet weak var itemTextField: UITextField!
    var delegate:SavingItemDelegate?
    var TVdelegate:TableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemTextField.text = itemtext
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let text = itemTextField.text , !text.isEmpty{
           delegate?.saveItem(controller: self , itemText: itemTextField.text! , itemIndex: itemIndex)
            let date = Date().formatted()
          let task = Task(objective: text , created_at: date)
            AF.request("https://saudibucketlistapi.herokuapp.com/tasks/", method: .post, parameters: task).responseDecodable(of: Task.self) { response in
                guard let newtask = response.value else {return}
                self.TVdelegate?.items.append(newtask.objective)
            }

            navigationController?.popViewController(animated: true)
            
        }
       
    }
    
    
}
