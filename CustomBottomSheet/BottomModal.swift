//
//  BottomModal.swift
//  CustomBottomSheet
//
//  Created by 온석태 on 3/20/24.
//

import Foundation
import SwiftUI
import SwiftUIIntrospect
class BottomModalModel: ObservableObject {
    var modalHeight: CGFloat
    var dragAvailable: Bool = true
    var availableOutTouchClose: Bool = true
    var autoHeight: Bool = true
    var outSheetColor: Color = Color.white.opacity(0.4)
    var showHandler: Bool = true
    var sheetColor: Color = Color.black.opacity(0.3)
    var sheetShadowColor: Color = Color.gray
    var handlerColor: Color = Color.gray.opacity(0.3)
    var someView: AnyView
    @Published var dragAmount: CGFloat = 0
    var isOverHeight: Bool = false
    
    
    init(modalHeight: CGFloat, dragAvailable: Bool, availableOutTouchClose: Bool, sheetColor: Color, someView: AnyView) {
        self.modalHeight = modalHeight
        self.dragAvailable = dragAvailable
        self.availableOutTouchClose = availableOutTouchClose
        self.sheetColor = sheetColor
        self.someView = someView
    }
}

//struct BottomModal: ViewModifier {
//    @Binding var isShowing: Bool
//    @ObservedObject var bottomModel: BottomModalModel
//    @State var offset: CGFloat = .zero
//    var sheetSafeTopPadding:CGFloat = 50
//    var sheetHandlerHeight:CGFloat = 20
//    // body 메서드를 수정하여 Self.Content를 올바르게 처리합니다.
//    @State var didCheckOverHeight:Bool = false
//    func body(content: Self.Content) -> some View {
//        ZStack {
//            content
//                .overlay (
//                    ZStack {
//                        VStack {
//                            Spacer()
//                            Spacer().frame(width: UIScreen.main.bounds.width, height: sheetSafeTopPadding).background(bottomModel.outSheetColor.opacity(0.000000001))
//                            // 바텀 시트 틀
//                            Rectangle()
//                                .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
//                                .foregroundColor(bottomModel.sheetColor)
//                                .frame(width: UIScreen.main.bounds.width, height: bottomModel.modalHeight)
//                                .shadow(
//                                    // 그림자
//                                        color: bottomModel.sheetShadowColor,
//                                        radius: CGFloat(20),
//                                        x: CGFloat(0), y: CGFloat(0)
//                                )
//                                .overlay(
//                                    // 손잡이
//                                    VStack {
//                                        Spacer().frame(height: 10)
//                                        Capsule()
//                                            .frame(width: 36, height: 4)
//                                            .foregroundColor(self.bottomModel.handlerColor)
//                                        Spacer()
//                                    }.opacity(self.bottomModel.showHandler ? 1 : 0)
//                                )
//                                .overlay (
//                                    // 들어갈 콘텐트
//                                    VStack {
//                                        Spacer().frame(height: sheetHandlerHeight + sheetSafeTopPadding) // 손잡이 길이 빼기
//                                        
//                                        self.bottomModel.someView.introspect(.view, on: .iOS(.v14, .v15, .v16, .v17)) { viewController in
//                                            if self.bottomModel.autoHeight {
//                                                if !didCheckOverHeight {
//                                                    self.didCheckOverHeight = true
//                                                    let height = viewController.frame.height - sheetHandlerHeight + sheetSafeTopPadding
//                                                    let isOverHeight = UIScreen.main.bounds.height - height < 0
//                                                    if isOverHeight {
//                                                        self.bottomModel.isOverHeight = true
//                                                        self.bottomModel.modalHeight = UIScreen.main.bounds.height - (sheetHandlerHeight + sheetSafeTopPadding)
//                                                    } else {
//                                                        self.bottomModel.isOverHeight = false
//                                                        self.bottomModel.modalHeight = height
//                                                    }
//                                                }
//                                               
//                                            }
//                                        }
//                                        
//                                        Spacer()
//                                    }
//                                )
//                        }
//                    }
//                    .offset(y: isShowing ? 0 : UIScreen.main.bounds.height)
//                    .offset(y: offset + bottomModel.dragAmount)
//                    .opacity(isShowing ? 1 : 0)
//                    .animation(.easeInOut) // 애니메이션 효과 추가
//                    .background(
//                            bottomModel.outSheetColor
//                            .opacity(isShowing ? 1 : 0)
//                            .animation(.default)
//                            .onTapGesture {
//                                isShowing = false
//                            }
//                    )
//                    .ignoresSafeArea(.all)
//                    
//                    .gesture(
//                        DragGesture()
//                            .onChanged { value in
//                                if !self.bottomModel.dragAvailable { return }
//                                self.bottomModel.dragAmount = value.translation.height
//                            }
//                            .onEnded{ value in
//                                if !self.bottomModel.dragAvailable { return }
//                                withAnimation {
//                                    if self.bottomModel.dragAmount > self.bottomModel.modalHeight / 4 {
//                                        if value.velocity.height < 200.0 {
//                                            self.bottomModel.dragAmount = 0
//                                            return
//                                        } else {
//                                            self.isShowing = false
//                                            self.bottomModel.dragAmount = 0
//                                        }
//                                    } else {
//                                        self.bottomModel.dragAmount = 0
//                                    }
//                                }
//                            }
//                    )
//                )
//        }
//        .onAppear {
//            print("onApear")
//        }
//    }
//}



struct BottomModal: ViewModifier {
    @Binding var isShowing: Bool
    @ObservedObject var bottomModel: BottomModalModel
    @State var offset: CGFloat = .zero
    var sheetSafeTopPadding:CGFloat = 50
    var sheetHandlerHeight:CGFloat = 20
    // body 메서드를 수정하여 Self.Content를 올바르게 처리합니다.
    @State var didCheckOverHeight:Bool = false
    func body(content: Self.Content) -> some View {
        ZStack {
            content
                .overlay (
                    ZStack {
                        VStack {
                            Spacer()
                            Spacer().frame(width: UIScreen.main.bounds.width, height: sheetSafeTopPadding).background(bottomModel.outSheetColor.opacity(0.000000001))
                            // 바텀 시트 틀
                            Rectangle()
                                .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
                                .foregroundColor(bottomModel.sheetColor)
                                .frame(width: UIScreen.main.bounds.width, height: bottomModel.modalHeight)
                                .shadow(
                                    // 그림자
                                        color: bottomModel.sheetShadowColor,
                                        radius: CGFloat(20),
                                        x: CGFloat(0), y: CGFloat(0)
                                )
                                .overlay(
                                    // 손잡이
                                    VStack {
                                        Spacer().frame(height: 10)
                                        Capsule()
                                            .frame(width: 36, height: 4)
                                            .foregroundColor(self.bottomModel.handlerColor)
                                        Spacer()
                                    }.opacity(self.bottomModel.showHandler ? 1 : 0)
                                )
                                .overlay (
                                    // 들어갈 콘텐트
                                    VStack {
                                        Spacer().frame(height: sheetHandlerHeight + sheetSafeTopPadding) // 손잡이 길이 빼기
//                                        ScrollView {
//                                           
//                                        }
//                                        .disabled(true)
                                        self.bottomModel.someView.introspect(.view, on: .iOS(.v14, .v15, .v16, .v17)) { viewController in
                                            if self.bottomModel.autoHeight {
                                                if !didCheckOverHeight {
                                                    self.didCheckOverHeight = true
                                                    let height = viewController.frame.height + sheetHandlerHeight + sheetSafeTopPadding
                                                    let isOverHeight = UIScreen.main.bounds.height - height < 0
                                                    if isOverHeight {
                                                        print(height)
                                                        self.bottomModel.isOverHeight = true
                                                        self.bottomModel.modalHeight = height
                                                        offset = height/2
                                                    } else {
                                                        self.bottomModel.isOverHeight = false
                                                        self.bottomModel.modalHeight = height
                                                    }
                                                } else {
                                                    
                                                    // -928
                                                    // -1340
                                                    
                                                    
                                                    
                                                    //  2126
                                                    // -2185
                                                    
                                                    
                                                    
                                                    print(UIScreen.main.bounds.height) //667.0
                                                    print(self.bottomModel.modalHeight) //3145.0
                                                    print(offset)
                                                }
                                            }
                                        }
                                        .frame(height: self.bottomModel.modalHeight)
                                       // Spacer()
                                    }
                                    
                                )
                        }
                    }
                    .offset(y: isShowing ? 0 : UIScreen.main.bounds.height)
                    .position(x: 100, y: offset + bottomModel.dragAmount)
                    .opacity(isShowing ? 1 : 0)
                    .animation(.easeInOut) // 애니메이션 효과 추가
                    .background(
                            bottomModel.outSheetColor
                            .opacity(isShowing ? 1 : 0)
                            .animation(.default)
                            .onTapGesture {
                                isShowing = false
                            }
                            .frame(width: UIScreen.main.bounds.width)
                    )
                    .ignoresSafeArea(.all)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if !self.bottomModel.dragAvailable { return }
                                if self.bottomModel.isOverHeight {
                                    self.bottomModel.dragAmount = value.translation.height
                                } else {
                                    self.bottomModel.dragAmount = value.translation.height
                                }
                                
                            }
                            .onEnded{ value in
                                if !self.bottomModel.dragAvailable { return }
                                withAnimation {
                                    // 20은 패딩인듯함
                                    print("현재 \(offset + bottomModel.dragAmount)")
                                    print("과연 \(-((self.bottomModel.modalHeight/2 - 844)  + 20))")
                                    if self.bottomModel.isOverHeight {
//                                        let max = (self.bottomModel.modalHeight/4) + 146
//                                        if -max > (offset + bottomModel.dragAmount) {
//                                            self.offset = -max
//                                            self.bottomModel.dragAmount = 0
//                                        } else {
//                                            self.offset += self.bottomModel.dragAmount
//                                            self.bottomModel.dragAmount = 0
//                                        }
                                        
                                        self.offset += self.bottomModel.dragAmount
                                        self.bottomModel.dragAmount = 0
                                    } else {
                                        if self.bottomModel.dragAmount > self.bottomModel.modalHeight / 4 {
                                            if value.velocity.height < 200.0 {
                                                self.bottomModel.dragAmount = 0
                                                return
                                            } else {
                                                self.isShowing = false
                                                self.bottomModel.dragAmount = 0
                                            }
                                        } else {
                                            self.bottomModel.dragAmount = 0
                                        }
                                    }
                                }
                            }
                    )
                )
        }
        .onAppear {
            print("onApear")
        }
    }
}

extension View {
    // content 매개변수를 사용하여 modalContent를 직접 전달합니다.
    func bottomModal(isShowing: Binding<Bool>,bottomModel: BottomModalModel
    ) -> some View {
        self.modifier(BottomModal(isShowing: isShowing,bottomModel: bottomModel))
    }
    
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


/// step 1 -- Create a shape view which can give shape
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

/// step 2 - embed shape in viewModifier to help use with ease
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
