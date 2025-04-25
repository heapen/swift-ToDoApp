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
    var anasayfaViewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        listelerTableView.delegate = self
        listelerTableView.dataSource = self

        _ = anasayfaViewModel.listelerListesi.subscribe(onNext: { liste in
            self.listelerListesi = liste
            self.listelerTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaViewModel.listeleriYukle()
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
        anasayfaViewModel.ara(aramaKelimse: searchText)
    }
}

extension Anasayfa : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listelerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                self.anasayfaViewModel.tamamla(liste_id: liste.liste_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
