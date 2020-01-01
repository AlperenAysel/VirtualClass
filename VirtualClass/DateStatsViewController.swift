//
//  DateStatsViewController.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 24.12.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import UIKit
import Charts
import CoreData

class DateStatsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sortButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    var mm = 1
    var yy = 2019
    
    var dates = [Date]()
    var scores = [Int]()
    
    var formattedDates = [Int]()
    
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let colorOne = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if Int(pickerData[component][row])! < 13 {
            mm = Int(pickerData[component][row])!
        } else {
            yy = Int(pickerData[component][row])!
        }
    
       }
    
    @IBOutlet weak var mmmm: UIPickerView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var pickerData: [[String]] = [[String]]()




    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortButton.layer.cornerRadius = 25
        backButton.layer.cornerRadius = 50
        
        self.mmmm.delegate = self
        self.mmmm.dataSource = self
        
        pickerData = [["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
                      ["2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029"]
        ]
        pullUsers()
        reformatDates()
        checkForDays()
        setChartValue()
        
        

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
    
    func setChartValue() {
        let vals1 = ChartDataEntry(x: Double(formattedDates[0]), y: Double(scores[0]))
        let vals2 = ChartDataEntry(x: Double(formattedDates[1]), y: Double(scores[1]))
        let vals3 = ChartDataEntry(x: Double(formattedDates[2]), y: Double(scores[2]))
        let vals4 = ChartDataEntry(x: Double(formattedDates[3]), y: Double(scores[3]))
        let vals5 = ChartDataEntry(x: Double(formattedDates[4]), y: Double(scores[4]))
        let vals6 = ChartDataEntry(x: Double(formattedDates[5]), y: Double(scores[5]))
        let vals7 = ChartDataEntry(x: Double(formattedDates[6]), y: Double(scores[6]))
        let vals8 = ChartDataEntry(x: Double(formattedDates[7]), y: Double(scores[7]))
        let vals9 = ChartDataEntry(x: Double(formattedDates[8]), y: Double(scores[8]))
        let vals10 = ChartDataEntry(x: Double(formattedDates[9]), y: Double(scores[9]))
        let vals11 = ChartDataEntry(x: Double(formattedDates[10]), y: Double(scores[10]))
        let vals12 = ChartDataEntry(x: Double(formattedDates[11]), y: Double(scores[11]))
        let vals13 = ChartDataEntry(x: Double(formattedDates[12]), y: Double(scores[12]))
        let vals14 = ChartDataEntry(x: Double(formattedDates[13]), y: Double(scores[13]))
        let vals15 = ChartDataEntry(x: Double(formattedDates[14]), y: Double(scores[14]))
        let vals16 = ChartDataEntry(x: Double(formattedDates[15]), y: Double(scores[15]))
        let vals17 = ChartDataEntry(x: Double(formattedDates[16]), y: Double(scores[16]))
        let vals18 = ChartDataEntry(x: Double(formattedDates[17]), y: Double(scores[17]))
        let vals19 = ChartDataEntry(x: Double(formattedDates[18]), y: Double(scores[18]))
        let vals20 = ChartDataEntry(x: Double(formattedDates[19]), y: Double(scores[19]))
        let vals21 = ChartDataEntry(x: Double(formattedDates[20]), y: Double(scores[20]))
        let vals22 = ChartDataEntry(x: Double(formattedDates[21]), y: Double(scores[21]))
        let vals23 = ChartDataEntry(x: Double(formattedDates[22]), y: Double(scores[22]))
        let vals24 = ChartDataEntry(x: Double(formattedDates[23]), y: Double(scores[23]))
        let vals25 = ChartDataEntry(x: Double(formattedDates[24]), y: Double(scores[24]))
        let vals26 = ChartDataEntry(x: Double(formattedDates[25]), y: Double(scores[25]))
        let vals27 = ChartDataEntry(x: Double(formattedDates[26]), y: Double(scores[26]))
        let vals28 = ChartDataEntry(x: Double(formattedDates[27]), y: Double(scores[27]))
        let vals29 = ChartDataEntry(x: Double(formattedDates[28]), y: Double(scores[28]))
        let vals30 = ChartDataEntry(x: Double(formattedDates[29]), y: Double(scores[29]))
      
        
        let set = LineChartDataSet(entries: [vals1,vals2,vals3,vals4,vals5,vals6,vals7,vals8,vals9,vals10,vals11,vals12,vals13,vals14,vals15,vals16,vals17, vals18,vals19,vals20,vals21,vals22,vals23,vals24,vals25,vals26,vals27,vals28,vals29,vals30], label: "Dates")
        let data = LineChartData(dataSet: set)
        
        self.lineChartView.data = data
        
    }
    
    func pullUsers() {
        
        let calender = Calendar.current

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "studentID = %@", String(currentUser.id))
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let reDate = result.value(forKey: "date") as? Date {
                    let month = calender.component(.month, from: reDate)
                    let year = calender.component(.year, from: reDate)
                    if month == mm, year == yy {
                        dates.append(reDate)
                    } else {
                        continue
                    }
                }
                if let reScore = result.value(forKey: "score") as? Int {
                    scores.append(reScore)
                }
                
            }
        } catch  {
            print("Error")
        }
        
    }
    func reformatDates() {
        
        let calender = Calendar.current
        
        for date in dates {
            let m = calender.component(.month, from: date)
            formattedDates.append(m)
            
        }
    }
    
    func checkForDays () {
        
        if formattedDates.count >= 30 {
            return
        }
        
        for index in 1...30 {
            if formattedDates.contains(index) {
//                has that day
            } else {
            formattedDates.append(index)
            scores.append(0)
            }
        }
        
    }

    @IBAction func getScoresByDate(_ sender: UIButton) {
        dates.removeAll()
        scores.removeAll()
        formattedDates.removeAll()
        
        pullUsers()
        reformatDates()
        checkForDays()
        setChartValue()
        
        
    }
}
