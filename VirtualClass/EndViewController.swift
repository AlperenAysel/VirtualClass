//
//  EndViewController.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 26.11.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit

class EndViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var numberOfWrongs: UILabel!
    
    @IBOutlet weak var numberOfCorrects: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var endImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var starCountLabel: UILabel!
    
    @IBOutlet weak var skullCountLabel: UILabel!
    
    @IBOutlet weak var hourGlassLabel: UILabel!
    var time = ""
    var corrects = ""
    var wrongs = ""
    var done = false
    var stars : Double = 0
    var score = Int()
    var star = 0
    var skull = 0
    let gradient = CAGradientLayer()
       
       // list of array holding 2 colors
       var gradientSet = [[CGColor]]()
       // current gradient index
       var currentGradient: Int = 0
       
       // colors to be added to the set
       let colorOne = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
       let colorTwo = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
       let colorThree = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
       let colorFour = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).cgColor
       let colorFive = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score = Int(stars) * 10
        print(score)
        star = Int(stars) / 2
        skull = Int(10 - stars) / 2
        print(star, skull)
        if done {
            endImage.image = UIImage(named: "examEnd")
            hourGlassLabel.text = "⏳"
        }
        else {
            endImage.image = UIImage(named: "timeEnd")
            hourGlassLabel.text = "⌛️"
        }
        
        starCountLabel.text = starsAndSkulls(Count: star, isStar: true)
        skullCountLabel.text = starsAndSkulls(Count: skull, isStar: false)

        numberOfCorrects.text = corrects
        numberOfWrongs.text = wrongs
        totalTime.text = time
        
        backButton.layer.cornerRadius = 60
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createGradientView()
    }
    
    func starsAndSkulls(Count: Int, isStar: Bool) -> String {
        var ourString = ""
        if isStar {
            if Count != 0 {
                for _ in 0...Count - 1 {
                    ourString += "⭐️"
                }
            }
            else {
                ourString = " "
            }
        }
        else {
            if Count != 0 {
                for _ in 0...Count - 1  {
                    ourString += "☠️"
                }
            }
            else {
                ourString = " "
            }
        }
        return ourString
        
    }
    
    func createGradientView() {
        
        // overlap the colors and make it 3 sets of colors
        gradientSet.append([colorOne, colorTwo])
        gradientSet.append([colorTwo, colorThree])
        gradientSet.append([colorThree, colorFour])
        gradientSet.append([colorFour, colorFive])
        
       
        
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
        
        // animate over 3 seconds
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 0.5
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

}
