//optionals
import PlaygroundSupport

var score : Int?
score = 80

if score != nil {
    print("score is score!")
}

if let currentScore = score {
    print("My current score is \(currentScore)")
}

var newScore : Int! = 95
print ("My new score is", newScore)



//CollectionTypes (arrays - ordered, sets - unordered distinct values, dictionaries - unordered)

//Arrays
var shoppingList = ["cereal", "milk"]
print (shoppingList[0])

shoppingList.append("bread")

if shoppingList.isEmpty{
    print("there is nothing you need")
} else {
    print("you need \(shoppingList.count)" + " items")
}

let removedItem = shoppingList.removeLast()

for item in shoppingList.reversed(){
    print(item)
}

//Dictionaries
var newList=[String:String]()
var classes=["4120":"MAD", "3000":"Code"]
classes["3000"]
classes["2000"]="MIT"
classes.count

classes.updateValue("Mobile App Dev", forKey: "4120")
classes.removeValue(forKey: "3000")
classes["2000"]="new class"

for (num, name) in classes{
    print("\(num): \(name)")
}



//Functions

func sayHello () {
    print("Hello class")
}

sayHello()

func sayHello (first: String, last: String){
    print("Hi \(first) \(last)")
}

sayHello(first: "Bill", last: "Adams")

func sayWhat (firstName first: String, lastName last: String){
    print("What \(first) \(last)?")
}

sayWhat(firstName: "Nate", lastName:"Jones")

func sayWhere(_ first: String, _ last:String){
    print("Where's \(first) \(last)?")
}


//Closures
let names=["Tom", "Jessie", "Megan", "Angie"]

func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var sortme = names.sorted()

var reversed = names.sorted(by: backwards)

reversed = names.sorted(by: { (s1:String, s2:String) -> Bool in
    return s1 > s2
})
print (reversed)

reversed = names.sorted(by: { s1, s2 in return s1 > s2 } )
print(reversed)

reversed = names.sorted(by: { s1, s2 in s1 > s2 } )
print(reversed)

reversed = names.sorted(by: { $0 > $1} )
print(reversed)


//Enums

enum carType {
    case gas
    case electric
    case hybrid
}

var car = carType.electric
print(car)
car = .hybrid
print(car)

//TypeCasting


enum WebError: Error{
    case Forbidden
    case NotFound
    case RequestTimeout
}





































