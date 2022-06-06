//
//  ConfirmView.swift
//  Shop
//
//  Created by Настя on 19.04.2022.
//

import SwiftUI
import Introspect

enum PaymentState: String, CaseIterable {
    case cash = "Оплата наличными курьеру"
    case card = "Оплата картой курьеру"
}

struct ConfirmView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartDataModel: CartDataModel
    @EnvironmentObject var tabVM: TabViewModel
    @State var paymentState: PaymentState = .cash
    @State var showCustomAlert = false
    @State var confirmOrder = false
    @Namespace var animation
    
    var date = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 11){
                        Text("Выберите способ\nоплаты заказа")
                            .foregroundColor(Color.black)
                            .font(.custom(montserrat, size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(2)
                        Text("Выберите удобный для Вас способ оплаты. На данный момент оплата онлайн не работает, только при оплате курьеру.")
                            .foregroundColor(Color("bar"))
                            .font(.custom(montserrat, size: 12))
                            .multilineTextAlignment(.leading)
                            .lineLimit(6)
                    }
                    .padding(.top, 38)
                    
                    VStack(spacing: 10) {
                        ForEach(PaymentState.allCases, id: \.self) { item in
                            SegmentItem(item: item)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        Text("Сумма заказа ")
                            .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.3725490196, blue: 0.4666666667, alpha: 1)))
                            .font(.custom(montserrat, size: 18))
                            .fontWeight(.semibold)
                        Text("\(cartDataModel.totalPrice) рублей")
                            .foregroundColor(Color.black)
                            .font(.custom(montserrat, size: 18))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 38)
            }
            BottomView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .disabled(showCustomAlert)
        .overlay(
            ZStack{
                if showCustomAlert {
                    CustomAlert(title: "Спасибо за оформленный заказ!", message: "В ближайшее время с Вами свяжутся наши менеджеры для окончательного подтверждения", buttonTitle: "Хорошо") {
                        tabVM.profile?.orders?.append(Order(date: "\(date.string(with: "dd.MM.yyyy"))",
                                                            items: cartDataModel.items))
                        cartDataModel.clearCart()
                        withAnimation {
                            showCustomAlert = false
                            confirmOrder = true
                        }
                    }
                }
            }
        )
        .introspectNavigationController(customize: { navController in
            if confirmOrder {
                navController.dismiss(animated: true, completion: nil)
            }
        })
        
    }
}

extension ConfirmView {
    
    //MARK: - Navigation Bar
    @ViewBuilder func NavigationBar() -> some View {
        NavBarView {
            Text("Подтверждение".uppercased())
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
    @ViewBuilder func SegmentItem(item: PaymentState) -> some View {
        Button {
            withAnimation {
                paymentState = item
            }
        } label: {
            HStack(spacing: 6) {
                if item == paymentState {
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
    
    //MARK: - Bottom View
    @ViewBuilder func BottomView() -> some View {
        VStack(alignment:.leading, spacing: 0) {
            Text("Если всё верно, то")
                .font(.custom(montserrat, size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.bottom, 12)
            Text("Подтвердите свой заказ, нажав на кнопку")
                .font(.custom(montserrat, size: 12))
                .foregroundColor(Color("bar"))
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 24)
            Button {
                withAnimation {
                    showCustomAlert = true
                }
            } label: {
                Text("ПОДТВЕРДИТЬ ЗАКАЗ")
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.7)
            }
            .buttonStyle(PinkButtonStyle())
        }
        .padding(.horizontal, 38)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)).ignoresSafeArea())
    }
}

extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
