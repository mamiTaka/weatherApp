//
//  ViewController.swift
//  20170310_Weatherapp
//
//  Created by 高橋真未 on 2017/02/14.
//  Copyright © 2017年 高橋真未. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //searchCityのdelegate通知先を設定
        searchCity.delegate = self
        //入力のヒントになるプレースホルダーを設定
        searchCity.placeholder = "都市名"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var searchCity: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //都市のリスト（タプル配列）
//    var CityList : [(date:String, city:String, title:String, text:String, image:String)] = []
    
    //サーチボタンクリック時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる
        view.endEditing(true)
        //デバックエリアに出力
        print(searchBar.text!)
        
        if let searchWord = searchBar.text {
            //入力されたら都市を検索
            searchCity(keyword: searchWord)
        }
    }
    
    //SearchCityメソッド
    func searchCity(keyword : String){
        
        var csvArray:[String] = []

        //CSVファイルのパスを取得する
        let csvPath = Bundle.main.path(forResource: "City", ofType: "csv")
        
        //CSVファイルのデータを取得する
        let csvData = try? NSString(contentsOfFile:csvPath!, encoding:String.Encoding.utf8.rawValue)
        
        //カンマ区切りでデータを分割して配列に格納する
        csvArray = (csvData?.components(separatedBy: ","))!
//        csvArray = (csvData?.components(separatedBy: "\n"))!
        print(csvArray)
        
        do{
//            検索文字とcsvファイルの1列目が該当するか確認を繰り返す
            for i in 0...3 where csvArray[i] == searchCity.text {
//                var Secondretsume:String = csvPath! [i][1]
                let ID : Int = i + 1
                let url  = URL(string: "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(csvArray[ID])")
                print(url)
                }

            
            //情報取得できているか確認
            if let items = json["item"] as? [[String:Any]]{
                //取得している都市の数だけ処理
                for item in item {
                    //日付
                    guard let date = item["date"] as? String else{
                        continue
                    }
                    //都市
                    guard let city = item["city"] as? String else {
                        continue
                    }
                    //天気（晴れ、曇り、雨など）
                    guard let title = item["title"] as? String else {
                        continue
                    }
                    //天気アイコンのURL
                    guard let image = item["image"] as? String else{
                        continue
                    }
                    //1つの天気情報をタプルでまとめて管理
                    let tenki = (date,city,title,image)
                    //天気の配列へ追加
                    self.CityList
                    
                }
                
                
//            }
            } catch {
                //エラー処理
                print("エラー")
            }
            //ダウンロード開始
            task.resume()
        }
    }
}

