//
//  CheckerListInquiryFilterView.swift
//  IBInquiry
//
//  Created by tran dinh quy on 7/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources
import IBViewComponents
import IBFeatureCommon

struct CheckerListInquiryFilterView: View {
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.sheetCoordinator) public var sheetCoordinator
    @Environment(\.themeCoordinator) private var themCoordinator
    
    @StateObject private var viewModel = CheckerListInquiryFilterViewModel()
    
    @State var expirationTime: String = ""
    @State var inquiryReason: String = ""
    @State var inquiryCode: String = ""
    @State var createdDateFrom: String = ""
    @State var createdDateTo: String = ""
    @State var createBy: String = ""
    @State var listTransactionsChannel: [CategoryResponseEntity] = []
    
    var title: String
    @Binding var isShow: Bool
    
    var filter: CheckerListTransInquiryFilter
    var handle: ((CheckerListTransInquiryFilter) -> Void)?
    
    init(title: String, isShow: Binding<Bool>, filter: CheckerListTransInquiryFilter, handle: ((CheckerListTransInquiryFilter) -> Void)?) {
        self.title = title
        self._isShow = isShow
        self.filter = filter
        self.handle = handle
    }
    
    @MainActor
    func showDatePickerRangeSheet() {
        sheetCoordinator.show(
            IBCalendarBottomSheet.datePickerRange(
                title: IBResourcesStrings.chonKhoangThoiGian,
                fromDate: createdDateFrom,
                toDate: createdDateTo,
                datePickerConfig: DatePickerConfig(startMonth: nil, endMonth: nil),
                onChange: { start, end in
                    createdDateFrom = start ?? ""
                    createdDateTo = end ?? ""
                    expirationTime = "\(start ?? "") - \(end ?? "")"
                },
                navigation: navigation
            )
        )
    }
    
    var body: some View {
        IBBottomSheet(isPresented: $isShow,
                      detent: .height(UIScreen.main.bounds.height * 0.9),
                      title: title,
                      alignment: .leading,
                      wrapContentInsideScrollView: false,
                      onDismiss: {
            isShow = false
            handle?(filter.with(serviceType: "new type"))
        },
                      content: {
            VStack {
                ScrollView {
                    VStack(spacing: .spacing.spaceS) {
                        IBInputDropdownListView(
                            listContent: .constant(
                                listTransactionsChannel.compactMap {
                                    .init(
                                        isSelected: true, title: $0.name ?? "",
                                        data: $0)
                                }), hintText: IBResourcesStrings.loaiGiaoDich,
                            title: IBResourcesStrings.loaiGiaoDich,
                            onTap: {
                                sheetCoordinator.show(
                                    TransSheet.paymentSelectTransType(
                                        selectResult: {
                                            listTransactionsChannel = $0
                                        }, selectedItem: listTransactionsChannel))
                            }, onDeleteContent: { index in
                                listTransactionsChannel.remove(at: index)
                            }, onClearAll: {
                                listTransactionsChannel = []
                            })
                        
                        IBInputDropdownView(
                            label: IBResourcesStrings.lyDoTraSoat,
                            onTap: {
                                sheetCoordinator.show(
                                    TransSheet.inquirySelectReason(selectResult: {
                                        inquiryReason = $0.name ?? ""
                                        inquiryCode = $0.code ?? ""
                                    }, selectedItem: inquiryReason.isEmpty ? nil : CategoryResponseEntity(name: inquiryReason)))
                            },
                            trailingIcon: Button(action: {
                                sheetCoordinator.show(
                                    TransSheet.inquirySelectReason(selectResult: {
                                        inquiryReason = $0.name ?? ""
                                        inquiryCode = $0.code ?? ""
                                    }, selectedItem: inquiryReason.isEmpty ? nil : CategoryResponseEntity(name: inquiryReason)))
                            }, label: {
                                IBResourcesAsset.arrowBottomOutline.swiftUIImage.resizable().frame(width: 16, height: 16).erased()
                            }),
                            text: inquiryReason)
                        
                        IBInputDropdownView(
                            label: IBResourcesStrings.thoiGianTraSoat,
                            onTap: {
                                showDatePickerRangeSheet()
                            },
                            trailingIcon: Button(action: {
                                showDatePickerRangeSheet()
                            }, label: {
                                IBResourcesAsset.calendarOutline.swiftUIImage.resizable().frame(width: 16, height: 16).erased()
                            }).erased(),
                            text: expirationTime)
                        
                        IBInputFieldView(label: IBResourcesStrings.nguoiTaoTraSoat,
                                         text: $createBy,
                                         height: 56)
                    }
                }.padding(.bottom, .spacing.spaceS)
                
                HStack {
                    IBButton(
                        action: {
                            expirationTime = ""
                            inquiryReason = ""
                            inquiryCode = ""
                            createdDateFrom = ""
                            createdDateTo = ""
                            createBy = ""
                            listTransactionsChannel = []
                            handle?(filter.with(model: CheckerListInquiryFilterModel(), filterCount: 0))
                        },
                        title: IBResourcesStrings.xoaBoLoc,
                        style: .secondaryGray,
                        size: .large
                    ).padding(.trailing, .spacing.spaceM)
                    IBButton(
                        action: {
                            let filterObject = viewModel.createTransFilterModel(
                                txnType: listTransactionsChannel.map { $0.code ?? "" },
                                inquiryReason: inquiryCode,
                                createdDateFrom: createdDateFrom.formatToISODate(),
                                createdDateTo: createdDateTo.formatToISODate(),
                                createdBy: createBy
                            )
                            isShow = false
                            handle?(filter.with(model: filterObject.0, filterCount: filterObject.1))
                        },
                        title: IBResourcesStrings.apDung,
                        style: .primary,
                        size: .large
                    )
                }
            }
            .padding(.vertical, .spacing.spaceS)
            .padding(.horizontal, .spacing.spaceM)
            .background(themCoordinator.color.bgMainTertiary)
        })
    }
}
