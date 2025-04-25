//
//  ListeDetayViewModel.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 25.04.2025.
//

import Foundation

class ListeDetayViewModel {
    var listelerRepository = ListelerRepository()
    func guncelle(liste_id:Int, liste_ad:String, liste_aciklama:String){
        listelerRepository.guncelle(liste_id: liste_id, liste_ad: liste_ad, liste_aciklama: liste_aciklama)
    }
}
