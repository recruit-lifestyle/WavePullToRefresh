//
//  Test.swift
//  WavePullToRefresh
//
//  Created by Sotozaki Masanori on 4/6/16.
//  Copyright © 2016 RECRUIT LIFESTYLE CO., LTD. All rights reserved.
//

import XCTest
@testable import WavePullToRefresh

class Test: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // When the scrollView call addPullToRefresh()
    func testWavePullToRefreshView() {
        let scrollView = UIScrollView()
        scrollView.addPullToRefresh {}
        let wavePullToRefreshViewFilter = { (view: UIView) -> Bool in
            view.dynamicType == WavePullToRefreshView.self
        }
        let wavePullToRefreshView = scrollView.subviews.filter(wavePullToRefreshViewFilter).first as? WavePullToRefreshView
        
        XCTAssertNotNil(wavePullToRefreshView, "has WavePullToRefreshView")
        XCTAssertEqual(scrollView.bounds.width, wavePullToRefreshView?.bounds.width,"is the same width as WavePullToRefreshView")
    }
    
    // When the dropView is set indicatorImageView option
    func testIndicatorImageViewWithOption() {
        let scrollView = UIScrollView()
        let options = WavePullToRefreshOption()
        options.indicatorImageView = UIImageView()
        scrollView.addPullToRefresh(options: options) {
            scrollView.stopPullToRefresh()
        }
        let wavePullToRefreshViewFilter = { (view: UIView) -> Bool in
            view.dynamicType == WavePullToRefreshView.self
        }
        let dropView = (scrollView.subviews.filter(wavePullToRefreshViewFilter).first
            as! WavePullToRefreshView).dropView
        
        XCTAssertNotNil(dropView.indicatorImageView, "has indicatorImageView")
        XCTAssertNil(dropView.indicatorLayer, "doesn't have indicatorLayer")
    }
    
    // When the dropView is not set indicatorImageView option
    func testIndicatorImageView() {
        let scrollView = UIScrollView()
        let options = WavePullToRefreshOption()
        scrollView.addPullToRefresh(options: options) {
            scrollView.stopPullToRefresh()
        }
        let wavePullToRefreshViewFilter = { (view: UIView) -> Bool in
            view.dynamicType == WavePullToRefreshView.self
        }
        let dropView = (scrollView.subviews.filter(wavePullToRefreshViewFilter).first
            as! WavePullToRefreshView).dropView
        
        XCTAssertNil(dropView.indicatorImageView, "doesn't have indicatorImageView")
        XCTAssertNotNil(dropView.indicatorLayer, "has indicatorLayer")
    }
}
