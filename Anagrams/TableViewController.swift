//
//  TableViewController.swift
//  Anagrams
//
//  Created by Rishi Pochiraju on 7/15/16.
//  Copyright © 2016 SPK Dev. All rights reserved.
//

import UIKit
import GoogleMobileAds

var indexSelected = -1
var isPlaying = false

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (isPlaying == true){
            isPlaying = false
            self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
            indexSelected = -1
            tiles.removeAll()
            targets.removeAll()
            targetCenters.removeAll()
            targetX.removeAll()
            tileX.removeAll()
            tileY = 0
            gameWon = false
        }
        
        scrollTableView()
        
        tableView.reloadData()
        
    }
    
    func scrollTableView(){
        let numberOfSections = self.tableView.numberOfSections
        let indexPath = IndexPath(row: userLevel - 1, section: numberOfSections-1)
        self.tableView.scrollToRow(at: indexPath,
                                              at: UITableViewScrollPosition.top, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wentInside = true
        
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView.adUnitID = "ca-app-pub-2830059983414219/9100025485"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        nav?.barTintColor = UIColor(red: 73/255.0, green: 181/255.0, blue: 22/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scrambledWords.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "LEVEL \(indexPath.row + 1)"
        cell.textLabel?.textAlignment = .left
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        cell.textLabel?.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        if (indexPath.row > userLevel - 1){
            cell.textLabel?.textColor = UIColor.lightGray
        }
        cell.textLabel?.font = UIFont(name: "Avenir", size: 27.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < userLevel {
            let vcName = "play"
//            let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
            indexSelected = indexPath.row
//            self.navigationController?.pushViewController(viewController!, animated: true)
            performSegue(withIdentifier: "startGame", sender: tableView)
        }else{
            let completeLevelAlert = UIAlertController(title: "Sorry!", message: "Complete level \(userLevel) first.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            }
            completeLevelAlert.addAction(okAction)
            self.present(completeLevelAlert, animated: true, completion: nil)
            self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}
