//
//  ViewController.swift
//  firstApp
//
//  Created by Leandro Gartner on 7/9/17.
//  Copyright © 2017 Leandro Gartner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        var message = "It's empty"
        
        if textInput.text != "" {
            message = textInput.text!
        }
        
        DatabaseService.shared.saveText(text: message)
        
        let alert = UIAlertController(title: "Message published on firebase", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        textInput.text = ""
    }


}

