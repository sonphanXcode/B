//
//  ManagerMackerListInquiry.swift
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

extension MackerListTransactionView
where
Filter == MackerListTransInquiryFilter,
Item == MackerListInquiryItemModel,
Content == MackerListInquiryItemView,
FilterContent == MackerListInquiryFilterView,
ItemAction == MackerItemAction<Item>,
SingningTransaction == String,
CommonTransaction == String,
ActionView == ListActionRecall<Filter, Item, SingningTransaction, CommonTransaction> {
    static func managerMackerListInquiry(envi: IBInquiryEnviromentProtocol?) -> some View {
        return MackerListTransactionView.with(title: "",
                                              state: .init(list: .init(), common: .idle, signing: .init(.idle)),
                                              effector: MackerListInquiryEffector.initEffector(envi),
                                              itemBuilder: MackerListInquiryItemView.init(transaction: selected: itemAction: ),
                                              actionBuilder: {state, handle, selecteItem, itemAction, _ in
            ListActionRecall.init(state: state, handle: handle, selectedItems: selecteItem, itemAction: itemAction)},
                                              filterBuilder: { isShow, filter, selection in
            MackerListInquiryFilterView(title: IBResourcesStrings.timKiemNangCao, isShow: isShow, filter: filter, handle: selection) },
                                              showDownload: true
        )
    }
}
