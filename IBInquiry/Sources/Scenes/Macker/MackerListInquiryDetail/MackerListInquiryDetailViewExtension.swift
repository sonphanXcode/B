//
//  MackerListInquiryDetailViewExtension.swift
//  IBInquiry
//
//  Created by Son phan on 11/2/25.
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

extension MackerListInquiryDetailView {
    public static func reactView(transactionId: String, detailType: TransInquiryType, envi: IBInquiryEnviromentProtocol?) -> some View {
        return MachineView(
            asyncStateMachine: MackerDLIStateMachine.creatStateMachine(envi: envi, detailType: detailType),
            stateToViewState: { $0 },
            builder: { model, handle in
                MackerListInquiryDetailView.init(id: transactionId, model: model, handle: handle, transType: detailType)
            }
        )
    }
    
    @MainActor func refreshList() {
        
    }
}
