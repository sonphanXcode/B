//
//  MackerListInquiry.swift
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

public struct MackerListInquiryEffector {
    public static func initEffector(_ envi: IBInquiryEnviromentProtocol?) -> Effector<MackerListCommand<MackerListTransInquiryFilter, MackerListInquiryItemModel>, MackerListAction<MackerListTransInquiryFilter, MackerListInquiryItemModel, String, String>> {

        return .init { command in
            switch command {
            case .list(command: let value):
                switch value {
                case .getData(let filter):
                    var items: [MackerListInquiryItemModel] = []
                    let result = await envi?.getListInquiryListMaker(model: filter.searchModel, pageSize: filter.page.size, pageNum: filter.page.index)
                    items = {
                        switch result {
                        case .success(let items):
                            return items.map { MackerListInquiryItemModel(from: $0) }
                        case .failure, nil:
                            return []
                        }
                    }()
                    return .list(action: .data(items: items, total: items.count, filter: filter))
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
