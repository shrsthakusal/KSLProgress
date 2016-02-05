//
//  ViewController.swift
//  KSLProgressBar
//
//  Created by Kusal Shrestha on 2/4/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var placeHolder: UIView!
    var ksProgressView: KSLProgressView!
    var counter = 0
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ksProgressView = KSLProgressView(frame: self.placeHolder.bounds, color: UIColor.whiteColor())
        ksProgressView.numberOfSteps = 5
        self.view.addSubview(ksProgressView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        ksProgressView.frame = self.placeHolder.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAction(sender: AnyObject) {
        if counter == ksProgressView.numberOfSteps + 1 {
            flag = false
        }
        if counter == 0 {
            flag = true
        }
        
        counter = flag ? counter + 1 : counter - 1
        
        ksProgressView.setProgress(counter)
    }


}

