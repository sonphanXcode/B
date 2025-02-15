//
//  MackerInitInquirySearchView.swift
//  IBInquiry
//
//  Created by tran dinh quy on 14/2/25.
//  Copyright © 2025 bidv.com. All rights reserved.
//

import SwiftUI
import IBResources
import IBViewComponents
import IBFeatureCommon

struct MackerInitInquirySearchView: View {
    
    @Environment(\.navigationCoordinator) private var navigation
    @Environment(\.sheetCoordinator) public var sheetCoordinator
    @Environment(\.themeCoordinator) private var themCoordinator
    
    @StateObject private var viewModel = MackerInitInquirySearchViewModel()
    
    @State var expirationTime: String = ""
    @State var id: String = ""
    @State var txnType: String = ""
    @State var txnTypeCode: String = ""
    @State var benAccName: String = ""
    @State var benAccNo: String = ""
    @State var startDate: String = ""
    @State var endDate: String = ""
    @State var createBy: String = ""
    @State var isShowHelpTextId: Bool = false
    @State var listTransactionsStatus: [CategoryResponseEntity] = []
    
    var title: String
    @Binding var isShow: Bool
    
    var handle: ((MackerListOriginalTransFilterModel) -> Void)?
    
    init(title: String, isShow: Binding<Bool>, handle: ((MackerListOriginalTransFilterModel) -> Void)?
    ) {
        self.title = title
        self._isShow = isShow
        self.handle = handle
    }
    
    @MainActor
    func showDatePickerRangeSheet() {
        sheetCoordinator.show(
            IBCalendarBottomSheet.datePickerRange(
                title: IBResourcesStrings.chonKhoangThoiGian,
                fromDate: startDate,
                toDate: endDate,
                datePickerConfig: DatePickerConfig(startMonth: nil, endMonth: nil),
                onChange: { start, end in
                    startDate = start ?? ""
                    endDate = end ?? ""
                    expirationTime = "\(start ?? "") - \(end ?? "")"
                },
                navigation: navigation
            )
        )
    }
    
    @MainActor
    func showSelectType() {
        sheetCoordinator.show(
            TransSheet.inquirySelectType(selectResult: {
                txnType = $0.name ?? IBResourcesStrings.chuyenTienTrongNuoc
                txnTypeCode = $0.code ?? "S"
                if txnTypeCode == "B" || txnTypeCode == "P" {
                    self.isShowHelpTextId = true
                } else {
                    self.isShowHelpTextId = false
                }
            }, selectedItem: txnType.isEmpty ? nil : CategoryResponseEntity(name: txnType)))
    }
    
    @MainActor
    func showSelectStatus() {
        sheetCoordinator.show(
            TransSheet.inquirySelectMutilStatus(
                selectResult: {
                    listTransactionsStatus = $0
                }, selectedItem: listTransactionsStatus))
    }
    
    var body: some View {
        IBBottomSheet(isPresented: $isShow,
                      detent: .dynamic,
                      title: title,
                      alignment: .leading,
                      wrapContentInsideScrollView: true,
                      onDismiss: {
            isShow = false
        },
                      content: {
            VStack {
                ScrollView {
                    VStack(spacing: 12) {
                        InlineMessageView(status: .info, header: "", content: IBResourcesStrings.duocTraSoatGiaoDichTrongVong60NgayKeTuNgayHieuLuc)
                        IBInputDropdownView(
                            label: IBResourcesStrings.loaiGiaoDich,
                            onTap: {
                                showSelectType()
                            },
                            trailingIcon: Button(action: {
                                showSelectType()
                            }, label: {
                                IBResourcesAsset.arrowBottomOutline.swiftUIImage.resizable().frame(width: 16, height: 16).erased()
                            }),
                            text: txnType != "" ? txnType : IBResourcesStrings.chuyenTienTrongNuoc)
                        
                        IBInputFieldView(label: IBResourcesStrings.maGiaoDich,
                                         text: $id,
                                         hintTextLeading: isShowHelpTextId ? IBResourcesStrings.neuCanTraSoatThongTinChungVuiLongNhapMaBangKeHoacMaBangLuongNeuCanTraSoatGiaoDichCuTheVuiLongNhapMaGiaoDichBidv : ""
                        )
                        IBInputDropdownListView(
                            listContent: .constant(
                                listTransactionsStatus.compactMap {
                                    .init(
                                        isSelected: true, title: $0.name ?? "",
                                        data: $0)
                                }), hintText: IBResourcesStrings.trangThai,
                            title: IBResourcesStrings.trangThai,
                            onTap: {
                                showSelectStatus()
                            }, onDeleteContent: { index in
                                listTransactionsStatus.remove(at: index)
                            }, onClearAll: {
                                listTransactionsStatus = []
                            })
                        
                        IBInputFieldView(label: IBResourcesStrings.tenNguoiHuong,
                                         text: $benAccName)
                        IBInputFieldView(label: IBResourcesStrings.taiKhoanHuong,
                                         text: $benAccNo)
                        IBInputDropdownView(
                            label: IBResourcesStrings.thoiGianHieuLuc,
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
                                         text: $createBy)
                    }
                }.padding(.bottom, 10)
                
                HStack {
                    IBButton(
                        action: {
                            expirationTime = ""
                            id = ""
                            txnType = ""
                            txnTypeCode = ""
                            benAccName = ""
                            benAccNo = ""
                            startDate = ""
                            endDate = ""
                            createBy = ""
                            listTransactionsStatus = []
                        },
                        title: IBResourcesStrings.xoaBoLoc,
                        style: .secondaryGray,
                        size: .large
                    ).padding(.trailing, 16)
                    IBButton(
                        action: {
                            handle?(MackerListOriginalTransFilterModel(
                                txnType: TransInquiryType(rawValue: txnType)?.type,
                                id: id,
                                status: listTransactionsStatus.map { $0.code ?? "" },
                                benAccName: benAccName,
                                benAccNo: benAccNo,
                                effDateFrom: startDate,
                                effDateTo: endDate,
                                createdBy: createBy
                            ))
                        },
                        title: IBResourcesStrings.timKiem,
                        style: .primary,
                        size: .large
                    )
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(themCoordinator.color.bgMainTertiary)
        })
    }
}
