//
//  MackerInitInquirySearchViewModel.swift
//  IBInquiry
//
//  Created by tran dinh quy on 15/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation

class MackerInitInquirySearchViewModel: ObservableObject {
    
    func createTransFilterModel(createdDateFrom: String,
                                createdDateTo: String, txnType: [String],
                                inquiryReason: String, status: [String],
                                keyword: String) -> (MackerListInquiryFilterModel, Int) {
        
        let model = MackerListInquiryFilterModel(createdDateFrom: createdDateFrom,
                                                 createdDateTo: createdDateTo, txnType: txnType,
                                                 inquiryReason: inquiryReason, status: status,
                                                 keyword: keyword)
        var count = 0
        if !createdDateFrom.isEmpty { count += 1 }
        if !createdDateTo.isEmpty { count += 1 }
        if !txnType.isEmpty { count += 1 }
        if !inquiryReason.isEmpty { count += 1 }
        if !status.isEmpty { count += 1 }
        if !keyword.isEmpty { count += 1 }
        
        return (model, count)
    }
}
