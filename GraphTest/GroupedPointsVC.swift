//
//  GroupedPointsVC.swift
//  GraphView
//
//  Created by Sujan Vaidya on 11/8/16.
//  Copyright © 2016 Sujan Vaidya. All rights reserved.
//

import UIKit
import Charts

// TODO
class GroupedPointsVC: UIViewController {
  
  let minTarget: Double = 4
  let maxTarget: Double = 24
  
  @IBOutlet var chartView: LineChartView!

  weak var axisFormatDelegate: IAxisValueFormatter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    axisFormatDelegate = self
    
    drawLineChart(dataPoints: DataValue.timeLabel, values: DataValue.newValues)
  }
  
  func drawLineChart(dataPoints: [String], values: [Double]) {
    chartView.noDataText = "You need to provide data for the chart."
    
    var dataEntries: [ChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
        dataEntries.append(ChartDataEntry(x: Double(i), y: values[i]))
    }
    let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
    let chartData = LineChartData(dataSet: lineChartDataSet)
    chartView.data = chartData
    
    let xAxis = chartView.xAxis
    xAxis.valueFormatter = axisFormatDelegate
    xAxis.granularityEnabled = true
    xAxis.granularity = 12
    
    // zooming feature
    chartView.zoom(scaleX: 2, scaleY: 0, x: 0, y: 0)// zoom so that the values can be shown
    // no user zooming
    chartView.scaleXEnabled = false
    chartView.scaleYEnabled = false
    // no highlight on tap
    chartView.highlightPerTapEnabled = false
    
    chartView.leftAxis.enabled = false
    chartView.rightAxis.enabled = false
    
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
    let maxLine = ChartLimitLine(limit: maxTarget, label: "Max blood pressure")
    maxLine.labelPosition = .leftTop
    maxLine.lineDashLengths = [CGFloat(15)]
    maxLine.lineColor = UIColor.red
    maxLine.lineWidth = 4
    maxLine.valueTextColor = UIColor.black
    yAxis.addLimitLine(maxLine)
    
    let minLine = ChartLimitLine(limit: minTarget, label: "Min blood pressure")
    minLine.labelPosition = .leftBottom
    minLine.lineDashLengths = [CGFloat(15)]
    minLine.lineColor = UIColor.red
    minLine.lineWidth = 4
    minLine.valueTextColor = UIColor.black
    yAxis.addLimitLine(minLine)
      
  }
  
}

extension GroupedPointsVC: IAxisValueFormatter {
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return DataValue.timeLabel[Int(value)]
  }
}
