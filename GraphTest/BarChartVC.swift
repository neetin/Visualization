//
//  BarChartVC.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/10/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class BarChartVC: UIViewController {
  @IBOutlet weak var barChartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        drawLineChart(DataValues.months)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  func drawLineChart(_ dataPoints: [String]) {
    barChartView.noDataText = "You need to provide data for the chart."
    
    let values: [Double] = [4, 3, 5, 6, 2, 7, 8, 10, 12, 12, 11, 15]
    
    
    var dataEntries: [BarChartDataEntry] = []
    
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
      dataEntries.append(dataEntry)
    }
    
    
    let barChartDataSet = BarChartDataSet(values: dataEntries, label: "Company 2")
    barChartDataSet.colors = [UIColor.green]
    
    
    
    
    barChartView.data = BarChartData(dataSet: barChartDataSet)
    
    barChartView.backgroundColor = UIColor.gray
    barChartView.drawGridBackgroundEnabled = true
    barChartView.gridBackgroundColor = UIColor.yellow

  }
}
