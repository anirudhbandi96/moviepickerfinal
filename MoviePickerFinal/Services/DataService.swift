//
//  DataService.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/20/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage
import SwiftSoup

class DataService{
    static let instance = DataService()
    
    private var selectedActors : [String]?
    private var year: String?
    private var fromYear: String?
    private var toYear: String?
    private var minimumRating : String?
    private var selectedLanguage: String?
    private var selectedGenres: [String]?
    private var selectedCertificate: [String]?
    
    
    func setSelectedActors(actors: [String]?){
        self.selectedActors = actors
    }
    func setYear(year: String?){
        self.year = year
    }
    func setFromYear(year: String?){
        self.fromYear = year
    }
    func setToYear(year: String?){
        self.toYear = year
    }
    func setMinimumRating(rating: String?){
        self.minimumRating = rating
    }
    func setSelectedLanguage(language: String?){
        self.selectedLanguage = language
    }
    func setSelectedGenres(genres: [String]?){
        self.selectedGenres = genres
    }
    func setSelectedCertificate(certificate: [String]?){
        self.selectedCertificate = certificate
    }
    //    func getGenreString(forIds ids:[String]) -> [String]{
    //        if genreDict == nil {
    //            DataService.instance.getGenreData(completion: { (genres) in
    //                self.genreDict = genres
    //            })
    //        }
    //        var resultedGenreString = [String]()
    //        for id in ids{
    //            resultedGenreString += genreDict!.filter({$0.id == id}).map({$0.name})
    //        }
    //        return resultedGenreString
    //    }
    
  
  
    
    func getLanguageCodes(completion: @escaping (([[String]])->())){
        var languageCodes = [[String]]()
        Alamofire.request("https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes",method: .get).responseString { (response) in
            guard let html = response.result.value else { return  }
            do{
                let table = try SwiftSoup.parse(html).select("table#Table")
                let trs = try table.select("tr")
                var flag = 0
                for element : Element in trs{
                    var code = [String]()
                    var tds : Elements!
                    if flag == 0{
                        tds = try element.select("th")
                        flag += 1
                    }
                    else{
                        tds = try element.select("td")
                    }
                    let first = try tds.eq(2).text()
                    let second = try tds.eq(4).text()
                    code.append(first)
                    code.append(second)
                    languageCodes.append(code)
                    
                }
                completion(languageCodes)
                
            } catch Exception.Error( _, let message) {
                print(message)
            } catch {
                print("error")
            }
        }
    }
    
   
    func getCountryCodeToNameConversionDict(completion: @escaping ([String:String])->()){
        
        var countryCodeToNamesDict = [String:String]()
        Alamofire.request("https://en.wikipedia.org/wiki/ISO_3166-1",method: .get).responseString { (response) in
            guard let html = response.result.value else { return  }
            do{
                let tables = try SwiftSoup.parse(html).select("table.wikitable")
                let table = tables.eq(1)
                let trs = try table.select("tr")
                for element : Element in trs{
                    let tds = try element.select("td")
                    let first = try tds.eq(0).text()
                    let second = try tds.eq(1).text()
                    countryCodeToNamesDict[second] = first
                }
                completion(countryCodeToNamesDict)
                
            } catch Exception.Error( _, let message) {
                print(message)
            } catch {
                print("error")
            }
        }
        
        
    }
    
    
    
   
    
}
