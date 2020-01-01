
//
//  ViewController.swift
//  Core Animations
//
//  Created by Bilguun Batbold on 29/3/19.
//  Copyright © 2019 Bilguun. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet var Buttons: [UIButton]!
    
    var userName = ""
    var passWord = ""
    
    var allUsers = [String]()
    var allPasswords = [Int]()
    var allID = [Int]()
    var allIsStudent = [Bool]()
    

    
    let gradient = CAGradientLayer()
    
    
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor
    let colorThree = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
    let colorFour = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor
    let colorFive = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addUser()
        pullUsers()
        print(allUsers , allID)
        
        if MyVariables.playing == false {
            MusicPlayer.shared.start()
            MyVariables.playing = true
        }
        
        
        for button in Buttons {
            button.layer.cornerRadius = 25
        }
        
       
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createGradientView()
    }
    
//    MARK: gradient
    
    func createGradientView() {
        
        
        gradientSet.append([colorOne, colorTwo])
        gradientSet.append([colorTwo, colorThree])
        gradientSet.append([colorThree, colorOne])
        gradientSet.append([colorOne, colorFour])
        gradientSet.append([colorFive, colorOne])
        gradientSet.append([colorThree, colorFive])
        gradientSet.append([colorThree, colorFour])
        gradientSet.append([colorTwo, colorFour])
        gradientSet.append([colorTwo, colorFive])
        gradientSet.append([colorFour, colorFive])
        
       
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        animateGradient()
    }
    
    
    func animateGradient() {
        
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
 
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 3.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
      
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
//    MARK: Alerts
    func showLoginAlert(isStudent: Bool) {

        var usernameTextField: UITextField?
        var passwordTextField: UITextField?
        
        var tittle = ""
        
        if isStudent {
            tittle = "Öğrenci Girişi"
        }
        else {
            tittle = "Öğretmen Girişi"
        }

        let alertController = UIAlertController(
            title: tittle,
            message: "Giriş yapmak için lütfen kullunacı adını ve şifrenizi giriniz.",
            preferredStyle: .alert)

        let loginAction = UIAlertAction(
        title: "Giriş Yap", style: .default) {
            (action) -> Void in

            if let username = usernameTextField?.text {
                self.userName = username
                MyVariables.name = self.userName
            }

            if let password = passwordTextField?.text {
                self.passWord = password
            }
            // MARK: Veri tabanı kontrol için doesExist metodu
            if self.doesExist(name: self.userName, password: self.passWord) {
                
                if currentUser.isStudent, isStudent {
                    self.performSegue(withIdentifier: "toStudentVC", sender: nil)
                }
                else if !currentUser.isStudent, !isStudent{
                    self.performSegue(withIdentifier: "toTeachVC", sender: nil)
                }
                else {
                    self.showSimpleActionSheet()
                }
            } else {
                self.showSimpleActionSheet()
            }
        }
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel) { (_) in }


        alertController.addTextField {
            (txtUsername) -> Void in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = "Kullanıcı Adı"
        }

        alertController.addTextField {
            (txtPassword) -> Void in
            passwordTextField = txtPassword
            passwordTextField?.isSecureTextEntry = true
            passwordTextField?.placeholder = "Şifre"
        }

        alertController.addAction(cancelAction)
        alertController.addAction(loginAction)
        present(alertController, animated: true, completion: nil)

    }
    func showSimpleActionSheet() {
        let alert = UIAlertController(title: "Yanlış Kullanıcı İsmi veya Şifre", message: "Lütfen tekrar deneyiniz.", preferredStyle: .alert)
     

        alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (_) in
        }))

        self.present(alert, animated: true, completion: {
        })
    }
    @IBAction func buttonsClicked(_ sender: UIButton) {
        var student = false
        if Buttons[1] == sender {
            student = true
        }
        else {
            student = false
        }
        showLoginAlert(isStudent: student)
        
        
    }
//    MARK: Kullanıcı Ekleme
//    func addUser() {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
//
//        newUser.setValue(3, forKey: "id")
//        newUser.setValue("Alp", forKey: "name")
//        newUser.setValue(123, forKey: "password")
//        newUser.setValue(false, forKey: "isStudent")
//
//        do {
//            try context.save()
//            print("Done")
//        } catch  {
//            print("Error")
//        }
//    }
    
    func pullUsers() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let name = result.value(forKey: "name") as? String {
                    allUsers.append(name)
                }
                if let password = result.value(forKey: "password") as? Int {
                    allPasswords.append(password)
                }
                if let id = result.value(forKey: "id") as? Int {
                    allID.append(id)
                }
                if let isStudent = result.value(forKey: "isStudent") as? Bool {
                    allIsStudent.append(isStudent)
                }
            }
        } catch  {
            print("Error")
        }
        
    }
    
    func doesExist(name: String, password: String) -> Bool {
        
        let Password:Int? = Int(password)
        
        if let index = allUsers.firstIndex(of: name) {
            if allPasswords[index] == Password {
                
                currentUser.name = name
                currentUser.id = allID[index]
                currentUser.isStudent = allIsStudent[index]
                
                return true
            }
        }
        return false

    }
    
    func testing(i: Int) -> Bool {
        if i == 2 {
            return true
        }
        return false
    }
        
    

    
}



