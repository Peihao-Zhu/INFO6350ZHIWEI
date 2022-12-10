//
//  DetailsViewController.swift
//  stockApp
//
//  Created by 竺培豪 on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

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
        companySymbol.text = "Company symbol is \(compangSymbolTxt)"
        companyPrice.text = companyPriceTxt
        getStockBySymbol()

        // Do any additional setup after loading the view.
    }
    
    func getStockBySymbol() {
        var url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock?symbol="
        url+=compangSymbolTxt
        SwiftSpinner.show("Getting stock by symbol")
        AF.request(url).responseJSON { responseData in
                  
                  SwiftSpinner.hide()
                  
                  if responseData.error != nil {
                      print(responseData.error!)
                      return
                  }
                 print(responseData)

              }
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
