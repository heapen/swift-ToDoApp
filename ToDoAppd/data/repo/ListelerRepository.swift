//
//  ListelerRepository.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 25.04.2025.
//

import Foundation
import RxSwift

class ListelerRepository {
    var listelerListesi = BehaviorSubject<[Listeler]>(value: [Listeler]())
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniYolu = URL(fileURLWithPath: hedefYol).appendingPathComponent("listeler.sqlite")
        db = FMDatabase(path: veritabaniYolu.path)
    }
    
    func kaydet(liste_ad: String, liste_aciklama: String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO toDos (name, desc) VALUES (?,?)", values: [liste_ad,liste_aciklama])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func guncelle(liste_id:Int, liste_ad:String, liste_aciklama:String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE toDos SET name=?,desc=? WHERE id=?", values: [liste_ad,liste_aciklama,liste_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func ara(aramaKelimse: String){
        db?.open()
        
        do {
            var list = [Listeler]()
            
            let result = try db!.executeQuery("SELECT * FROM toDos WHERE name LIKE '%\(aramaKelimse)%'", values: nil)
            
            while result.next() {
                let liste_id = Int(result.string(forColumn: "id"))!
                let liste_ad = result.string(forColumn: "name")!
                let liste_aciklama = result.string(forColumn: "desc")!
                
                let liste = Listeler(liste_id: liste_id, liste_ad: liste_ad, liste_aciklama: liste_aciklama)
                
                list.append(liste)
            }
            
            listelerListesi.onNext(list)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func tamamla(liste_id: Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM toDos WHERE id=?", values: [liste_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func listeleriYukle(){
        db?.open()
        
        do {
            var list = [Listeler]()
            
            let result = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while result.next() {
                let liste_id = Int(result.string(forColumn: "id"))!
                let liste_ad = result.string(forColumn: "name")!
                let liste_aciklama = result.string(forColumn: "desc")!
                
                let liste = Listeler(liste_id: liste_id, liste_ad: liste_ad, liste_aciklama: liste_aciklama)
                
                list.append(liste)
            }
            
            listelerListesi.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
