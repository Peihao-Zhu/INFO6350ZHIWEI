//
//  DetailsViewController.swift
//  stockApp
//
//  Created by 竺培豪 on 12/10/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var companySymbol: UILabel!
    
    @IBOutlet weak var companyPrice: UILabel!
    var companyNameTxt = ""
    var compangSymbolTxt = ""
    var companyPriceTxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyName.text = companyNameTxt
        companySymbol.text = compangSymbolTxt
        companyPrice.text = companyPriceTxt

        // Do any additional setup after loading the view.
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
