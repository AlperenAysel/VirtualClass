//
//  AddQViewController.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 1.12.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit
import CoreData

class AddQViewController: UIViewController, CAAnimationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var Subject: UITextField!
    
    @IBOutlet weak var Question: UITextField!
    
    @IBOutlet weak var CorrectAnswer: UITextField!
    
    @IBOutlet weak var SecondAnswer: UITextField!
    
    @IBOutlet weak var ThirdAnswer: UITextField!
    
    @IBOutlet weak var FourthAnswer: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var CorrectPic: UIImageView!
    
    @IBOutlet weak var SecondPic: UIImageView!
    
    @IBOutlet weak var ThirdPic: UIImageView!
    
    @IBOutlet weak var FourthPic: UIImageView!
    
    private var currentImageView: UIImageView? = nil
    
    
    var hasPictures = false
    var subjectIDArray = [Int]()
    var subjectArray = [String]()
    var subjectSelection: String?
    
    let gradient = CAGradientLayer()
     
     var gradientSet = [[CGColor]]()
    
     var currentGradient: Int = 0
     
     
     let colorOne = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
     let colorTwo = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        pullSubjects()
        createSubjectPicker()
        createToolbar()
        
//        CorrectPic.isUserInteractionEnabled = true
//        SecondPic.isUserInteractionEnabled = true
//        ThirdPic.isUserInteractionEnabled = true
//        FourthPic.isUserInteractionEnabled = true
        let imageTapRecognizerAC = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        let imageTapRecognizerA2 = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        let imageTapRecognizerA3 = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        let imageTapRecognizerA4 = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        CorrectPic.addGestureRecognizer(imageTapRecognizerAC)
        SecondPic.addGestureRecognizer(imageTapRecognizerA2)
        ThirdPic.addGestureRecognizer(imageTapRecognizerA3)
        FourthPic.addGestureRecognizer(imageTapRecognizerA4)
        
        
        addButton.layer.cornerRadius = 27
        backButton.layer.cornerRadius = 27
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           createGradientView()
       }

    func createGradientView() {
           
           
           gradientSet.append([colorOne, colorTwo])
           gradientSet.append([colorTwo, colorOne])
           
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
    @objc func selectImage(_ sender: UITapGestureRecognizer) {
        
        currentImageView = sender.view as? UIImageView
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        currentImageView!.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func hasPics(_ sender: UISwitch) {
        if sender.isOn {
            hasPictures = true
            CorrectAnswer.isHidden = true
            SecondAnswer.isHidden = true
            ThirdAnswer.isHidden = true
            FourthAnswer.isHidden = true
            CorrectPic.isHidden = false
            SecondPic.isHidden = false
            ThirdPic.isHidden = false
            FourthPic.isHidden = false
        }
        else {
            hasPictures = false
            CorrectAnswer.isHidden = false
            SecondAnswer.isHidden = false
            ThirdAnswer.isHidden = false
            FourthAnswer.isHidden = false
            CorrectPic.isHidden = true
            SecondPic.isHidden = true
            ThirdPic.isHidden = true
            FourthPic.isHidden = true
            
        }
    }
    
    @IBAction func addQ(_ sender: UIButton) {
        
        let index = subjectArray.firstIndex(of: Subject.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newQ = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context)
        newQ.setValue(subjectIDArray[index!], forKey: "subject")
        newQ.setValue(Question.text, forKey: "q")
        newQ.setValue(hasPictures, forKey: "hasPics")
        if hasPictures {
            let dataC = CorrectPic.image!.jpegData(compressionQuality: 0.5)
            newQ.setValue(dataC, forKey: "correct")
            let dataA2 = SecondPic.image!.jpegData(compressionQuality: 0.5)
            newQ.setValue(dataA2, forKey: "answer2")
            let dataA3 = ThirdPic.image!.jpegData(compressionQuality: 0.5)
            newQ.setValue(dataA3, forKey: "answer3")
            let dataA4 = FourthPic.image!.jpegData(compressionQuality: 0.5)
            newQ.setValue(dataA4, forKey: "answer4")
            
        } else {
            let dataC = Data((CorrectAnswer.text)!.utf8)
            newQ.setValue(dataC, forKey: "correct")
            let dataA2 = Data((SecondAnswer.text)!.utf8)
            newQ.setValue(dataA2, forKey: "answer2")
            let dataA3 = Data((ThirdAnswer.text)!.utf8)
            newQ.setValue(dataA3, forKey: "answer3")
            let dataA4 = Data((FourthAnswer.text)!.utf8)
            newQ.setValue(dataA4, forKey: "answer4")
            
        }
        do {
            try context.save()
            print("Done")
            showSimpleActionSheet()
        } catch  {
            print("Soru eklerken hata")
            showAlertActionSheet()
        }
        
        
        
        
    }
    func showSimpleActionSheet() {
          let alert = UIAlertController(title: "Soru Eklendi", message: "Sorunuz başarıyla eklendi.", preferredStyle: .alert)
       

          alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (_) in
          }))

          self.present(alert, animated: true, completion: {
          })
      }
    func showAlertActionSheet() {
          let alert = UIAlertController(title: "Soru Eklenemedi", message: "Lütfen girdileri kontrol ediniz", preferredStyle: .alert)
       

          alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (_) in
          }))

          self.present(alert, animated: true, completion: {
          })
      }
    
    func createSubjectPicker() {
        let subjectPicker = UIPickerView()
        subjectPicker.delegate = self
        
        Subject.inputView = subjectPicker
    }
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(StartViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        Subject.inputAccessoryView = toolbar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func pullSubjects() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
             
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")
        fetchRequest.returnsObjectsAsFaults = false
             
        do {
            let results = try context.fetch(fetchRequest)
                
            for result in results as! [NSManagedObject] {
                     
                if let name = result.value(forKey: "name") as? String {
                    subjectArray.append(name)
                }
                if let id = result.value(forKey: "id") as? Int {
                    subjectIDArray.append(id)
                }
            }
        } catch  {
            print("Error")
        }
    }
    

}
extension AddQViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjectArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjectArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectSelection = subjectArray[row]
        Subject.text = subjectSelection
    }
    
    
}
