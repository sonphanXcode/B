//
//  ManagerCheckerListInquiryView.swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
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

extension CheckerListTransactionView
where
Filter == CheckerListTransInquiryFilter,
Item == CheckerListInquiryItemModel,
Content == CheckerListInquiryItemView,
FilterContent == CheckerListInquiryFilterView,
ItemAction == MackerItemAction<Item>,
SingningTransaction == TxnPaymentRecallEntity,
CommonTransaction == String,
ActionView == CheckerListActionView<Filter, Item, SingningTransaction, CommonTransaction> {
    static func managerCheckerListInquiryView(envi: IBInquiryEnviromentProtocol?) -> some View {
        return CheckerListTransactionView.with(title: IBResourcesStrings.quanLyGiaoDich,
                                               state: .init(list: .init(), common: .idle, signing: .init(.idle), export: .idle),
                                               effector: CheckerListInquiryEffector.initEffector(envi),
                                               itemBuilder: CheckerListInquiryItemView.init(transaction: selected: itemAction: ),
                                               actionBuilder: {state, handle, selecteItem, itemAction, _ in
            CheckerListActionView.init(state: state, handle: handle, selectedItems: selecteItem, itemAction: itemAction)},
                                               filterBuilder: { isShow, filter, selection in
            CheckerListInquiryFilterView(title: IBResourcesStrings.timKiemNangCao, isShow: isShow, filter: filter, handle: selection)
        }
        )
    }
}
