//
//  MackerInitInquirySearch.swift
//  IBInquiry
//
//  Created by tran dinh quy on 15/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import IBFoundation
import Foundation
import NavigationCoordinator
import SwiftUI
import MemberwiseInit
import IBDeepLinks
import IBViewComponents
import IBFeatureCommon
import IBResources

// MARK: Trans Filter
public struct MackerInitInquirySearch: TransactionFilter {
    public init() {}

    public func with(page: ListPage?) -> MackerInitInquirySearch {
        var result = self
        if let page = page {
            result.page = page
        }
        return result
    }

    public func with(search: String) -> MackerInitInquirySearch {
        var result = self
        result.searchText = search
        result.searchModel.keyword = search
        return result
    }
    var searchText: String = ""
    var searchModel: MackerListOriginalTransFilterModel = MackerListOriginalTransFilterModel()
    
    public var page: ListPage = .empty
    public var filterCount: Int = 0
    public var serviceType: String = ""

    public  func with(serviceType: String) -> MackerInitInquirySearch {
        var result = self
        result.serviceType = serviceType
        return result
    }
    
    public func with(model: MackerListOriginalTransFilterModel, filterCount: Int) -> MackerInitInquirySearch {
        var result = self
        result.filterCount = filterCount
        result.searchModel = model
        return result
    }
}
