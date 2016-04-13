//
//  WavePullToRefreshView.swift
//  WavePullToRefresh
//
//  Created by Daisuke Kobayashi on 2016/02/18.
//  (C) 2016 RECRUIT LIFESTYLE CO., LTD.
//

import UIKit
import WavePullToRefresh

class ViewController: UIViewController {
    
    // MARK:- Properties
    private var items = (0...10).map{ "test\($0)" }
    
    @IBOutlet weak var tableView: UITableView?
    
    // MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 106/255, green: 172/255, blue: 184/255, alpha: 1)
        
        self.tableView?.dataSource = self
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let options = WavePullToRefreshOption()
        options.fillColor = UIColor(red: 106/255, green: 172/255, blue: 184/255, alpha: 1).CGColor
        
        // add pull to refresh
        self.tableView!.addPullToRefresh(options: options) { [weak self] in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                guard let s = self else { return }
                s.items.shuffleInPlace()
                s.tableView?.reloadData()
                s.tableView?.stopPullToRefresh()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    // MARK:- Internal Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let textLabel = cell.textLabel {
            textLabel.text = "\(items[indexPath.row])"
        }
        
        return cell
    }
}
