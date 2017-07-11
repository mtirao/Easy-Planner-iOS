//: Playground - noun: a place where people can play

import UIKit

class ConsolePrinter {
    
    func printOut(message:String) {
        print(message)
    }
    
    func schedulePrint(of message: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds:100)) {
            [unowned self] in
            self.printOut(message: message)
        }
    }
}

func printMessage() {
    
    let printer = ConsolePrinter()
    print("Hola")
    printer.schedulePrint(of: "Hello")
    
}

printMessage()




