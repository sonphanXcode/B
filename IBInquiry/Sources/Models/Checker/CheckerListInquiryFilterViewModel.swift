//
//  CheckerListInquiryFilterViewModel.swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation

class CheckerListInquiryFilterViewModel: ObservableObject {
    
    func createTransFilterModel(txnType: [String],
                                inquiryReason: String,
                                createdDateFrom: String,
                                createdDateTo: String,
                                createdBy: String
    ) -> (CheckerListInquiryFilterModel, Int) {
        
        let model = CheckerListInquiryFilterModel(
            txnType: txnType,
            inquiryReason: inquiryReason,
            createdDateFrom: createdDateFrom,
            createdDateTo: createdDateTo,
            createdBy: createdBy,
            keyword: ""
        )
        var count = 0
        if !txnType.isEmpty { count += 1 }
        if !inquiryReason.isEmpty { count += 1 }
        if !createdDateFrom.isEmpty { count += 1 }
        if !createdBy.isEmpty { count += 1 }

        return (model, count)
    }
}
