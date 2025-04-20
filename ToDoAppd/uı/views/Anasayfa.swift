//
//  ViewController.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 20.04.2025.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var listelerTableView: UITableView!
    var listelerListesi = [Listeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        listelerTableView.delegate = self
        listelerTableView.dataSource = self

        
        let l1 = Listeler(liste_id: 1, liste_ad: "Ev İşleri", liste_aciklama: "Yemek Yapılacak")
        let l2 = Listeler(liste_id: 1, liste_ad: "Okul İşleri", liste_aciklama: "Ödevler yapılacak")
        let l3 = Listeler(liste_id: 1, liste_ad: "Sosyal ", liste_aciklama: "Arkadaşlar ile buluşılacak")
        listelerListesi.append(l1)
        listelerListesi.append(l2)
        listelerListesi.append(l3)
    }



    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let liste = sender as? Listeler {
                let gidilecekVC = segue.destination as! ListeDetay
                gidilecekVC.liste = liste
            }
        }
    }
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Liste ara: \(searchText)")
    }
}

extension Anasayfa : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listelerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Satır sayısına göre tekrarlı çalışacak
        let hucre = tableView.dequeueReusableCell(withIdentifier: "listelerHucre") as! ListeHucre
        let liste = listelerListesi[indexPath.row]
        
        hucre.tfListeAd.text = liste.liste_ad
        hucre.tfListeAciklama.text = liste.liste_aciklama
        
        return hucre
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let liste = listelerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: liste)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Tamamlandı"){
            contextualAction,view,bool in//closure
            
            let liste = self.listelerListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Görev Tamamlama İşlemi", message: "\(liste.liste_ad!) Görev Tamamlandı mı?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){
                action in
                print(":Görevi Tamamla:\(liste.liste_ad!)")
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
