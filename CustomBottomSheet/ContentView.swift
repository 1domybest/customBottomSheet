//
//  ContentView.swift
//  CustomBottomSheet
//
//  Created by 온석태 on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    @State var isBottomOpen:Bool = false
    var bottomView: AnyView = AnyView(Test())
    @ObservedObject var bottomModalViewModel:BottomModalViewModel = BottomModalViewModel()
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button(action: {
                    bottomModalViewModel.isShowing.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 100)
                        .overlay (
                            Text("모달 \(bottomModalViewModel.isShowing ? "ON" : "OFF")")
                                .foregroundColor(Color.white)
                                .bold()
                        )
                    
                })
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
        .bottomModal(isShowing: self.$bottomModalViewModel.isShowing, bottomModel: self.bottomModalViewModel.bottomModel)
    }
}

struct Test:View {
    var body: some View {
        ZStack {
            VStack {
                ForEach(0..<190, id: \.self) { item in
                    Text("\(item)")
                }
            }
        }
    }
}


class BottomModalViewModel: ObservableObject {
    @Published var isShowing:Bool = false
    @ObservedObject var bottomModel:BottomModalModel
    
    init() {
        self.bottomModel = BottomModalModel(modalHeight: 900, dragAvailable: true, availableOutTouchClose: true, sheetColor: Color.red, someView: AnyView(Test()))
    }
    
    func show () {
        self.isShowing = true
    }
}
