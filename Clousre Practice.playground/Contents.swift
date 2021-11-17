import UIKit
import Foundation

func sayHamster() {
    print("hamster makes me happy~!")
}

sayHamster()

var hamster = sayHamster
hamster()
//
//func greet() {
//
//}
//greet(hamster)

func introduce(name: String) {
    
}

var people1 = introduce
print(people1)

var array = [1, 4, 2, 5, 3]



func sortFunc(a: Int, b: Int) -> Bool {
    return a < b
}

let sorted = array.sorted(by: sortFunc)

array.sorted(by: { (a: Int, b: Int) -> Bool in
    return a < b
})

//array.sorted { <#Int#>, <#Int#> in
//    <#code#>
//}

// 부가세가 붙는 함수
func addVAT(source: Double) -> Double {
    return source * 1.1
}


// 쿠폰 할인을 해주는 함수
func couponDiscount(source: Double) -> Double {
    return source * 0.9
}

// additional: (Double) -> Double) 이 부분이 함수를 파라미터로 받겠다는 부분
func finalPrice(source: Double, additional: (Double) -> Double) -> Double {
    let price = additional(source)
    return price
}

// 100달러를 샀는데 부가세 붙는 것 -> 110 달러
let transaction1 = finalPrice(source: 100, additional: addVAT)

// (Int) -> Int = [Int를 받아서 Int를 리턴하는 함수]를 반환하는 것
func makeAdder(x: Int) -> (Int) -> Int {
    func adder(a: Int) -> Int {
        return x + a
    }
    return adder
}

let add5 = makeAdder(x: 5)
let add10 = makeAdder(x: 10)
print(add5(2)) // 7
print(add10(2)) // 12

print(makeAdder(x: 5)(2)) // 7
let add24 = makeAdder(x: 24)


print(add24(26))


print(makeAdder(x: 24)(8))


// 클로저 캡처

func greeting() -> (() -> ()) {
    let str = "Bye"
    return {
        print(str)
    }
}

let str = "Good Morning"
let ret = greeting()
ret()

func increment(by amount: Int) -> (() -> ()) {
    var count = 0
    return {
        count += amount
        print(count)
    }
}

var number1 = increment(by: 3)
number1()
number1()
number1()

// 레퍼런스 타입 값 캡처

class MyClass {
    var value = 0
}

func increment2(by amount: Int) -> (() -> ()) {
    let obj = MyClass()
    return {
        obj.value += amount
        print(obj.value)
    }
}

var number2 = increment(by: 1)
number2()
number2()
number2()


class ViewController: UIViewController {
    
    var sampleClosure : () -> () = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callback {
            print("Closure가 실행되었습니다.")
        }
    }
    
    func callback(param: @escaping () -> ()) {
        self.sampleClosure = param // @escaping 없으면 에러
        sampleClosure()
    }
}
