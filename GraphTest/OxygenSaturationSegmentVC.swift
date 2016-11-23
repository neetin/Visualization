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
  var didAppear = false
  var customView : CustomView!
  
  let targetValueColor = UIColor(colorLiteralRed: 180/255, green: 155/255, blue: 224/255, alpha: 1)
  let lineColor = UIColor(colorLiteralRed: 178/255, green: 152/255, blue: 223/255, alpha: 1)
  
  weak var axisFormatDelegate: IAxisValueFormatter?
  var valueFormatter: IValueFormatter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    axisFormatDelegate = self
    valueFormatter = self
    drawLineChart(dataPoints: DataCollection.getDayShiftLabels(), values: DataCollection.getOxygenSaturationData(withIndex: 0))
  }
    
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if didAppear {
        let rectForView = getPosition()
        customView.frame = rectForView
    }
  }
    
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let rectForView = getPosition()
    customView = CustomView(frame: rectForView)//(frame: CGRect(x: 22.1582, y: 121.88, width: chartView.frame.width - 44.3164, height: 200.81))
    customView.backgroundColor = UIColor.clear
    chartView.insertSubview(customView, at: 0)
    didAppear = true
  }
  
  func drawLineChart(dataPoints: [String], values: [Double]) {
    chartView.noDataText = "You need to provide data for the chart."
    chartView.enableCustomLabel = true
    chartView.targetValueForLabel = minTarget
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
    xAxis.labelTextColor = UIColor.gray
    xAxis.labelFont = UIFont.systemFont(ofSize: 16)
    
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
    
    lineChartDataSet.circleColors = [lineColor]
    lineChartDataSet.drawCircleHoleEnabled = false
    lineChartDataSet.circleRadius = 4
    lineChartDataSet.colors = [lineColor]
    lineChartDataSet.valueColors = [UIColor.black]
    lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 16, weight: 4)
    lineChartDataSet.valueFormatter = valueFormatter
    lineChartDataSet.lineWidth = 2
    
    // Limit line
    let yAxis = chartView.getAxis(.right)
    let maxLine = ChartLimitLine(limit: maxTarget, label: String.localizedStringWithFormat("%.0f", maxTarget))
    maxLine.labelPosition = .leftTop
    maxLine.lineDashLengths = [CGFloat(15)]
    maxLine.lineColor = lineColor
    maxLine.lineWidth = 4
    maxLine.valueTextColor = lineColor
    yAxis.addLimitLine(maxLine)
    
    chartView.drawBordersEnabled = true
    chartView.borderColor = UIColor.gray
    chartView.getAxis(.right).labelTextColor = UIColor.gray
    chartView.getAxis(.right).labelFont = UIFont.systemFont(ofSize: 16)
    chartView.getAxis(.right).gridColor = UIColor.gray
    
    chartView.getAxis(.left).labelTextColor = UIColor.gray
    chartView.getAxis(.left).gridColor = UIColor.gray
    chartView.getAxis(.left).labelFont = UIFont.systemFont(ofSize: 16)
    
    let minLine = ChartLimitLine(limit: minTarget, label: String.localizedStringWithFormat("%.0f", minTarget))
    minLine.labelPosition = .leftBottom
    minLine.lineDashLengths = [CGFloat(15)]
    minLine.lineColor = lineColor
    minLine.lineWidth = 4
    minLine.valueTextColor = lineColor
    yAxis.addLimitLine(minLine)
    
  }
    
  func getPosition() -> CGRect {
    var positions: [CGPoint] = []
    let yAxis = chartView.getAxis(.right)
    let transformer = chartView.getTransformer(forAxis: .right)
    
    var limitLines = yAxis.limitLines
    let trans = transformer.valueToPixelMatrix
    
    var position = CGPoint(x: 0.0, y: 0.0)
    
    for i in 0 ..< limitLines.count
    {
        let l = limitLines[i]
        
        if !l.isEnabled
        {
            continue
        }
        
        position.x = 0.0
        position.y = CGFloat(l.limit)
        position = position.applying(trans)
        positions.append(position)
    }
    let positionX = positions[0].x
    var positionY: CGFloat = 0
    var height: CGFloat = 0
    if positions[0].y < positions[1].y {
        positionY = positions[0].y
        height = positions[1].y - positions[0].y
    } else {
        positionY = positions[1].y
        height = positions[0].y - positions[1].y
    }
    let rect = CGRect(x: positionX, y: positionY, width: chartView.frame.width - (2 * positionX), height: height)
    return rect
  }

  
}

extension OxygenSaturationSegmentVC: IAxisValueFormatter {
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return DataCollection.getDayShiftLabels()[Int(value)]
  }
}

extension OxygenSaturationSegmentVC: IValueFormatter {
    
  func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    return String.localizedStringWithFormat("%.0f", entry.y)
  }
}
