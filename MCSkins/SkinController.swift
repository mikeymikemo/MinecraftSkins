//
//  SkinController.swift
//  MCSkins
//
//  Created by Michael Montoya on 1/30/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import Foundation

class SkinController {
    
    static let shared = SkinController()
    
    init(){
        
        let flashSkin = Skin(name: "The Flash", image: #imageLiteral(resourceName: "theflashskin"))
        let bilboSkin = Skin(name: "Bilbo Baggins", image: #imageLiteral(resourceName: "bilbobaggins"))
        let snowmanSkin = Skin(name: "Snowman", image: #imageLiteral(resourceName: "snowman"))
        let waveMonsterSkin = Skin(name: "Wave Monster", image: #imageLiteral(resourceName: "WavemonsterSkin"))
        let gingerBreadskin = Skin(name: "Gingerbread Man", image: #imageLiteral(resourceName: "gingerbreadSkin"))
        let deadPoolSkin = Skin(name: "Deadpool", image: #imageLiteral(resourceName: "Deadpoolskin"))
        
        mockArrayOfSkins.append(flashSkin)
        mockArrayOfSkins.append(snowmanSkin)
        mockArrayOfSkins.append(waveMonsterSkin)
        mockArrayOfSkins.append(gingerBreadskin)
        mockArrayOfSkins.append(deadPoolSkin)
        mockArrayOfSkins.append(bilboSkin)
    }
    
    var mockArrayOfSkins: [Skin] = []
}
