//
//  File.swift
//  IBInquiry
//
//  Created by Son phan on 13/2/25.
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
import SwiftMacro

public enum TransactionInquiryStatus: String {
    case approved = "APPROVED"
    case pendingApproval = "PENDING_APPROVAL"
    case reject = "REJECTED"
    case bankProcessing = "BANK_PROCESSING"
    case cancelLed = "CANCELLED"
    case `default`
    
    var status: String {
        switch self {
        case .approved:
            return IBResourcesStrings.daDuyet
        case .pendingApproval:
            return IBResourcesStrings.choDuyet
        case .reject:
            return IBResourcesStrings.tuChoiDuyet
        case .bankProcessing:
            return IBResourcesStrings.choNganHangTraLoi
        case .cancelLed:
            return IBResourcesStrings.hetHieuLuc
        case .default:
            return ""
        }
    }
}

@IsCaseVariable
public enum TransInquiryType: String, DSLCompatible, Equatable {
    case single = "S"
    case bulk = "B"
    case salary = "P"
    case bulkChild = "BI"
    case salaryChild = "PI"
    
    var type: String {
        switch self {
        case .single:
            return IBResourcesStrings.chuyenTienTrongNuoc
        case .bulk:
            return IBResourcesStrings.thanhToanBangKe
        case .salary:
            return IBResourcesStrings.thanhToanLuong
        case .bulkChild:
            return IBResourcesStrings.giaoDichTrongBangKe
        case .salaryChild:
            return "Giao dịch trong bảng lương"
        }
    }
}

public enum InquiryReasonCodeType: String {
    case informationVerification = "INFORMATION_VERIFICATION"
    case refundRemark = "REFUND_REQUEST"
    case updateRemark = "UPDATE_REMARK"
    case updateBenAccno = "UPDATE_BEN_ACCNO"
    case updateBenName = "UPDATE_BEN_NAME"
    case `default`
    
    var reasonType: String {
        switch self {
        case .informationVerification:
            return "Làm rõ thông tin"
        case .refundRemark:
            return IBResourcesStrings.deNghiHoanTra
        case .updateRemark:
            return IBResourcesStrings.chinhSuaNoiDung
        case .updateBenAccno:
            return IBResourcesStrings.chinhSuaTaiKhoanHuong
        case .updateBenName:
            return IBResourcesStrings.chinhSuaTenNguoiHuong
        case .default:
            return ""
        }
    }
}

public enum CategoryType: String {
    case txnType = "INQUIRY"
    case inquiryReason = "INQUIRY_REASON"
    case status = "STATUS"
}
