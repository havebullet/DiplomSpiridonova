//
//  ReceivingMethodView.swift
//  Shop
//
//  Created by Настя on 18.04.2022.
//

import SwiftUI

enum ReceivingMethodState: String, CaseIterable {
    case CDEK = "Доставка СДЭК"
    case pochtaRossii = "Почта России"
    case pickup = "Самовывоз"
}

struct ReceivingMethodView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showNextStep: Bool = false
    @State var state: ReceivingMethodState = .CDEK
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 11){
                    Text("Способ получения")
                        .foregroundColor(Color.black)
                        .font(.custom(montserrat, size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Выберите способ получения наиболее удобный для вас")
                        .foregroundColor(Color("bar"))
                        .font(.custom(montserrat, size: 12))
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, 38)
                
                VStack(spacing: 10) {
                    ForEach(ReceivingMethodState.allCases, id: \.self) { item in
                        SegmentItem(item: item)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 38)
            Spacer()
            CustomButton(title: "ДАЛЬШЕ") {
                showNextStep = true
            }
            .padding(.horizontal, 52)
            .padding(.bottom, 52)
            .disabled(state == .pickup)
            .opacity(state == .pickup ? 0.75 : 1)
            .overlay(
                NavigationLink(isActive: $showNextStep, destination: {
                    AddressView()
                }, label: {
                    EmptyView()
                })
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

extension ReceivingMethodView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("Оформление".uppercased())
                .foregroundColor(Color.white)
                .font(.custom(montserrat, size: 17))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                    })
                        .padding(.leading)
                    ,alignment: .leading
                )
        }
    }
    
    //MARK: - Segment Item
    @ViewBuilder func SegmentItem(item: ReceivingMethodState) -> some View {
        Button {
            withAnimation {
                state = item
            }
        } label: {
            HStack(spacing: 6) {
                if item == state {
                    Circle()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color(#colorLiteral(red: 0.8962838054, green: 0.5385740399, blue: 0.6028584838, alpha: 1)))
                        .overlay(
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.white)
                        )
                        .matchedGeometryEffect(id: "Methods", in: animation)
                } else {
                    Circle()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.white)
                        .overlay(
                        Circle()
                            .stroke(lineWidth: 0.75)
                            .foregroundColor(Color(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
                        )
                }
                
                Text(item.rawValue)
                    .foregroundColor(Color("bar"))
                    .font(.custom(montserrat, size: 14))
            }
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
    
}
