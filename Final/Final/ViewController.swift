//
//  ViewController.swift
//  Final
//
//  Created by 竺培豪 on 12/9/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let foodNames = ["Burger", "Salad", "Sushi", "Pizza", "Taco"]
    
  
    @IBOutlet weak var txtStockSymbol: UITextField!
    
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
   
    @IBAction func getStockInfo(_ sender: Any) {
        let apiKey = "b603c982103259fb876bce58686f8c3b"

        var url = "https://financialmodelingprep.com/api/v3/quote/"
                url += txtStockSymbol.text!
                url += "?apikey="
                url += apiKey
                
                getStockQuote(url: url)
                .done { companyQuote in
                    print(companyQuote)
                }
                .catch { error in
                    print(error)
                }
    }
    func getStockQuote(url : String) -> Promise<CompanyQuote> {
           
           return Promise<CompanyQuote> { seal -> Void in
       
               AF.request(url).responseJSON { responseData in
                   print(responseData)
                   
                   
                   if responseData.error != nil {
                       seal.reject(responseData.error!)
                   }
                   
                   guard let stock = JSON(responseData.data!).array?.first else { return }
                   
                   let quote = CompanyQuote()
                   quote.symbol = stock["symbol"].stringValue
                   quote.name = stock["name"].stringValue
                   quote.price = stock["price"].floatValue
                   
                   seal.fulfill(quote)
                   

               }
           }
           
           
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodTableViewCell
             cell.imgFood.image = UIImage(named: foodNames[indexPath.row])
             cell.lblFood.text = foodNames[indexPath.row]
             return cell
    }
    


}

