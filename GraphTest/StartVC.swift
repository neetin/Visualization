//
//  StartVC.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/9/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in 0..<14 {
//            let data = DataCollection.getOxygenSaturationData(withIndex: i)
//            print(data)
//            print("**************************************")
//            print("**************************************")
//            var desatData: [Int] = []
//            for i in 0..<data.count {
//                if data[i] < 85 {
//                    desatData.append(Int(data[i]))
//                }
//            }
//            print(desatData)
//            print("*********************")
//        }
        
        /*
        for i in 0..<14 {
            print("Data at index: \(i)")
            let data = DataCollection.getOxygenSaturationData(withIndex: i)
            var desatData: [Int] = []
            for i in 0..<data.count {
                if data[i] < 85 {
                    desatData.append(data[i])
                }
            }
            print(desatData)
            print("*********************")
        }
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
