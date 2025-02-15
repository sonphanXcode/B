//
//  File.swift
//  IBInquiry
//
//  Created by Son phan on 14/2/25.
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

extension MackerListTransactionView
where
Filter == MackerListTransInquiryFilter,
Item == MackerListInquiryItemModel,
Content == MackerListOriTransItemView,
FilterContent == MackerListInquiryFilterView,
ItemAction == MackerItemAction<Item>,
SingningTransaction == String,
CommonTransaction == String,
ActionView == ListActionOriTrans<Filter, Item, SingningTransaction, CommonTransaction> {
    static func managerMackerListOriginalTrans(envi: IBInquiryEnviromentProtocol?) -> some View {
        return MackerListTransactionView.with(title: "",
                                              state: .init(list: .init(), common: .idle, signing: .init(.idle)),
                                              effector: MackerListOriginalTransEffector.initEffector(envi),
                                              itemBuilder: MackerListOriTransItemView.init(transaction: selected: itemAction: ),
                                              actionBuilder: {state, handle, selecteItem, itemAction, _ in
            ListActionOriTrans.init(state: state, handle: handle, selectedItems: selecteItem, itemAction: itemAction)},
                                              filterBuilder: { isShow, filter, selection in
            MackerListInquiryFilterView(title: IBResourcesStrings.timKiemNangCao, isShow: isShow, filter: filter, handle: selection) }
        )
    }
    
    private func dismissPopup() {
        
    }
}
