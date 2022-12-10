//
//  ViewController.swift
//  stockApp
//
//  Created by 竺培豪 on 12/10/22.
//

import UIKit

import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tblView: UITableView!
    var arr : [CompanyQuote] = [ CompanyQuote]()
  
    var indexSelected = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStockQuote()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.arr.count)
        return self.arr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let str =  "Name =\(arr[indexPath.row].name)(\(arr[indexPath.row].symbol)), Price = \(arr[indexPath.row].price)"
        cell.textLabel?.text = str
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        indexSelected = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
        
    }
    func getStockQuote() {
        var url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
        SwiftSpinner.show("Getting All Stock Values")
        AF.request(url).responseJSON { responseData in
                  
                  SwiftSpinner.hide()
                  
                  if responseData.error != nil {
                      print(responseData.error!)
                      return
                  }
                 self.arr = [CompanyQuote]()
                 var quote = CompanyQuote()
                 let stockData = JSON(responseData.data as Any)
                  for stock in stockData {
                      let stockJSON = JSON(stock.1)
                      print(stockJSON)
                      var quote = CompanyQuote()
                      quote.symbol = stockJSON["Symbol"].stringValue
                      quote.name = stockJSON["CompanyName"].stringValue
                      quote.price = stockJSON["Price"].floatValue
                      self.arr.append(quote)

                  }
                 self.tblView.reloadData()
                 

              }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetails" {
            
            let secondVC = segue.destination as! DetailsViewController
            
            let name = arr[indexSelected].name
            let symbol = arr[indexSelected].symbol
            let price = arr[indexSelected].price
            
            secondVC.companyNameTxt = "Company name is \(name)"
            secondVC.compangSymbolTxt = "Company name is \(symbol)"
            secondVC.companyPriceTxt = "Company name is \(price)"
            
            
        }
        
    }
    


}

