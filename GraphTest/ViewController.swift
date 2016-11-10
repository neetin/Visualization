//
//  ViewController.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/8/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts


struct DataValues {
  static let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  static let unitSold = [20.0, 0.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
}

class ViewController: UIViewController {
  @IBOutlet weak var chartView: BubbleChartView!

  weak var axisFormatDelegate: IAxisValueFormatter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    axisFormatDelegate = self
    drawLineChart(DataValues.months, values: DataValues.unitSold)
  }
  
  func drawLineChart(_ dataPoints: [String], values: [Double]) {
    chartView.noDataText = "You need to provide data for the chart."
    var dataEntries: [ChartDataEntry] = []
    for i in 0..<dataPoints.count {
      let dataEntry = BubbleChartDataEntry(x: Double(i + 1), y: values[i], size: 1)
      
      dataEntries.append(dataEntry)
    }
    
    let bubbleChartDataSet = BubbleChartDataSet(values: dataEntries, label: "Units Sold")
    let chartData = BubbleChartData(dataSet: bubbleChartDataSet)
    
    chartView.data = chartData
    chartView.chartDescription?.text = ""
    
    let xaxis = chartView.xAxis
    xaxis.valueFormatter = axisFormatDelegate
    
    
    bubbleChartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
    
    chartView.backgroundColor = UIColor.yellow
    chartView.drawGridBackgroundEnabled = true
    chartView.gridBackgroundColor = UIColor.green
    
    chartView.rightAxis.inverted = false
    chartView.leftAxis.inverted = false
    
    chartView.drawBordersEnabled = true
    chartView.borderColor = UIColor.black
    
    bubbleChartDataSet.colors = ChartColorTemplates.liberty()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

  // MARK: axisFormatDelegate
  extension ViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
      return DataValues.months[Int(value) - 1]
    }
}
