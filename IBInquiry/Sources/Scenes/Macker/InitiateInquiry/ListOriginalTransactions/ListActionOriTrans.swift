//
//  ListActionOriTrans.swift
//  IBInquiry
//
//  Created by Son phan on 14/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import Foundation
import IBFeatureCommon
import IBFoundation
import IBResources
import IBViewComponents
import NavigationCoordinator
import SwiftUI

public struct ListActionOriTrans<
    Filter: TransactionFilter,
    Item: Equatable & Hashable,
    SingningTransaction: Equatable,
    CommonTransaction: Equatable
>: ListBottomActionView {
    let resultSigningRoute: ((SigningResult<SingningTransaction>?) -> Routable)?
    public var handle: ((MackerListAction<Filter, Item, SingningTransaction, CommonTransaction>) -> Void)?

    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.themeCoordinator) private var themeCoordinator
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.snackBarCoordinator) private var snackBarCoordinator
    @Environment(\.alertCoordinator) var alertCoordinator
    @Binding var selectedItems: [Item]
    @Binding var itemAction: MackerItemAction<Item>?
    @Binding var state: MackerListState<Filter, Item, SingningTransaction, CommonTransaction>
    @Inject var transactionSigning: TransactionSigningNew?
    
    @State var showDocumentExporter: Bool = false
    @State var validURLString: String = ""
    
    public init(
        state: Binding<MackerListState<Filter, Item, SingningTransaction, CommonTransaction>>,
        handle: ((MackerListAction<Filter, Item, SingningTransaction, CommonTransaction>) -> Void)? = nil,
        selectedItems: Binding<[Item]>,
        itemAction: Binding<MackerItemAction<Item>?>,
        resultSigningRoute: ((SigningResult<SingningTransaction>?) -> Routable)? = nil
    ) {
        self.handle = handle
        _state = state
        _selectedItems = selectedItems
        _itemAction = itemAction
        self.resultSigningRoute = resultSigningRoute
    }

    @MainActor
    @ViewBuilder
    public var body: some View {
        VStack {
            if !selectedItems.isEmpty {
                HStack(spacing: .spacing.spaceM) {
                    IBButton(
                        action: {
                            alertCoordinator.show(
                                type: .info,
                                title: IBResourcesStrings.taoTraSoat,
                                message: messApprove(selectedItems.count),
                                onConfirm: {
                                    handle?(.exportAll(action: .request(items: Filter())))
                                }
                            )
                        },
                        title: IBResourcesStrings.taoTraSoat,
                        size: .large
                    )
                }
                .greedyWidth()
                .padding(.top, .spacing.spaceS)
                .padding(.horizontal, .spacing.spaceM)
                .padding(.bottom, safeAreaInsets.bottom > 0 ? safeAreaInsets.bottom : .spacing.spaceS)
                .background(themeCoordinator.color.bgMainTertiary.ignoresSafeArea())
                .styleShadow(.shadowsShadowL0)
                .styleShadow(.shadowsShadowL1)
            }
            
        }
        .onChangeValue(of: state.exportAll, {
            if case let .success(result: str) = $0 {
                
                Task {
                    let data = await FileUtils.downloadFile(url: str)
                    switch data {
                    case .success(let success):
                        validURLString = success.absoluteString
                        showDocumentExporter = true
                    case .failure(let failure):
                        break
                    }
                }
                
            }
        })
        .sheet(isPresented: $showDocumentExporter, content: {
            if let validURL = URL(string: validURLString) {
                DocumentExporter(fileURL: validURL).ignoresSafeArea(.all)
            }
        })
    }
    public func messApprove(_ value: Int = 0) -> String {
        return value > 1 ? IBResourcesStrings.quyKhachCoChacChanThucHienThuHoiDGiaoDich(value) : IBResourcesStrings
            .quyKhachCoChacChanThuHoiGiaoDich
    }
}
