//
//  TermsView.swift
//  Shop
//
//  Created by Настя on 19.04.2022.
//

import SwiftUI

struct TermsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showNextStep: Bool = false
    @State var orderFlag: Bool = false
    @State var comment: String = ""
    @State var showDataPicker = false
    @State var date = Date()
    
    var closedRange: ClosedRange<Date> {
        let date = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let sevenDaysBefore = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        
        return date...sevenDaysBefore
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationBar()
                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 30) {
                            VStack(spacing: 30) {
                                VStack(alignment: .leading, spacing: 11){
                                    Text("Условия доставки")
                                        .foregroundColor(Color.black)
                                        .font(.custom(montserrat, size: 20))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Выберите подходящую для вас дату доставки (если у вас доставка СДЭК или Почта России, выберите любое число, так как дата доставки будет зависеть от вашего адреса)")
                                        .foregroundColor(Color("bar"))
                                        .font(.custom(montserrat, size: 12))
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.top, 38)
                                
                                ZStack {
                                    if showDataPicker {
                                        DatePicker("", selection: $date, in: closedRange)
                                            .labelsHidden()
                                            .datePickerStyle(.compact)
                                    } else {
                                        InfoItemView(title: "Выберите день доставки")
                                            .onTapGesture {
                                                withAnimation {
                                                    showDataPicker.toggle()
                                                }
                                            }
                                    }
                                }
                                
                                SegmentItem()
                            }
                            .padding(.horizontal, 38)
                            
                            Rectangle()
                                .frame(height: 12)
                                .foregroundColor(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)))
                            
                            VStack(spacing: 30) {
                                VStack(alignment: .leading, spacing: 11){
                                    Text("Дополнительно")
                                        .foregroundColor(Color.black)
                                        .font(.custom(montserrat, size: 20))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Если у вас есть промокод, какие-то пожелания к заказу или комментарий, то можете написать это здесь. После заказа с вами свяжется менеджер.")
                                        .foregroundColor(Color("bar"))
                                        .lineLimit(5)
                                        .font(.custom(montserrat, size: 12))
                                        .multilineTextAlignment(.leading)
                                }
                                
                                CustomTextField(text: $comment, placeholder: "Комментарий к заказу")
                                
                            }
                            .padding(.horizontal, 38)
                        }
                    }
                    BottomView()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

extension TermsView {
    
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
    @ViewBuilder func SegmentItem() -> some View {
        Button {
            withAnimation {
                orderFlag.toggle()
            }
        } label: {
            HStack(spacing: 6) {
                if orderFlag == true {
                    Circle()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color(#colorLiteral(red: 0.8962838054, green: 0.5385740399, blue: 0.6028584838, alpha: 1)))
                        .overlay(
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.white)
                        )
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
                
                Text("Заказ получаю не я")
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
            Text("Приятных покупок и хорошего настроения!")
                .font(.custom(montserrat, size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.bottom, 12)
            Text("Указывая свои контактные данные, вы принимаете условия пользовательского соглашения")
                .font(.custom(montserrat, size: 12))
                .foregroundColor(Color("bar"))
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 24)
            NavigationLink {
                ConfirmView()
            } label: {
                Text("ВЫБЕРИТЕ СПОСОБ ОПЛАТЫ")
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


