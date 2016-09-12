//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let currentCalendar = Calendar.current
let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
var comp = currentCalendar.dateComponents(unitFlags, from: forDate)
comp.setValue(0, for: .hour)
comp.setValue(0, for: .minute)
comp.setValue(0, for: .second)


print(currentCalendar.date(from: comp)!)
