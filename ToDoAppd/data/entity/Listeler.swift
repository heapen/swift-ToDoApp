//
//  Listeler.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 20.04.2025.
//

import Foundation


class Listeler {
    var liste_id: Int?
    var liste_ad: String?
    var liste_aciklama: String?
    
    init(){
        
    }
    
    init(liste_id: Int, liste_ad: String, liste_aciklama: String) {
        self.liste_id = liste_id
        self.liste_ad = liste_ad
        self.liste_aciklama = liste_aciklama
    }

}
