//
//  CheckerDetailInquiryEffector.swift
//  IBInquiry
//
//  Created by tran dinh quy on 12/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import IBFeatureCommon
import IBFoundation
import IBNetworkInterface
import IBResources

public enum CheckerDetailInquiryEffector {
    public static func mapEffector(envi: IBInquiryEnviromentProtocol?, detailType: TransInquiryType) -> Effector<CheckerDetailInquiryCommand, CheckerDetailInquiryAction> {
        .init { command in
            if case let .detail(command: value) = command {
                if case let .request(id) = value {
                    switch detailType {
                    case .single:
                        if let result = await envi?.getDetailInquiryChecker(id: id) {
                            return result.fold(
                                { .detail(action: .success(result: CheckerDetailInquiryModel(dataInquiryTransfer: $0))) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    case .bulk:
                        if let result = await envi?.getDetailInquiryBulkChecker(id: id) {
                            return result.fold(
                                { .detail(action: .success(result: CheckerDetailInquiryModel(dataInquiryBulk: $0))) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    case .salary:
                        if let result = await envi?.getDetailInquiryBulkChecker(id: id) {
                            return result.fold(
                                { .detail(action: .success(result: CheckerDetailInquiryModel(dataInquiryBulk: $0))) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    case .bulkChild:
                        if let result = await envi?.getDetailInquiryBulkChildChecker(id: id) {
                            return result.fold(
                                { .detail(action: .success(result: CheckerDetailInquiryModel(dataInquiryBulkChild: $0))) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    case .salaryChild:
                        if let result = await envi?.getDetailInquiryBulkChildChecker(id: id) {
                            return result.fold(
                                { .detail(action: .success(result: CheckerDetailInquiryModel(dataInquiryBulkChild: $0))) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    }
                }
            }
            if case let .reject(command: value) = command {
                if case let .request(items) = value {
                    return await envi?.rejectPaymentInquiry(txnIds: items.items, rejectReason: items.description)
                        .fold({ .reject(action: .success(result: $0)) },
                              { .reject(action: .error(message: $0.getMessageError())) })
                }
            }
            if case let .approved(command: value) = command {
                if case let .submitTransaction(items) = value, let items = items {
                    return await envi?.approveInquiry(txnIds: items)
                        .fold(
                            { .approved(action: .submitResult(value: SubmitResult<TxnPaymentRecallEntity>( requireSign: $0.requireAuth ?? true,
                                                                                                           signInfo: $0.toSignInfo(),
                                                                                                           transKey: $0.transKey ?? "",
                                                                                                           confimrUrl: $0.confirmUrl ?? ""))) },
                            { .approved(action: .error(message: $0.getMessageError())) }
                        )
                }
                if case let .singningTransaction(key: key, otp: otp) = value {
                    return await envi?.approveConfirmInquiry(transKey: key?.transKey ?? "", confirmValue: otp)
                        .fold(
                            { .approved(action: .signingResult(value: SigningResult<TxnPaymentRecallEntity>(transInfo: $0.transaction, success: [], errors: []))) },
                            { .approved(action: .error(message: $0.getMessageError())) }
                        )
                }
            }
            return .detail(action: .error(message: "error mapping effector"))
        }
    }
}
