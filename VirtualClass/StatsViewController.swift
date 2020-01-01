//
//  StatsViewController.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 22.12.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit
import CoreData
import Charts

class StatsViewController: UIViewController {
    @IBOutlet weak var barChart: BarChartView!
    
    @IBOutlet weak var toDateButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    var subjectProgress = [Int]()
    var subjectID = [Int]()
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDateButton.layer.cornerRadius = 25
        backButton.layer.cornerRadius = 50
        
        pullProgress()
        updateChart()
        print(subjectID)
        
      
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
    //        gradient
            createGradientView()
          
            
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
    
    func updateChart() {
        
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(subjectProgress[0]))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(subjectProgress[1]))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(subjectProgress[2]))
        let entry4 = BarChartDataEntry(x: 4.0, y: Double(subjectProgress[3]))
        let entry5 = BarChartDataEntry(x: 5.0, y: Double(subjectProgress[4]))
        let entry6 = BarChartDataEntry(x: 6.0, y: Double(subjectProgress[5]))
        let entry7 = BarChartDataEntry(x: 7.0, y: Double(subjectProgress[6]))
        let entry8 = BarChartDataEntry(x: 8.0, y: Double(subjectProgress[7]))
        let entry9 = BarChartDataEntry(x: 9.0, y: Double(subjectProgress[8]))
        let entry10 = BarChartDataEntry(x: 10.0, y: Double(subjectProgress[9]))
        let entry11 = BarChartDataEntry(x: 11.0, y: Double(subjectProgress[10]))
        let entry12 = BarChartDataEntry(x: 12.0, y: Double(subjectProgress[11]))
        let dataSet = BarChartDataSet(entries: [entry1], label: "Çarpanlar ve Katlar")
        let dataSet2 = BarChartDataSet(entries:  [entry2], label: "Üslü İfadeler")
        let dataSet3 = BarChartDataSet(entries:  [entry3], label: "Kareköklü İfadeler")
        let dataSet4 = BarChartDataSet(entries:  [entry4], label: "Veri Analizi")
        let dataSet5 = BarChartDataSet(entries:  [entry5], label: "Basit Olayların Olma Olasılığı")
        let dataSet6 = BarChartDataSet(entries:  [entry6], label: "Cebirsel İfadeler ve Özdeşlikler")
        let dataSet7 = BarChartDataSet(entries:  [entry7], label: "Doğrusal Denklemler")
        let dataSet8 = BarChartDataSet(entries:  [entry8], label: "Eşitsizlikler")
        let dataSet9 = BarChartDataSet(entries:  [entry9], label: "Üçgenler")
        let dataSet10 = BarChartDataSet(entries:  [entry10], label: "Eşlik ve Benzerlik")
        let dataSet11 = BarChartDataSet(entries:  [entry11], label: "Dönüşüm Geometrisi")
        let dataSet12 = BarChartDataSet(entries:  [entry12], label: "Geometrik Cisimler")
        dataSet.colors = [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)]
        dataSet2.colors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
        dataSet3.colors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
        dataSet4.colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
        dataSet5.colors = [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
        dataSet6.colors = [#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)]
        dataSet7.colors = [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]
        dataSet8.colors = [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
        dataSet9.colors = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
        dataSet10.colors = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]
        dataSet11.colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
        dataSet12.colors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
        let data = BarChartData(dataSets: [dataSet, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6, dataSet7, dataSet8, dataSet9, dataSet10, dataSet11, dataSet12])
        
        barChart.data = data
    
       
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
    
    
    
    
       

   
}
