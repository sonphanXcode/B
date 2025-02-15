//
//  MackerListTransInquiryFilter.swift
//  IBInquiry
//
//  Created by Son phan on 9/2/25.
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
public struct MackerListTransInquiryFilter: TransactionFilter {
    public init() {}

    public func with(page: ListPage?) -> MackerListTransInquiryFilter {
        var result = self
        if let page = page {
            result.page = page
        }
        return result
    }

    public func with(search: String) -> MackerListTransInquiryFilter {
        var result = self
        result.searchText = search
        result.searchModel.keyword = search
        return result
    }
    var searchText: String = ""
    var searchModel: MackerListInquiryFilterModel = MackerListInquiryFilterModel()
    
    public var page: ListPage = .empty
    public var filterCount: Int = 0
    public var serviceType: String = ""

    public  func with(serviceType: String) -> MackerListTransInquiryFilter {
        var result = self
        result.serviceType = serviceType
        return result
    }
    
    public func with(model: MackerListInquiryFilterModel, filterCount: Int) -> MackerListTransInquiryFilter {
        var result = self
        result.filterCount = filterCount
        result.searchModel = model
        return result
    }
}

// MARK: Trans Filter
public struct MackerListOriTransFilter: TransactionFilter {
    public init() {}

    public func with(page: ListPage?) -> MackerListOriTransFilter {
        var result = self
        if let page = page {
            result.page = page
        }
        return result
    }

    public func with(search: String) -> MackerListOriTransFilter {
        var result = self
        result.searchText = search
        result.searchModel.keyword = search
        return result
    }
    var searchText: String = ""
    var searchModel: MackerListInquiryFilterModel = MackerListInquiryFilterModel()
    
    public var page: ListPage = .empty
    public var filterCount: Int = 0
    public var serviceType: String = ""

    public  func with(serviceType: String) -> MackerListOriTransFilter {
        var result = self
        result.serviceType = serviceType
        return result
    }
    
    public func with(model: MackerListInquiryFilterModel, filterCount: Int) -> MackerListOriTransFilter {
        var result = self
        result.filterCount = filterCount
        result.searchModel = model
        return result
    }
}
