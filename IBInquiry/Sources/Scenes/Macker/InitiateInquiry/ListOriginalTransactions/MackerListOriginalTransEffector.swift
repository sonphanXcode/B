//
//  MackerListOriginalTransEffector.swift
//  IBInquiry
//
//  Created by Son phan on 14/2/25.
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

public struct MackerListOriginalTransEffector {
    public static func initEffector(_ envi: IBInquiryEnviromentProtocol?) -> Effector<MackerListCommand<MackerListTransInquiryFilter, MackerListInquiryItemModel>, MackerListAction<MackerListTransInquiryFilter, MackerListInquiryItemModel, String, String>> {

        return .init { command in
            switch command {
            case .list(command: let value):
                switch value {
                case .getData(let filter):
                    var items: [MackerListInquiryItemModel] = []
                    var total: Int = 0
                    let page = PageEntity(pageSize: filter.page.size, pageNum: filter.page.index, getTotal: filter.page.getTotal)
                    let result = await envi?.getListInquiryListBulk(model: filter.searchModel, page: page)
                    switch result {
                    case .success(let success):
                        total = Int(success.total ?? 0)
                        
                        items = success.items?.map { MackerListInquiryItemModel(from: $0)} ?? []
                    case .failure, nil:
                        break
                    }
                    return .list(action: .data(items: items, total: total, filter: filter))
                }
            case .common(command: let value):
                switch value {
                case .request(items:):
                    return .common(action: .success(result: CommonResult(success: [], errors: [])))
                }
            case .signing(command: ):
                return .signing(action: .error(message: IBResourcesStrings.chuaXacDinh))
            case .export(command: let command):
                switch command {
                case .request(items: ):
                    return .export(action: .error(message: IBResourcesStrings.chuaXacDinh))
                }
            case .exportAll(command: let command):
                switch command {
                case .request(items: let items):
                    let result = await envi?.getReportInquiryMaker(entity: TxnInquiryListRequestEntity())
                    switch result {
                    case .success(let success):
                        return .exportAll(action: .success(result: success.url ?? ""))
                    case .failure(let failure):
                        return .exportAll(action: .error(message: IBResourcesStrings.chuaXacDinh))
                    case nil:
                        return .exportAll(action: .error(message: IBResourcesStrings.chuaXacDinh))
                    }
                }
            }
        }
    }
}
