//
//  UIScrollView.swift
//  WavePullToRefresh
//
//  Created by Daisuke Kobayashi on 2016/02/18.
//  (C) 2016 RECRUIT LIFESTYLE CO., LTD.
//

import Foundation

public extension UIScrollView {
    
    // MARK:- Private Methods
    private var pullToRefreshView: WavePullToRefreshView? {
        let pullToRefreshView = viewWithTag(WavePullToRefreshConst.tag)
        return pullToRefreshView as? WavePullToRefreshView
    }
    
    // MARK:- Public Methods
    
    /**
    Add WavePullToRefreshView to your scrollable view
    - parameter 
        callback: Call when start refreshing
    */
    public func addPullToRefresh(callback :(() -> ())) {
        self.addPullToRefresh(options: WavePullToRefreshOption(), callback: callback)
    }
    
    /**
     with option
     */
    public func addPullToRefresh(options options: WavePullToRefreshOption, callback :(() -> ())) {
        let refreshViewFrame = CGRectMake(0, 0, self.frame.size.width, WavePullToRefreshConst.height)
        let refreshView = WavePullToRefreshView(options: options, frame: refreshViewFrame, refreshCallback: callback)
        refreshView.tag = WavePullToRefreshConst.tag
        addSubview(refreshView)
    }
    
    /**
     Call when you want to start refreshing forcibly
     */
    public func startPullToRefresh() {
        self.pullToRefreshView?.state = .Refreshing
    }
    
    /**
     Call when finish refreshing
     */
    public func stopPullToRefresh() {
        self.pullToRefreshView?.state = .Normal
    }
}
