//
//  NewViewController.swift
//  Navigation Controller Tester
//
//  Created by Olivia Dalglish on 1/13/17.
//  Copyright © 2017 Olivia Dalglish. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    var titleString: String!
    var cellTag: Int!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleString
        
        if let ViewControllerObject: ViewController() {
            if let tempDictionary = ViewControllerObject.recipesArray[cellTag] as? NSDictionary {
            
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
