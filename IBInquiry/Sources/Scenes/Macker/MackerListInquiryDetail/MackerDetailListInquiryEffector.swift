//
//  MackerDetailListInquiryEffector.swift
//  IBInquiry
//
//  Created by Son phan on 11/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//
import IBFeatureCommon
import IBFoundation
import IBNetworkInterface
import IBResources

public enum MackerDetailListInquiryEffector {
    public static func mapEffector(envi: IBInquiryEnviromentProtocol?, detailType: TransInquiryType) -> Effector<MackerDLICommand, MackerDLIAction> {
        .init { command in
            if case let .detail(command: value) = command {
                if case let .request(id) = value {
                    if detailType == .single {
                        if let result = await envi?.getDetailInquiryMaker(transactionId: id) {
                            return result.fold(
                                { .detail(action: .success(result: $0)) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    }
                    if detailType == .bulk || detailType == .bulkChild {
                        if let result = await envi?.getDetailInquiryMaker(transactionId: id) {
                            return result.fold(
                                { .detail(action: .success(result: $0)) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    }
                    if detailType == .salary || detailType == .salaryChild {
                        if let result = await envi?.getDetailInquiryMaker(transactionId: id) {
                            return result.fold(
                                { .detail(action: .success(result: $0)) },
                                { .detail(action: .error(message: $0.getMessageError())) }
                            )
                        } else {
                            return .detail(action: .error(message: "error mapping effector"))
                        }
                    }
                }
            }
            return .detail(action: .error(message: "error mapping effector"))
        }

    }
}
