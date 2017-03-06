//
//  CityLoadFile.swift
//  20170310_Weatherapp
//
//  Created by 高橋真未 on 2017/02/25.
//  Copyright © 2017年 高橋真未. All rights reserved.
//

import Foundation



//class LoadFile: NSObject {
//    //csvファイルを読み込むメソッド　引数に読み込むファイルを指定　戻り値：String型配列
//    func loadCSV(_ fileName: String) -> [String] {
//        
//        //csvファイルのデータを格納するString配列
//        var csvArray:[String] = []//初期化するときは空っぽ
//        //引数ファイル名からcsvファイルパスを取得
//        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
//        
//        //ファイルの読み込み処理　例外処理が必要
//        do{
//            //ファイルのみ読み込み処理　その際、文字コードをUTF-8に変換（エンコード）して解釈
//            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
//            //改行コードが\rの場合\nに変換
//            let lineChange = csvData.replacingOccurrences(of: "\r",with: "\n")
//            //改行コードで要素を切り分け、配列に格納
//            csvArray = lineChange.components(separatedBy: "\n")
//        }catch{
//            print("error")
//        }
//        return csvArray
//    }
//}
//
