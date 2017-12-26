//
//  ProfileViewController.swift
//  Building Parking
//
//  Created by Apple on 06/12/17.
//  Copyright © 2017 Vns. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.phone.text=retriveSharedValue(currentLevel: "phone")
        self.first_name.text=retriveSharedValue(currentLevel: "first_name")
        self.email.text=retriveSharedValue(currentLevel: "email")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var first_name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func retriveSharedValue(currentLevel: String)->String
    {
        let preferences = UserDefaults.standard
        
        let currentLevelKey = currentLevel
        
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
        } else {
            
            
            return preferences.object(forKey: currentLevelKey) as! String
            
            
            
        }
        
        
        return ""
    }
    
}
