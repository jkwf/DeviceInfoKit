//
//  ViewController.swift
//  Draw
//
//  Created by KangFang on 2020/3/30.
//  Copyright © 2020 KangFang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDeviceInfo()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return bgView
    }
    func getDeviceInfo() -> () {
        if let bundlePath = Bundle.main.path(forResource: "DeviceInfo", ofType: "plist"), let dicData = NSDictionary(contentsOfFile: bundlePath) {
            var systemInfo = utsname()
            uname(&systemInfo)
            let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
                return String(cString: ptr)
            }
            guard let plat = dicData[platform] else {
                return
            }
            print("------------\(plat)")
        }
    }
}

