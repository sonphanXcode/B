//
//  ExtensionIBSelectedMutilDataView.swift
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
import SwiftMacro

extension IBSelectedMutilDataView where Input == String, Output == CategoryResponseEntity, Content == IBItemSelectedMutilView<Text> {
    
    public static func selectTranslistEffector(envi: IBInquiryEnviromentProtocol?, categoryType: CategoryType) -> Effector<SelectedMutilCommand<String>, SelectedMutilAction<CategoryResponseEntity>> {
        return .init { command in
            switch command {
            case .getData:
                let type = categoryType.rawValue
                if type != "STATUS" {
                    guard let result = await envi?.getCategoriesByType(request: CategoryRequestEntity(categoryType: [type])) else {
                        return .items([])
                    }
                    return result.fold(
                        { value in .items(value) },
                        { _ in .items([]) }
                    )
                } else {
                    return .items([
                        CategoryResponseEntity(code: "APPROVED", name: IBResourcesStrings.daDuyet, type: ""),
                        CategoryResponseEntity(code: "PENDING_APPROVAL", name: IBResourcesStrings.choDuyet, type: ""),
                        CategoryResponseEntity(code: "REJECTED", name: IBResourcesStrings.tuChoiDuyet, type: ""),
                        CategoryResponseEntity(code: "BANK_PROCESSING", name: IBResourcesStrings.choNganHangTraLoi, type: ""),
                        CategoryResponseEntity(code: "CANCELLED", name: IBResourcesStrings.hetHieuLuc, type: "")
                    ])
                }
            }
        }
    }
    
    public static func paymentSelectTransType(
        result: @escaping ([CategoryResponseEntity]) -> Void,
        selectedItem: [CategoryResponseEntity] = []
    )
    -> some View {
        IBSelectedMutilDataView
            .with(
                title: IBResourcesStrings.loaiGiaoDich,
                placeholder: IBResourcesStrings.timKiem,
                allowChar: "",
                selectedItem: selectedItem,
                effector: selectTranslistEffector(envi: DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self), categoryType: .txnType),
                onSelectItem: { value in
                    result(value)
                },
                filter: { account, query in
                    let searchQuery = query.lowercased()
                    return account.name?.lowercased().contains(searchQuery) ?? false
                },
                searchEnable: { $0.count >= 10 },
                itemView: { item, isSelected in
                    IBItemSelectedMutilView<Text>(title: item.name ?? "", isSelected: isSelected)
                }
            )
    }
    
    public static func inquirySelectMutilStatus(
        result: @escaping ([CategoryResponseEntity]) -> Void,
        selectedItem: [CategoryResponseEntity] = []
    )
    -> some View {
        IBSelectedMutilDataView
            .with(
                title: IBResourcesStrings.trangThai,
                placeholder: IBResourcesStrings.timKiem,
                allowChar: "",
                selectedItem: selectedItem,
                effector: selectTranslistEffector(envi: DIContainer.standard.resolve(type: IBInquiryEnviromentProtocol.self), categoryType: .status),
                onSelectItem: { value in
                    result(value)
                },
                filter: { account, query in
                    let searchQuery = query.lowercased()
                    return account.name?.lowercased().contains(searchQuery) ?? false
                },
                searchEnable: { $0.count >= 10 },
                itemView: { item, isSelected in
                    IBItemSelectedMutilView<Text>(title: item.name ?? "", isSelected: isSelected)
                }
            )
    }
}
