//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
        // MARK: - Properties
        private var client: LoginClient?
        
        @IBOutlet weak var userName: UITextField!
        @IBOutlet weak var passWord: UITextField!
        @IBOutlet weak var login: UIButton!
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Login"
            setUp()
        }
        
        
        func setUp(){
            
            let backgroundImage1 = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage1.image = UIImage(named: "img_login")
            backgroundImage1.contentMode = UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage1, at: 0)
            
            userName.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            userName.borderStyle = .none
            userName.layer.cornerRadius = 6
            userName.setLeftPaddingPoints(24)
            
            passWord.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            passWord.borderStyle = .none
            passWord.layer.cornerRadius = 6
            passWord.setLeftPaddingPoints(24)

            
            login.backgroundColor = UIColor(hexString: "#0E5C89")
            login.setTitleColor(UIColor.white, for: .normal)
            
        }
        
        @IBAction func didPressLoginButton(_ sender: Any) {
            
            
            guard let userName = self.userName.text , let passWord = self.passWord.text else {
                return;
            }
            
            let endPoint = "http://dev.rapptrlabs.com/Tests/scripts/login.php"
            
            guard let endpointUrl = URL(string: endPoint) else {
                return;
            }
            
            var params = [String:Any]();
            
            params.updateValue(userName, forKey: "email")
            params.updateValue(passWord, forKey: "password");

            do {
                let data = try JSONSerialization.data(withJSONObject: params, options: []);
                
                var request = URLRequest(url: endpointUrl)
                request.httpMethod = "POST";
                request.httpBody = data;
                request.setValue("text/html", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept");
                
                let methodStart = Date()
                httpResponse(request: request) { (received_data, error) in
                    let methodFinish = Date()
                    guard received_data != nil else {
                        let executionTime = methodFinish.timeIntervalSince(methodStart)
                        DispatchQueue.main.async{
                            let alert = UIAlertController(title: error as? String, message: "Server Unavailable: Timer Count: \(executionTime)", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        }
                    return
                    }
                    let executionTime = methodFinish.timeIntervalSince(methodStart)
                    let alert = UIAlertController(title: "Success", message: "Timer Count: \(executionTime)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            catch  {
                print(error.localizedDescription as Any);
            }
            
        }
    }
