
//
//  ViewController.swift
//  Core Animations
//
//  Created by Bilguun Batbold on 29/3/19.
//  Copyright © 2019 Bilguun. All rights reserved.
//
import UIKit
import AVFoundation
import CoreData

class ExamViewController: UIViewController, CAAnimationDelegate {
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet var Buttons: [UIButton]!
    
    @IBOutlet weak var question: UILabel!
    
     @IBOutlet weak var countdownProgressBar: CountdownProgressBar!
    
    @IBOutlet weak var questionBL: UIButton!
    
    var subjects = [Int]()
    var questions = [String]()
    var hasPics = [Bool]()
    var correctAnswers = [String]()
    var secondAnswers = [String]()
    var thirdAnswers = [String]()
    var fourthAnswers = [String]()
    var correctPics = [UIImage]()
    var answer2Pics = [UIImage]()
    var answer3Pics = [UIImage]()
    var answer4Pics = [UIImage]()
    
    var subjectProgress = [Int]()
    var subjectID = [Int]()
    
    var currHasPics = false
    
    var rigthAnswer = false
    
    var usedIndex = [Int]()
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
 
    var answers = [""]
    var answersPics = [UIImage]()
    var indexses = [0,1,2,3]
    
    var currIndex = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullQs()
        pullProgress()
//        Buttonların Köşelerinin kıvrılması
        for button in Buttons {
            button.layer.cornerRadius = 25
        }
        currIndex = getUniqueIndex()
        prepareQ(indexOfQ: currIndex)
       
//       Multiline için olan lanetli kod. herhalde? asıl nokta constrait eklemekte. sanırım
        question.numberOfLines = 0
        questionBL.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        Sayaç için 10 dk
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        gradient
        createGradientView()
//        sayaç animasyonu
        countdownProgressBar.startCoundown(duration: 600, showPulse: true)
//        soru hazırla
      
        
    }
    
    
    
    func createGradientView() {
        
        gradientSet.append([colorOne, colorTwo])

        
        // set the gradient size to be the entire screen
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        
    }
   
    
    func prepareQ(indexOfQ: Int) {
        
//        kaç soru sorulacağı
        if correctQNumber + wrongQNumber >= 10 {
            addScore()
            performSegue(withIdentifier: "toEndVC", sender: nil)
        }
        else {
            
            answers.removeAll()
            answersPics.removeAll()
                    // Cevapları Hazırla
            if hasPics[indexOfQ] {
                
                answersPics.append(correctPics[indexOfQ])
                answersPics.append(answer2Pics[indexOfQ])
                answersPics.append(answer3Pics[indexOfQ])
                answersPics.append(answer4Pics[indexOfQ])
//                indexleri karıştır
                indexses.shuffle()
                
//                Buttonlara cevapları koy
                for i in 0...3 {
                    Buttons[i].setTitle(nil, for: .normal)
                    Buttons[i].setBackgroundImage(answersPics[indexses[i]], for: .normal)
                            
                }
                
            }
            if !hasPics[indexOfQ] {
                
                
                answers.append(correctAnswers[indexOfQ])
                answers.append(secondAnswers[indexOfQ])
                answers.append(thirdAnswers[indexOfQ])
                answers.append(fourthAnswers[indexOfQ])
                
//                indexleri karıştır
                indexses.shuffle()
                
//                Buttonlara cevapları koy
                for i in 0...3 {
                    Buttons[i].setTitle(answers[indexses[i]], for: .normal)
                    Buttons[i].setBackgroundImage(nil, for: .normal)
                            
                }
            }
            

    //        Soruyu Labela koy
//            question.text = questions[indexOfQ]
            questionBL.setTitle(questions[indexOfQ], for: .normal)
        }
        
        
    }
    func getUniqueIndex() -> Int {
        var number = Int.random(in: 0 ... questions.count - 1)
        while usedIndex.contains(number) {
            number = Int.random(in: 0 ... questions.count - 1)
        }
        var minProgress = 0
        print(subjects[number])
        print(subjectID)
        let index = subjectID.firstIndex(of: subjects[number])
        while minProgress < 10 {
            if subjectProgress[index!] > minProgress {
                minProgress += 2
                number = Int.random(in: 0 ... questions.count - 1)
                while usedIndex.contains(number) {
                    number = Int.random(in: 0 ... questions.count - 1)
                }
            }
            else {
                break
            }
        }
        
        
        usedIndex.append(number)
        
        return number
    }
//    kaç dakika olduğu burda
    var countdown = 600
    @objc func updateCounter() {
        //example functionality
        if countdown > 0 {
            countdown -= 1
        }
        if countdown == 0 {
            addScore()
            performSegue(withIdentifier: "toEndVC", sender: nil)
        }
    }
    
    var correctQNumber = 0
    var wrongQNumber = 0
   
    @IBAction func Answered(_ sender: UIButton) {
        
        
        
        if !hasPics[currIndex] {
            if sender.title(for: .normal) == correctAnswers[currIndex] {
                rigthAnswer = true
            } else {
                rigthAnswer = false
            }
        }

        else if hasPics[currIndex] {
            if sender.backgroundImage(for: .normal) == correctPics[currIndex] {
                rigthAnswer = true
            } else {
                rigthAnswer = false
            }
        }
        
        if rigthAnswer {
            //TODO: Veri tabanı bağlandığında öğrenim durumunu update etmesi gerek
            correctQNumber += 1
            sender.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)

            SoundPlayer.shared.start(sound: "correct")
            updateProgress(thisSubject: subjects[currIndex])
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                print("entered")
                self.currIndex = self.getUniqueIndex()
                self.prepareQ(indexOfQ: self.currIndex)
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.4710169435, blue: 1, alpha: 1)
            }
        }
        else {
            //TODO: Veri tabanı bağlandığında öğrenim durumunu update etmesi gerek
            wrongQNumber += 1
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
            SoundPlayer.shared.start(sound: "wrong")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.currIndex = self.getUniqueIndex()
                self.prepareQ(indexOfQ: self.currIndex)
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.4710169435, blue: 1, alpha: 1)
           
            }
        }
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEndVC" {
            let nextVC = segue.destination as! EndViewController
            nextVC.corrects = "Doğru Sayısı: \(correctQNumber)"
            nextVC.wrongs = "Yanlş Sayısı : \(wrongQNumber)"
            nextVC.time = "Sınav Süresi: \(600 - countdown) sn"
            if (correctQNumber + wrongQNumber) < 10 {
                nextVC.done = false
            }
            else {
                nextVC.done = true
            }
            nextVC.stars = Double(correctQNumber)
        }
    }
    
    func pullQs() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
             
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
                
            for result in results as! [NSManagedObject] {
                
                if let subject = result.value(forKey: "subject") as? Int {
                    subjects.append(subject)
                }
                
                if let q = result.value(forKey: "q") as? String {
                    questions.append(q)
                }
                
                if let hasPic = result.value(forKey: "hasPics") as? Bool {
                    hasPics.append(hasPic)
                    currHasPics = hasPic
                }
                
                let correctData = result.value(forKey: "correct") as? Data
                  
                let answer2Data = result.value(forKey: "answer2") as? Data
                
                let answer3Data = result.value(forKey: "answer3") as? Data
                
                let answer4Data = result.value(forKey: "answer4") as? Data
                
                if currHasPics {
                    
                    if let correct = UIImage(data: correctData!) {
                        correctPics.append(correct)
                    }
                    if let answer2 = UIImage(data: answer2Data!) {
                        answer2Pics.append(answer2)
                    }
                    if let answer3 = UIImage(data: answer3Data!) {
                        answer3Pics.append(answer3)
                    }
                    if let answer4 = UIImage(data: answer4Data!) {
                        answer4Pics.append(answer4)
                    }
                    
                    correctAnswers.append("error")
                    secondAnswers.append("error")
                    thirdAnswers.append("error")
                    fourthAnswers.append("error")
                    
                    
                } else {
                    if let correct = String(data: correctData!, encoding: .utf8) {
                        correctAnswers.append(correct)
                    }
                    if let answer2 = String(data: answer2Data!, encoding: .utf8) {
                        secondAnswers.append(answer2)
                    }
                    if let answer3 = String(data: answer3Data!, encoding: .utf8) {
                        thirdAnswers.append(answer3)
                    }
                    if let answer4 = String(data: answer4Data!, encoding: .utf8) {
                        fourthAnswers.append(answer4)
                    }
                    
                    correctPics.append(#imageLiteral(resourceName: "select"))
                    answer2Pics.append(#imageLiteral(resourceName: "select"))
                    answer3Pics.append(#imageLiteral(resourceName: "select"))
                    answer4Pics.append(#imageLiteral(resourceName: "select"))
                }
                
                
            }
        } catch  {
            print("Error pulling q")
        }
        
        
    }
    
    func pullProgress() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
             
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Progress")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "studentID = %@", String(currentUser.id))
        
         do {
                   let results = try context.fetch(fetchRequest)
                   
                   for result in results as! [NSManagedObject] {
                       
                       if let subprog = result.value(forKey: "currentProgress") as? Int {
                        subjectProgress.append(subprog)
                       }
                       if let subid = result.value(forKey: "subjectID") as? Int {
                        subjectID.append(subid)
                       }
                   }
               } catch  {
                   print("Error")
               }
    }
    
    func updateProgress(thisSubject: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
             
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Progress")
        fetchRequest.returnsObjectsAsFaults = false
        let idPredicate = NSPredicate(format: "studentID = %@", String(currentUser.id))
        let subjectPredicate = NSPredicate(format: "subjectID = %@", String(thisSubject))
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [idPredicate, subjectPredicate])
        fetchRequest.predicate = andPredicate
        
         do {
            
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                var newProg = 10
                if let subprog = result.value(forKey: "currentProgress") as? Int {
                    if subprog < 10 {
                        newProg = subprog + 1
                    }
                }
                 
                result.setValue(newProg, forKey: "currentProgress")
            
            }
            
            try context.save()
         } catch  {
                   print("Error")
        }
        
    }
    
    func addScore() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context)
        
        let score = correctQNumber * 10
        newUser.setValue(Date(), forKey: "date")
        newUser.setValue(score, forKey: "score")
        newUser.setValue(currentUser.id, forKey: "studentID")
    
        do {
            try context.save()
            print("Done")
        } catch  {
            print("Error")
        }
    }
    
}



