//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let myFruits = ["blackberry", "orange", "banana"]

var myFood = myFruits[0];

if (myFood == "Blackberry") {
    print("in if")
}else if(myFood == "orange"){
    print("in else if 1")
}else{
    print("in else")
}

var myFooodType = (myFood == "blackberry") ? "It's BlackBerry" : "Other"

switch myFood {
case "blackberry":
    print("It's \(myFood)")
case "orange":
    print("It's \(myFood)")
case "banana":
    print("It's \(myFood)")
default:
    print("It's not fruit")
}



/****** Start of lesson 3  ****/
var array = ["ford","BMW","Mercedeze"]
let car = array[2]

var dict = ["Ford" : "Mustange" , "BMW" : "BMW GT" , "Mercedeze" : "C Class"]

// For array operations.
array[0] = "Suzuki"
array.append("Chevy")
array.remove(at: 0)
print(array)

// For dictionary

dict["BMW"] = "GT150"
print(dict)
dict["Chevy"] = "Impala"
var myCar = dict["Ford"]
print(dict)

/****** Start of lesson 2  ****/


//for (var j = 0 ; j < array.count ; j++){
//    print(array[j])
//}

for car in array{
    print("The car is \(car)")
}

// For dictionary

for (key, value) in dict{
    print("The car is \(key) and the model is \(value)")
}

for carBrand in dict.keys {
    print("Car brand is \(carBrand)")
}



/******* Start of lesson 6 ********/

class myCarsClass{
    var model = "Mustange"
    var brand = "Ford"
}

let getcarsClass = myCarsClass()
print(getcarsClass.model)


class anotherClass{
    
    var Model:String?
    var Brand:String?
    
    init(){}
    
    init(model : String , brand : String ) {
        self.Model = model
        self.Brand = brand
    }
    
}

let customClass = anotherClass(model: "Chevy", brand: "Impala")
print(customClass.Brand ?? "")


/********* Start of lesson 7 (enum) ***********/

enum dayItems : String{
    case Monday = "monday"
    case Tuesday = "tuseday"
    case Wednesday = "wednesday"
}

var dayName = "monday"

if (dayName == dayItems.Monday.rawValue){
    print("Monday")
}



enum month : Int{
    case jan = 0, feb,march,april
}

var monthPosition = 0

if (monthPosition == month.jan.rawValue) {
    print("Month position is jan")
}

enum carEnum{
    case Ford(String)
    case Chevy(String)
    case Audi(String)
}

let carType = carEnum.Ford("Mustange")

switch carType {
    case .Ford:
        print("type is ford")
    default:
        print("default")
}











