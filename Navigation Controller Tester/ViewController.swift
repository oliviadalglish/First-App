//
//  ViewController.swift
//  Navigation Controller Tester
//
//  Created by Olivia Dalglish on 1/13/17.
//  Copyright © 2017 Olivia Dalglish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var ingredientsTextField: UITextField!
    var recipesArray: NSMutableArray! = NSMutableArray()
    var tableCount = 1
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func buttonPressed(_ sender: Any) {
        viewDidAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table view
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipesArray.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        //cell.titleLabel.text = self.recipesArray.object(at: indexPath.row) as? String
        var cellLabel = ""
        if let tempDictionary = self.recipesArray[indexPath.row] as? NSDictionary{
            if let tempLabel = tempDictionary["title"] as? String {
                cellLabel = tempLabel
            }
        }
        cell.titleLabel.text = cellLabel
        cell.tag = indexPath.row
        
        return cell

    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showView", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showView") {
            let upcoming: NewViewController = segue.destination as! NewViewController
            
            let indexPath = self.table.indexPathForSelectedRow!
            
            let titleString = self.recipesArray.object(at: indexPath.row) as? String
            
            upcoming.titleString = titleString
            upcoming.cellTag = indexPath.row

            self.table.deselectRow(at: indexPath, animated: true)
            
            
        }
    }
    
    func fetchIngredients() -> NSArray {
        let ingredients = ingredientsTextField.text!
        let ingredientsString = ingredients.characters.split { $0 == "," }
        var ingredientsArray = ingredientsString.map(String.init)
        
        for i in ingredientsArray.indices {
            ingredientsArray[i] = ingredientsArray[i].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            ingredientsArray[i] = ingredientsArray[i].replacingOccurrences(of: " ", with: "%20")
        }
        
        print ("fetchIngredients() -> ingredientsArray contents:")
        print (ingredientsArray)
        
        return ingredientsArray as NSArray
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        var urlString = "http://food2fork.com/api/search?key=bedd5c0b32f3b7b533febdf9bddf979f&q="
        
        if let text = ingredientsTextField.text, text != "" {
            let tempArray = fetchIngredients()
            for ingredient in tempArray {
                urlString += ingredient as! String
                urlString += ","
            }
            let oneBeforeLast = urlString.index(urlString.endIndex, offsetBy: -1)
            let completeUrlString = urlString.substring(to: oneBeforeLast)
            
            
            let url = URL(string: completeUrlString)
            
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if error != nil {
                    print(error ?? "task failed")
                } else {
                    do {
                        if let urlContent = data {
                            let jsonResult =  try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                            
                            if let recipes = jsonResult["recipes"]  {
                                self.recipesArray = (recipes as? NSMutableArray)!
                                self.tableCount = self.recipesArray.count
                            }
                            else {
                                print ("fetch error")
                            }
                            DispatchQueue.main.async() {
                                self.table.reloadData()
                            }
                        }
                        
                    } catch {
                        print ("Error loading JSON data")
                    }
                    
                }
            }
            task.resume()
        }
        else {
            print ("Enter some ingredients")
        }
    }


}

