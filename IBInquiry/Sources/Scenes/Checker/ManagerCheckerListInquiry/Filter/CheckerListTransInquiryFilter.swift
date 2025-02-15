//
//  CheckerListTransInquiryFilter.swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
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
public struct CheckerListTransInquiryFilter: TransactionFilter {
    public init() {}
    
    public func with(page: ListPage?) -> CheckerListTransInquiryFilter {
        var result = self
        if let page = page {
            result.page = page
        }
        return result
    }
    
    public func with(search: String) -> CheckerListTransInquiryFilter {
        var result = self
        result.searchText = search
        result.searchModel.keyword = search
        return result
    }
    var searchText: String = ""
    var searchModel: CheckerListInquiryFilterModel = CheckerListInquiryFilterModel()
    
    public var page: ListPage = .empty
    public var filterCount: Int = 0
    public var serviceType: String = ""
    
    public  func with(serviceType: String) -> CheckerListTransInquiryFilter {
        var result = self
        result.serviceType = serviceType
        return result
    }
    
    public func with(model: CheckerListInquiryFilterModel, filterCount: Int) -> CheckerListTransInquiryFilter {
        var result = self
        result.filterCount = filterCount
        result.searchModel = model
        return result
    }
}
