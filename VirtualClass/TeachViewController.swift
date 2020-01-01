//
//  TeachViewController.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 28.11.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit

class TeachViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var welcomeMS: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    var name = MyVariables.name
    
    
    let gradient = CAGradientLayer()
    
    var gradientSet = [[CGColor]]()
   
    var currentGradient: Int = 0
    
    
    let colorOne = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeMS.text = "Hoşgeldin \(name)"
        addButton.layer.cornerRadius = 25
        backButton.layer.cornerRadius = 50

        
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

}
