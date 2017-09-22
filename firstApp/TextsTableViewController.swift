//
//  TextsTableViewController.swift
//  firstApp
//
//  Created by Leandro Gartner on 11/9/17.
//  Copyright © 2017 Leandro Gartner. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class TextsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var textsView: UITableView!
    
    private var texts = [String]()
    private var contents = Dictionary<String,String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textsView.delegate = self
        self.textsView.dataSource = self
        self.textsView.allowsMultipleSelection = true

        self.navigationItem.leftBarButtonItem?.isEnabled = true
        
        DatabaseService.shared.textRef.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            
            if let texts = snapshot.value as? Dictionary<String, String> {
                
                for (key, value) in texts {
                    self.texts.append(value)
                    self.contents[key] = value
                }
            }
            self.textsView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextTableViewCell
        let text = self.texts[indexPath.row]
        
        cell.updateText(text: text)
        
        return cell
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.texts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            let keys = Array(contents.keys)
            let value = keys[indexPath.row]
            
            DatabaseService.shared.textRef.child(value).removeValue { (error, ref) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}
