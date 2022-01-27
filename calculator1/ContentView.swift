//
//  ContentView.swift
//  calculator1
//
//  Created by Nazar Babyak on 05.10.2021.
//

import SwiftUI

enum CalcButton : String {
    case one = "1"
    case two = "2"
    case tree = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    //додати
    case subtract = "-"
    //відняти
    case divide = "/"
    //поділити
    case multiply = "*"
    //помножити
    case equal = "="
    //рівне
    case clear = "AC"
    //очистити
    case desimal = "."
    //десяткова
    case percente = "%"
    //процент
    case negative = "-/+"
    //негативний-позитивний
    
    var buttonColor : Color {
        switch self {
        case .divide, .multiply, .subtract, .add:
            return Color(UIColor(red:160/255.0, green:107/255.0, blue:57/255.0, alpha:  1))
        case .clear, .negative, .percente:
            return Color(UIColor(red:135/255.0, green: 60/255.0, blue:30/255.0, alpha:1))
        default: return Color(UIColor(red:198/255.0, green:195/255.0, blue:179/255.0, alpha:1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
    
}


struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percente, .divide],
        [.one, .two, .tree, .multiply],
        [.four, .five, .six, .subtract],
        [.seven, .eight, .nine, .add],
        [.zero, .desimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red:225/255.0, green:225/255.0, blue:225/255.0, alpha:1)).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                // текст дисплею
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 72))
                        .foregroundColor(.black)
                        
                }
                .padding()
                // кнопки
                ForEach(buttons, id: \.self) { row in
                    
                    HStack(spacing: 9) {
                    ForEach(row, id:  \.self) { item in
                        Button(action: {
                            self.didTap(button: item)

                            }, label:{
                                Text(item.rawValue)
                                    .font(.system (size: 33))
                                    .frame(
                                        width: self.buttonWidht(item: item),
                                        height: self.buttonHeight() )
                                    .background(item.buttonColor)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(self.buttonWidht(item: item)/4 )
                                    .shadow(color: .gray, radius: 2, x: 2, y: 2)


                            })
                        
                      
                    }
                }
                    .padding(.bottom, 3)
                }
            }
            
        }
    }
    func didTap(button: CalcButton){
        switch button {
        case .add, .subtract, .divide, .multiply, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentvalue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentvalue)"
                case .subtract: self.value = "\(runningValue - currentvalue)"
                case .multiply: self.value = "\(runningValue * currentvalue)"
                case .divide: self.value = "\(runningValue /  currentvalue)"
                case .none:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
        case  .clear:
         self.value = "0"
        case  .desimal, .negative, .percente:
            break
        default:
        let number = button.rawValue
        if self.value == "0"{
            value = number
        
        }
        else {
            self.value = "\(self.value)\(number)"
        }
    }
    }
        func buttonWidht(item: CalcButton) -> CGFloat {
            if item == .zero {
                return ((UIScreen.main.bounds.width - (5*12)) / 4)*2
            }
            return (UIScreen.main.bounds.width - (5*12)) / 4
        
    }
    func buttonHeight() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

