//
//  StartViewController.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 30.11.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class StartViewController: UIViewController, CAAnimationDelegate {
    
    var audioPlayer: AVAudioPlayer?
    
    var classesArray = ["Matemetik"]
    var classSelection: String?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var classes: UITextField!
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    
    let colorOne = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor
    
    var canEnter = false
    override func viewDidLoad() {
        super.viewDidLoad()
        createClassPicker()
        createToolbar()
        

        backButton.layer.cornerRadius = 50
        startButton.layer.cornerRadius = 85
        
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           createGradientView()
       }
       
       
       
       func createGradientView() {
           
           // overlap the colors and make it 3 sets of colors
           gradientSet.append([colorOne, colorTwo])
           gradientSet.append([colorTwo, colorOne])
      
           
           // set the gradient size to be the entire screen
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
    
    func createClassPicker() {
        let classPicker = UIPickerView()
        classPicker.delegate = self
        
        classes.inputView = classPicker
    }
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(StartViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        classes.inputAccessoryView = toolbar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 
    
    @IBAction func startTheExam(_ sender: UIButton) {
        updateExamDate()
        if canEnter {
            Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        } else {
            showSimpleActionSheet()
        }
        
        
    }
    
    func showSimpleActionSheet() {
         let alert = UIAlertController(title: "Bugünlük Bu kadar", message: "Son sınavının üstünden bir gün geçmemiş. Daha sonra tekrar dene.", preferredStyle: .alert)
      

         alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (_) in
         }))

         self.present(alert, animated: true, completion: {
         })
     }
    
    var counter = 3
    @objc func updateCounter() {
        
        if counter > 0 {
            SoundPlayer.shared.start(sound: "countdown")
            startButton.pulsate()
            startButton.setImage(UIImage(named: "\(counter)"), for: .normal)
            counter -= 1
        }
        else if counter == 0 {
            SoundPlayer.shared.start(sound: "start")
            startButton.pulsate()
            startButton.setImage(UIImage(named: "\(counter)"), for: .normal)
            counter -= 1
        }
        else if counter == -1 {
            startButton.setImage(nil, for: .normal)
            startButton.coverTheScreen()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                self.performSegue(withIdentifier: "toExamVC", sender: nil)
            }
            
        }
    }
    
    func updateExamDate() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
             
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Schedule")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "studentID = %@", String(currentUser.id))
        
         do {
                   let results = try context.fetch(fetchRequest)
                   
                   for result in results as! [NSManagedObject] {
                       
                       if let date = result.value(forKey: "lastExamDate") as? Date {
                        
                        let calendar = Calendar.current

                        
                        let date1 = calendar.startOfDay(for: date)
                        let date2 = calendar.startOfDay(for: Date())

                        let components = calendar.dateComponents([.day], from: date1, to: date2).day
                        
                        if components! < 1 {
                            canEnter = false
                        } else {
                            result.setValue(Date(), forKey: "lastExamDate")
                            canEnter = true
                        }
                        
                       
                        
                        
                       }
                   }
            try context.save()
               } catch  {
                   print("Error")
               }
    }
}

extension StartViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classesArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        classSelection = classesArray[row]
        classes.text = classSelection
    }
    
    
}
