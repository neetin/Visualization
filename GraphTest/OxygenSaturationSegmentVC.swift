//
//  OxygenSaturationSegmentVC.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/14/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts


class OxygenSaturationSegmentVC: UIViewController {

  
  @IBOutlet weak var chartView: LineChartView!
  let minTarget: Double = 85
  let maxTarget: Double = 92
  
  weak var axisFormatDelegate: IAxisValueFormatter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    axisFormatDelegate = self
    drawLineChart(dataPoints: DataCollection.getDayShiftLabels(), values: DataCollection.getOxygenSaturationData(withIndex: 0))
  }
  
  func drawLineChart(dataPoints: [String], values: [Double]) {
    chartView.noDataText = "You need to provide data for the chart."
    
    var dataEntries: [ChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      dataEntries.append(ChartDataEntry(x: Double(i), y: values[i]))
    }
    let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
    let chartData = LineChartData(dataSet: lineChartDataSet)
    chartView.data = chartData
    chartView.chartDescription?.text = ""
    
    let xAxis = chartView.xAxis
    xAxis.valueFormatter = axisFormatDelegate
    xAxis.granularityEnabled = true
    xAxis.granularity = 12
    xAxis.labelPosition = .bottom
    
    // zooming feature
    chartView.zoom(scaleX: 3.5, scaleY: 0, x: 0, y: 0)// zoom so that the values can be shown
    // no user zooming
    chartView.scaleXEnabled = false
    chartView.scaleYEnabled = false
    // no highlight on tap
    chartView.highlightPerTapEnabled = false
    
    //        chartView.leftAxis.enabled = false
    //        chartView.rightAxis.enabled = false
    
    chartView.drawBordersEnabled = true
    chartView.borderColor = UIColor.black
    chartView.legend.enabled = false
    
    lineChartDataSet.circleColors = [UIColor.blue]
    lineChartDataSet.drawCircleHoleEnabled = false
    lineChartDataSet.circleRadius = 4
    lineChartDataSet.colors = [UIColor.blue]
    lineChartDataSet.valueColors = [UIColor.red]
    lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 12)
    
    // Limit line
    let yAxis = chartView.getAxis(.right)
    let maxLine = ChartLimitLine(limit: maxTarget, label: String(maxTarget))
    maxLine.labelPosition = .leftTop
    maxLine.lineDashLengths = [CGFloat(15)]
    maxLine.lineColor = UIColor.red
    maxLine.lineWidth = 4
    maxLine.valueTextColor = UIColor.black
    yAxis.addLimitLine(maxLine)
    
    let minLine = ChartLimitLine(limit: minTarget, label: String(minTarget))
    minLine.labelPosition = .leftBottom
    minLine.lineDashLengths = [CGFloat(15)]
    minLine.lineColor = UIColor.red
    minLine.lineWidth = 4
    minLine.valueTextColor = UIColor.black
    yAxis.addLimitLine(minLine)
    
  }
  
}

extension OxygenSaturationSegmentVC: IAxisValueFormatter {
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return DataCollection.getDayShiftLabels()[Int(value)]
  }
}
