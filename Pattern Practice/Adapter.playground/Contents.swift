import UIKit

class WesternRestaurant {
    func cook() -> String {
        return "양식을 요리하다."
    }
}

class WesternChef: WesternRestaurant {
    static func westernCook(restaurant: WesternRestaurant) {
        print("\(restaurant.cook())")
    }
}

let italianChef = WesternChef()
italianChef.cook()


class BakerAdaptee {
    func bake() -> String {
        return "제빵하다"
    }
}

class BakerAdapter: WesternRestaurant {
    
    private var bakerAdaptee: BakerAdaptee
    
    init(_ bakerAdaptee: BakerAdaptee) {
        self.bakerAdaptee = bakerAdaptee
    }
    
    override func cook() -> String {
        return self.bakerAdaptee.bake()
    }
}


let adaptedDunkinBaker = BakerAdaptee()
let adaptedBaker = BakerAdapter(adaptedDunkinBaker)
print(adaptedBaker.cook())

WesternChef.westernCook(restaurant: BakerAdapter(adaptedDunkinBaker))


class Language {
    func name() -> String {
        return "김루희"
    }
}

class Korean: Language {
    static func sayName(language: Language) {
        print("\(language.name())")
    }
}

let hureekim = Korean()
print(hureekim.name())


class Chinese {
    func sayMingzi() -> String {
        return "lvxi"
    }
}

class Translator: Language {
    
    private var mingzi: Chinese
    
    init(_ mingzi: Chinese) {
        self.mingzi = mingzi
    }
    
    override func name() -> String {
        return self.mingzi.sayMingzi()
    }
}


let ruheeKimChinese = Chinese()
Korean.sayName(language: Translator(ruheeKimChinese))

