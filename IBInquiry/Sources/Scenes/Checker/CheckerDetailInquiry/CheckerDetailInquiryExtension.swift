//
//  CheckerDetailInquiryExtension.swift
//  IBInquiry
//
//  Created by tran dinh quy on 12/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources
import Foundation
import IBFoundation
import IBViewComponents
import IBNetworkInterface
import IBCommon
import IBFeatureCommon

extension CheckerDetailInquiryView {
    public static func reactView(transactionId: String, detailType: TransInquiryType, envi: IBInquiryEnviromentProtocol?) -> some View {
        return MachineView(
            asyncStateMachine: CheckerDetailInquiryStateMachine.creatStateMachine(envi: envi, detailType: detailType),
            stateToViewState: { $0 },
            builder: { model, handle in
                CheckerDetailInquiryView.init(transactionId: transactionId, type: detailType, model: model, handle: handle)
            }
        )
    }
    func handleSubmit() {
        handle?(.approved(action: .submit(input: [transactionId])))
    }

    func handleReject(_ reason: String) {
        handle?(.reject(action: .request(items: ItemsEntity(items: [transactionId], description: reason))))
    }
    
    @MainActor func refreshList() {}
}
