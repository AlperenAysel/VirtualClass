
//
//  ViewController.swift
//  Core Animations
//
//  Created by Bilguun Batbold on 29/3/19.
//  Copyright © 2019 Bilguun. All rights reserved.
//
import UIKit

class StudentViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var Buttons: [UIButton]!
    
    @IBOutlet weak var welcome: UILabel!
    var name = MyVariables.name
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    // colors to be added to the set
    let colorOne = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcome.text = "Hoşgeldin \(name)"
        for button in Buttons {
            button.layer.cornerRadius = 25
        }
        backButton.layer.cornerRadius = 50
        
       
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
    @IBAction func istClicked(_ sender: UIButton) {
        sender.setImage(nil, for: .normal)
        sender.coverTheScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.performSegue(withIdentifier: "toStatsVC", sender: nil)
        }
        
    }
}



