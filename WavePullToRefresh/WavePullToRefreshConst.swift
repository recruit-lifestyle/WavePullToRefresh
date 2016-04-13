//
//  WavePullToRefreshConst.swift
//  WavePullToRefresh
//
//  Created by Daisuke Kobayashi on 2016/02/18.
//  (C) 2016 RECRUIT LIFESTYLE CO., LTD.
//

import UIKit

struct WavePullToRefreshConst {
    // MARK:- Properties
    static let tag = 999
    static let height: CGFloat = 80
    static let waveHeight: CGFloat = 80
    static let spinSpeed: CGFloat = 0.05
    static let maxIndicatorRadius: CGFloat = 50
}

public class WavePullToRefreshOption {
    // MARK:- Properties
    
    public var animationStartOffsetY: CGFloat = 80
    public var dropDuration: NSTimeInterval = 0.75
    public var dropY: CGFloat = UIScreen.mainScreen().bounds.height * 0.85
    
    public var fillColor = UIColor(red: 106/255, green: 172/255, blue: 184/255, alpha: 1).CGColor
    public var indicatorColor = UIColor.whiteColor().CGColor
    public var indicatorImageView: UIImageView?
    
    public init() {
        
    }
}
