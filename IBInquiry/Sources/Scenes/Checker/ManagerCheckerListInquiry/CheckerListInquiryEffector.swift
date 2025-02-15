//
//  CheckerListInquiryEffector.swift
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

public struct CheckerListInquiryEffector {
    public static func initEffector(_ envi: IBInquiryEnviromentProtocol?) -> Effector<MackerListCommand<CheckerListTransInquiryFilter, CheckerListInquiryItemModel>, MackerListAction<CheckerListTransInquiryFilter, CheckerListInquiryItemModel, TxnPaymentRecallEntity, String>> {
        return .init { command in
            switch command {
            case .list(command: let value):
                switch value {
                case .getData(let filter):
                    var items: [CheckerListInquiryItemModel] = []
                    let result = await envi?.getListInquiryListChecker(model: filter.searchModel, pageSize: filter.page.size, pageNum: filter.page.index)
                    items = {
                        switch result {
                        case .success(let items):
                            return items.map {
                                CheckerListInquiryItemModel(item: $0)
                            }
                        case .failure, nil:
                            return []
                        }
                    }()
                    return .list(action: .data(items: items, total: items.count, filter: filter))
                }
            case .common(command: let value):
                switch value {
                case .request(items: let input):
                    let rs = await envi?.rejectPaymentInquiry(txnIds: input.items.map { $0.id }, rejectReason: input.description)
                    
                    switch rs {
                    case .success:
                        return .common(
                            action: .success(result: CommonResult(success: [], errors: []))
                        )
                    case .failure(let failure):
                        return .common(action: .error(message: failure.messageCode))
                    case .none:
                        return .common(action: .error(message: IBResourcesStrings.chuaXacDinh))
                    }
                }
            case .signing(command: let value):
                switch value {
                case let .submitTransaction(input):
                    
                    let result = await envi?.approveInquiry(txnIds: input?.data.compactMap { $0.id } ?? [])
                    switch result {
                    case .success(let success):
                        return .signing(action: .submitResult(value: SubmitResult<TxnPaymentRecallEntity>( requireSign: success.requireAuth ?? true,
                                                                                                                                  signInfo: success.toSignInfo(),
                                                                                                                                  transKey: success.transKey ?? "",
                                                                                                                                  confimrUrl: success.confirmUrl ?? "")))
                    case .failure(let failure):
                        return .signing(action: .error(message: failure.messageCode))
                    case .none:
                        return .signing(action: .error(message: IBResourcesStrings.chuaXacDinh))
                    }
                case let .singningTransaction(key: key, otp: otp):
                    let result = await envi?.approveConfirmInquiry(transKey: key?.transKey ?? "", confirmValue: otp)
                    switch result {
                    case .success(let success):
                        return .signing(
                            action: .signingResult(
                                value: SigningResult<TxnPaymentRecallEntity>(
                                    transInfo: success.transaction,
                                    success: (success.successfulTransactions ?? []).map {
                                        TransactionResult(id: $0.txnId, message: $0.message)
                                    },
                                    errors: (success.failedTransactions ?? []).map {
                                        TransactionResult(id: $0.txnId, message: $0.message)
                                    })))
                    case .failure(let failure):
                        return .signing(action: .error(message: failure.errorCode))
                    case .none:
                        return .signing(action: .error(message: IBResourcesStrings.chuaXacDinh))
                    }
                }
            case .export(command: let command):
                switch command {
                case .request(items:):
                    return .export(action: .error(message: IBResourcesStrings.chuaXacDinh))
                }
            case .exportAll:
                    return .signing(action: .error(message: IBResourcesStrings.chuaXacDinh))
            }
        }
    }
}
