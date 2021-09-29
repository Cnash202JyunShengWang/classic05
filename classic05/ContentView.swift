//
//  ContentView.swift
//  classic05
//
//  Created by 暨大附中 on 2021/9/17.
//

import SwiftUI

struct ContentView: View {
    init(){
    UITableView.appearance().backgroundColor = .clear
    UITableViewCell.appearance().backgroundColor = .clear
}
    @State var demo = msgs
    @State var speak = ""
    @State var onOFF = true
    
    
    var body: some View {
        ZStack{
            List(demo){item in
                if (item.isMyTalk == false){
                    LeftMsg(item:item.speak)
                }else{
                    RightMsg(item:item.speak)
                }
            }
            //.background(Image("04").resizable())
            VStack {
                Spacer()
                HStack{
                    TextField("",text: $speak)
                        .frame(height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .cornerRadius(20)
                    GradientButton(text: "傳送") {
                        demo.append(msg(speak: speak,isMyTalk: onOFF))
                        onOFF.toggle()
                                    }
                  
                }
                .frame(height:100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }.background(Image("04").resizable().ignoresSafeArea().opacity(0.4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct RightMsg  :View{
    
    var item : String
    var body: some View{
        HStack{
            Spacer()
            HStack{
            Text("\(item)")
            Image("02")
            .resizable()
        .frame(width: 70, height: 70, alignment: .center)
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
        }
        }
    }
}
struct LeftMsg : View {
    var item : String
    var body : some View{
        HStack{
            Image("03")
                .resizable()
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        Text("\(item)")
        }
        }
    }
struct msg :Identifiable{
    var id = UUID()
    var speak : String
    var isMyTalk = false
}
let msgs=[msg(speak:"哈嘍")]
struct GradientButton: View {
    
    var text:String
    
    var complete:()->Void
    
    var body: some View {
        Button(action: {
            complete()
        }, label: {
                ZStack{
                    GradientText(text: text)
                        .font(.headline)
                        .frame(width:100, height: 100)
                        .background(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)).opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.white,lineWidth: 1.9)
                                .blendMode(.normal)
                                .opacity(0.7)
                        )
                        .cornerRadius(100)
                }
          
        })
    }
}


struct GradientText: View {
    
    var text:String
    
    var body: some View {
        Text(text)
            .linearGradientBackground(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))])
    }
}

extension View{
    func angularGradientGlow(colors: [Color]) -> some View {
        self.overlay(AngularGradient(gradient: Gradient(colors: colors), center: .center, angle: .degrees(0.0)))
            .mask(self)
    }
    
    func linearGradientBackground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}
