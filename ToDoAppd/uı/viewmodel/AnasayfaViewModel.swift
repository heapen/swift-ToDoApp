//
//  AnasayfaViewModel.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 25.04.2025.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var listelerRepository = ListelerRepository()
    var listelerListesi = BehaviorSubject<[Listeler]>(value: [Listeler]())
    
    init(){
        veritabaniKopyala()
        listelerListesi = listelerRepository.listelerListesi
    }
    
    func ara(aramaKelimse: String){
        listelerRepository.ara(aramaKelimse: aramaKelimse)
    }
    func tamamla(liste_id: Int){
        listelerRepository.tamamla(liste_id: liste_id)
        listeleriYukle()
    }
    func listeleriYukle(){
        listelerRepository.listeleriYukle()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "listeler", ofType: ".sqlite")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("listeler.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
    }
}
