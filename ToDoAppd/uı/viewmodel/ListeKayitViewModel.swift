//
//  ListeKayitViewModel.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 25.04.2025.
//

import Foundation

class ListeKayitViewModel {
    var listelerRepository = ListelerRepository()
    
    func kaydet(liste_ad: String, liste_aciklama: String){
        listelerRepository.kaydet(liste_ad: liste_ad, liste_aciklama: liste_aciklama)
    }
}
