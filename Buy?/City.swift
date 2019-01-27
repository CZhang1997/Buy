//
//  City.swift
//  Buy?
//
//  Created by Xizhen Yang on 1/20/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import Foundation

class City {
    var cityName = ""
    var stateName = ""
    var cityChineseName = ""
    var stateChineseName = ""
    
    var saleTax : Double = 0
    
    init() {
        cityName = ""
        stateName = ""
        cityChineseName = "无税"
        stateChineseName = ""
        saleTax = 0
    }
    
    init(cName : String, sName : String, cChinese : String, sChinese: String, tax : Double) {
        cityName = cName
        stateName = sName
        cityChineseName = cChinese
        stateChineseName = sChinese
        saleTax = tax

    }
    
    
}

class State {
    var cities : [City]? //= ["":City()]
    var stateName = ""
    init ()
    {
        stateName = ""
    }
    init(_ city: City) {
        cities = [city]
       // stateName = name
    }
    func addCity(_ c: City){
        cities?.append(c)
        stateName = c.stateChineseName
    }
    
    func logStateData() -> [State]
    {
        let none = City ()
        
        // AZ
        let AZ = State(none)
        
        let phoeix = City(cName: "Phoenix", sName: "Arizona", cChinese: "凤凰城", sChinese: "AZ-亚利桑那州", tax: 0.086)
        AZ.addCity(phoeix)
        
        
        // CA
        let CA = State(none)
        
        let sanfrancisco = City(cName : "San Francisco", sName : "CA", cChinese : "旧金山", sChinese: "CA-加利福尼亚州", tax : 0.085)
        CA.addCity(sanfrancisco)
        
        let losangeles = City(cName: "Los Angeles", sName: "CA", cChinese: "洛杉矶", sChinese: "CA-加利福尼亚州", tax: 0.095)
        CA.addCity(losangeles)
        
        
        // CO
        let CO = State(none)
        
        let denver = City(cName : "Denver", sName : "CO", cChinese : "丹佛", sChinese: "CO-科罗拉多州", tax : 0.0831)
        CO.addCity(denver)
        
        
        // FL
        let FL = State(none)
        
        let miami = City(cName : "Miami", sName : "FL", cChinese : "迈阿密", sChinese: "FL-佛罗里达州", tax : 0.070)
        FL.addCity(miami)
        
        let orlando = City(cName : "Orlando", sName : "FL", cChinese : "奥兰多", sChinese: "FL-佛罗里达州", tax : 0.065)
        FL.addCity(orlando)
        
        
        // GA
        let GA = State(none)
        
        let atlanta = City(cName : "Atlanta", sName : "GA", cChinese : "亚特兰大", sChinese: "GA-乔治亚州", tax : 0.089)
        GA.addCity(atlanta)
        
        
        // HI
        let HI = State(none)
        
        let honolulu = City(cName : "Honolulu", sName : "HI", cChinese : "火奴鲁鲁", sChinese: "HI-夏威夷州", tax : 0.04712)
        HI.addCity(honolulu)
        
        
        //IL
        let IL = State(none)
        
        let chicago = City(cName : "Chicago", sName : "IL", cChinese : "芝加哥", sChinese: "IL-伊利诺伊州", tax : 0.1025)
        IL.addCity(chicago)
        
        
        // MD
        let MD = State(none)
        
        let baltimore = City(cName : "Baltimore", sName : "MD", cChinese : "巴尔的摩", sChinese: "MD-马里兰州", tax : 0.060)
        MD.addCity(baltimore)
        
        
        // MA
        let MA = State(none)
        
        let boston = City(cName : "Boston", sName : "MA", cChinese : "波士顿", sChinese: "MA-马萨诸塞州", tax : 0.0625)
        MA.addCity(boston)
        
        
        // MI
        let MI = State(none)
        
        let detroit = City(cName : "Detroit", sName : "MI", cChinese : "底特律", sChinese: "MI-密歇根州", tax : 0.060)
        MI.addCity(detroit)
        
        
        // NV
        let NV = State(none)
        
        let lasvegas = City(cName : "Las Vegas", sName : "LV", cChinese :"拉斯维加斯", sChinese: "NV-内华达州", tax : 0.0825)
        NV.addCity(lasvegas)
        
        
        // NY
        let NY = State(none)
        
        let newyorkcity = City(cName : "New York City", sName : "NY", cChinese :"纽约", sChinese: "NY-纽约州", tax : 0.0875)
        NY.addCity(newyorkcity)
        
        
        // OR
        let OR = State(none)
        
        let portland = City(cName : "Portland", sName : "OR", cChinese :"波特兰", sChinese: "OR-俄勒冈州", tax : 0.0)
        OR.addCity(portland)
        
        
        // TX
        let TX = State(none)
        
        let dallas = City(cName : "Dallas", sName : "TX", cChinese :"达拉斯", sChinese: "TX-德克萨斯州", tax : 0.0825)
        TX.addCity(dallas)
        
        let houston = City(cName : "Houston", sName : "TX", cChinese :"休斯敦", sChinese: "TX-德克萨斯州", tax : 0.0825)
        TX.addCity(houston)
        
        let austin = City(cName : "Austin", sName : "TX", cChinese :"奥斯汀", sChinese: "TX-德克萨斯州", tax : 0.0825)
        TX.addCity(austin)
        
        let sanantonio = City(cName : "San Antonio", sName : "TX", cChinese :"圣安东尼奥", sChinese: "TX-德克萨斯州", tax : 0.0825)
        TX.addCity(sanantonio)
        
        
        // WA
        let WA = State(none)
        
        let seattle = City(cName : "Seattle", sName : "WA", cChinese :"西雅图", sChinese: "WA-华盛顿州", tax : 0.101)
        WA.addCity(seattle)
        
        
        let states = [AZ,CA,CO,FL,GA,HI,IL,MD,MA,MI,NV,NY,OR,TX,WA]
        
        return states
    }
    
}
