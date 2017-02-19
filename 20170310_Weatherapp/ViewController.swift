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

    //サーチボタンクリック時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる
        view.endEditing(true)
        //デバックエリアに出力
        print(searchBar.text!)
        
        if let searchWord = searchBar.text {
            searchCity(keyword: searchWord)
        }
    }
    
    //SearchCityメソッド
    //第一引数:keyword 検索したいワード
    func searchCity(keyword : String){
        
        //都市の検索キーワードをURLエンコードする
        let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed)
        
        //URLオブジェクトの生成 140010は横浜
        let url = URL(string: "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(keyword_encode!)")
    
        print(url!)

        //リクエストオブジェクトの生成
        let req = URLRequest(url:url!)
        
        //セッションの接続をカスタマイズできる
        //タイムアウト値、キャッシュポリシーなどが指定できる今回はデフォルト値を使用
        let configuration = URLSessionConfiguration.default
        
        //セッション情報を取り出し
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        //リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, request , error) in
            
            //do tra catch エラーハンドリング
            do {
                
                //受け取ったJSONデータをバース（解析）して格納
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                
                print("count =  \(json["count"])")
            } catch {
                //エラー処理
                print("エラーが出ました")
            }
        })
        //ダウンロード開始
        task.resume()
    }
    
}















