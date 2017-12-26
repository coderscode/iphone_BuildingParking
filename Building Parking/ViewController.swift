//
//  ViewController.swift
//  Building Parking
//
//  Created by Apple on 22/11/17.
//  Copyright © 2017 Vns. All rights reserved.
//

import UIKit

import SwiftyJSON
import Alamofire
import SVProgressHUD
class ViewController: UIViewController,UITextFieldDelegate {

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.delegate=self
        self.password.delegate=self
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(retriveSharedValue(currentLevel: "authkey").count>0)
        {
              NextScreen()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_textField:UITextField)->Bool
    {
        _textField.resignFirstResponder()
        
        return (true)
    }
    @IBAction func submit(_ sender: Any) {
        
        print (email.text)
        print (password.text)
        
        if(email.text=="" || password.text=="")
        {
              Toast("Please fill up all the fields").show(self)
       
        }
        else
        {
            let comment: [String:AnyObject] = [
                "email": email.text as AnyObject,
                "password": password.text as AnyObject,
                "fcm_key": "asdfasfsadfadsfsdf" as AnyObject
            ]
            getBitcoinData(url: baseURL,comment: comment)
        }
        
    }
    
    let baseURL = "http://vnsparking-env.ahgftwjyr4.ap-south-1.elasticbeanstalk.com/AllUserAPI?api_type=UserLogin"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
//    func getBitcoinData(url: String) {
//
//        Alamofire.request(url, method: .get)
//            .responseJSON { response in
//                if response.result.isSuccess {
//
//                    print("Sucess! Got the weather data")
//                    let bitcoinJSON : JSON = JSON(response.result.value!)
//
//                    self.updatebitcoinData(json: bitcoinJSON)
//
//                } else {
//                    print("Error: \(String(describing: response.result.error))")
//                    self.email.text = "Connection Issues"
//                }
//        }
//
//    }
    
    
   
    func getBitcoinData(url: String,comment: [String:AnyObject]) {
    SVProgressHUD.show()
            Alamofire.request(url, method: .post, parameters: comment)
                .responseJSON { response in
                    if response.result.isSuccess {
    SVProgressHUD.dismiss()
                        print("Sucess! Got the weather data")
                        let weatherJSON : JSON = JSON(response.result.value!)
//                        Toast(self.jsonToString(json: weatherJSON as AnyObject)).show(self)
                        print(weatherJSON)
                        self.updatebitcoinData(json: weatherJSON)
                  //      self.updateWeatherData(json: weatherJSON)
    
                    } else {
                        SVProgressHUD.dismiss();                   print("Error: \(String(describing: response.result.error))")
                      //  self.bitcoinPriceLabel.text = "Connection Issues"
                    }
                }
    
        }
    
    
    func jsonToString(json: AnyObject)-> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            
            return (convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }
    
        //MARK: - JSON Parsing
        /***************************************************************/
    
    func updatebitcoinData(json : JSON) {
        if let bitcoinResult = json["status"].bool
        {
            if (bitcoinResult==true)
            { //Toast("Success").show(self)
                
                storeSharedValue(currentLevel: "assign_car", saveValue:json["userData"]["assign_car"].stringValue)
                storeSharedValue(currentLevel: "authkey", saveValue:json["userData"]["authkey"].stringValue)
                storeSharedValue(currentLevel: "thumbnail", saveValue:json["userData"]["thumbnail"].stringValue)
                storeSharedValue(currentLevel: "user_bike_color", saveValue:json["userData"]["user_bike_color"].stringValue)
                storeSharedValue(currentLevel: "company_id", saveValue:json["userData"]["company_id"].stringValue)
                storeSharedValue(currentLevel: "company_phone_no", saveValue:json["userData"]["company_phone_no"].stringValue)
                storeSharedValue(currentLevel: "last_name", saveValue:json["userData"]["last_name"].stringValue)
                
                storeSharedValue(currentLevel: "company_email", saveValue:json["userData"]["company_email"].stringValue)
                storeSharedValue(currentLevel: "user_car_model", saveValue:json["userData"]["user_car_model"].stringValue)
                storeSharedValue(currentLevel: "assign_bike", saveValue:json["userData"]["assign_bike"].stringValue)
                storeSharedValue(currentLevel: "phone", saveValue:json["userData"]["phone"].stringValue)
                storeSharedValue(currentLevel: "user_car_no", saveValue:json["userData"]["user_car_no"].stringValue)
                storeSharedValue(currentLevel: "company_name", saveValue:json["userData"]["company_name"].stringValue)
                storeSharedValue(currentLevel: "user_reserve_status", saveValue:json["userData"]["user_reserve_status"].stringValue)
                storeSharedValue(currentLevel: "user_bike_model", saveValue:json["userData"]["user_bike_model"].stringValue)
                storeSharedValue(currentLevel: "user_bike_no", saveValue:json["userData"]["user_bike_no"].stringValue)
                storeSharedValue(currentLevel: "id", saveValue:json["userData"]["id"].stringValue)
                storeSharedValue(currentLevel: "first_name", saveValue:json["userData"]["first_name"].stringValue)
                storeSharedValue(currentLevel: "email", saveValue:json["userData"]["email"].stringValue)
                storeSharedValue(currentLevel: "user_car_color", saveValue:json["userData"]["user_car_color"].stringValue)
                NextScreen()
               
                
                
                
                
                
                
//                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//                self.navigationController?.pushViewController(loginVC, animated: true)
           // performSegue(withIdentifier: "loginned", sender: self)
            }
            else
            {
            Toast("Email or password doesn't matched").show(self)
            }
            
        }
        else
        {
            Toast("Unavailable").show(self)
         
        }
        
    }
    
    
    func NextScreen()
    {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.present(loginVC, animated: true, completion: nil)
    }
    func storeSharedValue(currentLevel: String, saveValue: String)
    {
        let preferences = UserDefaults.standard
        
        let currentLevelKey = currentLevel
        
       
        // store string value
        preferences.set(saveValue, forKey: currentLevelKey)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
    
    
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

