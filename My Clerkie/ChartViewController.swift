//
//  ChartViewController.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/19/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit
import SwiftCharts


class ChartViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet var chartCollectionView: UICollectionView!
    fileprivate var vchart: Chart?
    fileprivate var hchart: Chart?
    fileprivate var slchart: Chart?
    fileprivate var dlchart: Chart?
    var vbarChartView = UIView()
    var hbarChartView = UIView()
    var singlelineChartView = UIView()
    var duolineChartView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Vertical bar chart config
        let vbarchartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        let vbarchartframe = CGRect(x: 0, y: 50, width: 350, height: 350)
        let vchart = BarsChart(
            frame: vbarchartframe,
            chartConfig: vbarchartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
            color: UIColor.orange,
            barWidth: 20
        )
        vbarChartView = vchart.view
       self.vchart = vchart
        
        //Horizontal bar chart config
        let hbarchartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        let hbarchartframe = CGRect(x: 0, y: 50, width: 350, height: 350)
        let hchart = BarsChart(
            frame: hbarchartframe,
            chartConfig: hbarchartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
            color: UIColor.orange,
            barWidth: 20,
            horizontal : true
        )
        hbarChartView = hchart.view
        self.hchart = hchart
        
        
        //single line chart config
        let slinechartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 12, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 12, by: 2)
        )
        
        let slinechartframe = CGRect(x: 0, y: 50, width: 350, height: 350)
        
        let slchart = LineChart(
            frame: slinechartframe,
            chartConfig: slinechartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(4.0, 12.6), (5.2, 8), (9.3, 5.0), (9.1, 5.0), (16.0, 8.0)], color: UIColor.green)
                
            ]
        )
        
        singlelineChartView = slchart.view
        self.slchart = slchart
        
        //duo line chart config
        let dlinechartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 12, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 12, by: 2)
        )
        
        let dlinechartframe = CGRect(x: 0, y: 50, width: 350, height: 350)
        
        let dlchart = LineChart(
            frame: dlinechartframe,
            chartConfig: dlinechartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        
        duolineChartView = dlchart.view
        self.dlchart = dlchart

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var chartViews = [vbarChartView,hbarChartView,singlelineChartView,duolineChartView]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath)
        cell.addSubview(chartViews[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
