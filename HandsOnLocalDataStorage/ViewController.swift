//
//  ViewController.swift
//  HandsOnLocalDataStorage
//
//  Created by Randy Noel on 05/07/19.
//  Copyright © 2019 whiteHat. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBAction func btnSave(_ sender: UIButton) {
//        lblName.text = txtName.text
//        UserDefaults.standard.set(lblName.text, forKey: "name") //forKey ini sama dengan variable. jadi forkey adalah nama var dan lblName..text adalah value nya
//        // Digunakan dalam configurasi view
        
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //2
        let user = User(context: managedContext)
        
        user.name = txtName.text
        user.age = Int32(txtAge.text!)!
        
        do{
            try managedContext.save()
            print("Success saved")
        } catch {
            print("Data not saved!")
        }
        fetchData()
    }
    
    func fetchData(){
        
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //2
        var users = [User]()
        
        do {
            users = try managedContext.fetch(User.fetchRequest())
            for user in users{
                let name = user.name
                let age = user.age
                
                lblName.text! += "\(name!),\(age), "
                print(name)
            }
        } catch {
            print("Data not Fetched!")
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblName.isUserInteractionEnabled = false
//        let name = UserDefaults.standard.string(forKey: "name")
//        lblName.text = name
        lblName.text = ""
        
        
    }


}

