//
//  MainTabBarController.swift
//  Buy?
//
//  Created by Churong Zhang on 3/20/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let tarChineseNames = ["算税","全球汇率","小费能手","更多"]
    let tarEnglishNames = ["Sale Tax", "Exchange Rate", "Tips Calc", "More"]
    override func viewDidLoad() {
        super.viewDidLoad()
        var tarNames = [""]
        if Locale.current.languageCode == "zh"
        {
            tarNames = tarChineseNames
        }
        else {
            tarNames = tarEnglishNames
        }
        if let items = tabBar.items
        {
            var i = 0
            for x in items
            {
                x.title = tarNames[i]
                i = i + 1
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
