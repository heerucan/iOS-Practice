//
//  ViewController.swift
//  Reswift Practice
//
//  Created by Thisisme Hi on 2021/12/05.
//

import UIKit

import MDAlert
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = AppState

    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStore.subscribe(self)
        MDSimpleAlert(who: .후릐).showAlert(in: view)
    }
    
    func newState(state: AppState) {
        countLabel.text = "\(mainStore.state.counter)"
        
    }

    @IBAction func pressUpButton(_ sender: Any) {
        mainStore.dispatch(CounterActionIncrease())
        print("업")
    }
    
    @IBAction func pressDownButton(_ sender: Any) {
        mainStore.dispatch(CounterActionDecrease())
        print("다운")
    }
}
