//
//  SegmentViewController.swift
//  test2
//
//  Created by alexfu on 11/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class SegmentViewController: UIPageViewController ,UIPageViewControllerDelegate, UIPageViewControllerDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        let segment: UISegmentedControl = UISegmentedControl(items: ["First", "Second"])
        segment.sizeToFit()
        segment.tintColor = .white
        segment.selectedSegmentIndex = 0;
        segment.addTarget(self, action: #selector(SegmentViewController.segmentedValueChanged(segment:)), for: .valueChanged)
        navigationItem.titleView = segment
    }
    
    
    func segmentedValueChanged(segment:UISegmentedControl) {
        let _ = segment.selectedSegmentIndex
        print("hi")
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
