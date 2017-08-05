//
//  HelpScreen.swift
//  Anagrams
//
//  Created by Rishi Pochiraju on 7/9/16.
//  Copyright © 2016 SPK Dev. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HelpScreen: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-2830059983414219/9100025485"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
