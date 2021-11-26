//
//  SecondViewController.swift
//  Swiftgen Practice
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var cathuImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cathuImageView.image = Asset.Assets.Catchu.cathume.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
