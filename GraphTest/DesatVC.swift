//
//  DesatVC.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/21/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class DesatVC: UIViewController {

  let dayColor = UIColor(colorLiteralRed: 180/255, green: 154/255, blue: 224/255, alpha: 0.6)//UIColor(hex: "cbebf7")
  let nightColor = UIColor(colorLiteralRed: 59/255, green: 178/255, blue: 226/255, alpha: 0.6)//UIColor(hex: "dcccf1")
  let lineColor = UIColor(colorLiteralRed: 14/255, green: 145/255, blue: 200/255, alpha: 1)//UIColor(hex: "28a9df")
//    let borderColor = UIColor(colorLiteralRed: 174/255, green: 204/255, blue: 243/255, alpha: 1)
  let chartBackgroundColor = UIColor(colorLiteralRed: 238/255, green: 238/255, blue: 238/255, alpha: 0.4)
  let highlightColor = UIColor(colorLiteralRed: 162/255, green: 133/255, blue: 214/255, alpha: 0.8)
  @IBOutlet weak var chartView: CombinedChartView!
  weak var valueFormatter: IAxisValueFormatter!
  weak var customValueFormatter: IValueFormatter!
  
//  var highlightView = HighlightView()
  var insightIndex = 0
  var insightView: HighlightView!
  var didAppear = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    chartView.delegate = self
    valueFormatter = self
    customValueFormatter = self
    drawLineChart(DataCollection.desaturationLabels)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    addInsightView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if didAppear {
      insightView.frame = calculateHighlightFrame(atPosition: Double(insightIndex), withIndex: insightIndex)
    }
  }

  func drawLineChart(_ dataPoints: [String]) {
    chartView.noDataText = "You need to provide data for the chart."
    chartView.enableCustomXEntries = true
    chartView.valuePosition = .insideCircle
    let values: [Double] = DataCollection.getDesaturationEpisodes()
    
    var dataEntries1: [CandleChartDataEntry] = []
    var dataEntries2: [ChartDataEntry] = []
    
    let minDesatEpisode = values.min()
    var insight = false
    
    for i in 0..<dataPoints.count {
      let dataEntry = CandleChartDataEntry(x: Double(i), shadowH: values[i], shadowL: values[i], open: values[i] - 4, close: values[i] + 4, data: DataCollection.desaturationLabels[i] as AnyObject?)
      dataEntry.y = values[i]
      dataEntries1.append(dataEntry)
    }
    
    for i in 0..<dataPoints.count {
      if values[i] == minDesatEpisode {
        insight = true
        insightIndex = i
      }
      let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: insight as AnyObject?)//ChartDataEntry(x: Double(i), y: values[i])
      dataEntries2.append(dataEntry)
    }
    
    let candleChartDataSet = CandleChartDataSet(values: dataEntries1, label: "Company 1")
    
    candleChartDataSet.colors = [dayColor, nightColor]
    candleChartDataSet.shadowColor = UIColor.clear
//        candleChartDataSet.shadowColorSameAsCandle = true
    candleChartDataSet.drawValuesEnabled = false
//    candleChartDataSet.highlightEnabled = false
    candleChartDataSet.highlightColor = UIColor.clear
    candleChartDataSet.setFill = true
    
    let lineChartDataSet = LineChartDataSet(values: dataEntries2, label: "Company 2")
    lineChartDataSet.colors = [lineColor]
    lineChartDataSet.circleHoleRadius = 0
    lineChartDataSet.circleHoleColor = lineColor
    lineChartDataSet.circleColors = [lineColor]
    lineChartDataSet.circleRadius = 9
    lineChartDataSet.highlightEnabled = false
    lineChartDataSet.valueFormatter = customValueFormatter
    lineChartDataSet.valueColors = [UIColor.white]
    lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 12)
    lineChartDataSet.lineWidth = 4
    
    let rightYAxis = chartView.getAxis(.right)
    rightYAxis.axisMaximum = 30 // based on the desaturation values
    rightYAxis.axisMinimum = 0
    rightYAxis.granularityEnabled = true
    rightYAxis.granularity = 10
    
    rightYAxis.labelTextColor = UIColor.gray
    rightYAxis.labelFont = UIFont.systemFont(ofSize: 16)
    rightYAxis.gridColor = UIColor.gray
    
    let leftYAxis = chartView.getAxis(.left)
    leftYAxis.axisMaximum = 30 // based on the desaturation values
    leftYAxis.axisMinimum = 0
    leftYAxis.granularityEnabled = true
    leftYAxis.granularity = 10
    
    leftYAxis.labelTextColor = UIColor.gray
    leftYAxis.gridColor = UIColor.gray
    leftYAxis.labelFont = UIFont.systemFont(ofSize: 16)

  
    let xAxis = chartView.xAxis
    xAxis.valueFormatter = valueFormatter
    xAxis.labelPosition = .bottom
    
    xAxis.spaceMin = 0.5
    xAxis.spaceMax = 0.5
    xAxis.labelTextColor = UIColor.gray
    xAxis.gridColor = UIColor.gray
    xAxis.labelFont = UIFont.systemFont(ofSize: 16)
    
//        xAxis.axisMinimum = -0.5 // Fixes for candlestick
//        xAxis.axisMaximum = 13.5 // Fixes for candlestick
//        xAxis.forceLabelsEnabled = true
//        xAxis.centerAxisLabelsEnabled = true
//        xAxis.entries = [1.5, 3.5, 5.5, 7.5, 9.5, 11.5]
    //        xAxis.entries = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
    
    let chartData = CombinedChartData()
    chartData.candleData = CandleChartData(dataSet: candleChartDataSet)
    chartData.lineData = LineChartData(dataSet: lineChartDataSet)
    chartView.data = chartData
    
    chartView.drawOrder = [DrawOrder.candle.rawValue, DrawOrder.line.rawValue]
    chartView.chartDescription?.text = ""
    
    // unnecessary gesture
    chartView.scaleXEnabled = false
    chartView.scaleYEnabled = false
    chartView.legend.enabled = false
    chartView.backgroundColor = chartBackgroundColor
    
    chartView.drawBordersEnabled = true
    chartView.borderColor = UIColor.gray
  }
  
  func addInsightView() {
    insightView = HighlightView(frame: calculateHighlightFrame(atPosition: Double(insightIndex), withIndex: insightIndex))
    let insightImageView = UIImageView(frame: CGRect(x: insightView.frame.width/3, y: insightView.frame.height/2 + 12, width: insightView.frame.width/3, height: 30))
    insightImageView.image = UIImage(named: "bulb")
    
    let insightLabel = UILabel(frame: CGRect(x: 0, y: insightView.frame.height - 16, width: insightView.frame.width, height: 12))
    insightLabel.text = "Insight"
    insightLabel.textAlignment = .center
    insightLabel.font = UIFont.systemFont(ofSize: 12)
    insightLabel.textColor = UIColor.white
    
    insightView.backgroundColor = highlightColor
    chartView.addSubview(insightView)
    insightView.addSubview(insightLabel)
    insightView.addSubview(insightImageView)
    didAppear = true
  }
  
  func calculateHighlightFrame(atPosition positionX: Double, withIndex index: Int) -> CGRect {
    let values: [Double] = DataCollection.getDesaturationEpisodes()
    let xPos = positionX
    let open = values[index] - 4
    let close = values[index] + 4
    let barSpace: CGFloat = 0.1
    let phaseY: Double = 1
    
    let trans = chartView.getTransformer(forAxis: .right)//dataProvider.getTransformer(forAxis: dataSet.axisDependency)
    var highlightRect = CGRect()
    highlightRect.origin.x = CGFloat(xPos) - 0.5 + barSpace
    highlightRect.origin.y = CGFloat(close * phaseY)
    highlightRect.size.width = (CGFloat(xPos) + 0.5 - barSpace) - highlightRect.origin.x
    highlightRect.size.height = CGFloat(open * phaseY) - highlightRect.origin.y
    trans.rectValueToPixel(&highlightRect)
    return highlightRect
  }
  
  func showInsight(withRect highlightRect: CGRect, withInfo info: ChartDataEntry) {
//    highlightView.frame = highlightRect
//    highlightView.backgroundColor = highlightColor
//    chartView.addSubview(highlightView)
    
    let alertController = UIAlertController(title: "Desaturaton Summary", message: "Your child desaturation count for today is \(info.y)", preferredStyle: .alert)
    
    let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: {(alert :UIAlertAction!) in
      self.chartView.lastHighlighted = nil
    })
    alertController.addAction(dismissAction)
    present(alertController, animated: true, completion: nil)
  }
  
}

extension DesatVC: ChartViewDelegate {
  
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    var touchPoint: CGPoint!
    for recogniser in chartView.gestureRecognizers! {
      if let gestureRegogniser = recogniser as? UITapGestureRecognizer {
        touchPoint = gestureRegogniser.location(in: chartView)
      }
    }
    let highlightFrame = calculateHighlightFrame(atPosition: entry.x, withIndex: Int(highlight.x))
    if highlightFrame == insightView.frame {
      if touchPoint.x > highlightFrame.origin.x && touchPoint.x < (highlightFrame.origin.x + highlightFrame.width) && touchPoint.y > highlightFrame.origin.y && touchPoint.y < (highlightFrame.origin.y + highlightFrame.height) {
        showInsight(withRect: highlightFrame, withInfo: entry)
      }
    }
  }
  
}

extension DesatVC: IAxisValueFormatter {
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return DataCollection.desaturationLabels[Int(value)]
  }
  
}

extension DesatVC: IValueFormatter {
  
  func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    return String.localizedStringWithFormat("%.0f", entry.y)
  }
  
}
