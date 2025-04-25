//
//  ListeDetay.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 20.04.2025.
//

import UIKit

class ListeDetay: UIViewController {

    @IBOutlet weak var tfListeAciklama: UITextField!
    @IBOutlet weak var tfListeAd: UITextField!
    var listeDetayViewModel = ListeDetayViewModel()
    
    var liste:Listeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let l = liste{
            tfListeAd.text = l.liste_ad
            tfListeAciklama.text = l.liste_aciklama
        }
      
    }
    

    @IBAction func buttonGuncelle(_ sender: Any) {
        if let la = tfListeAd.text, let lac = tfListeAciklama.text, let l = liste{
            listeDetayViewModel.guncelle(liste_id: l.liste_id!, liste_ad: la, liste_aciklama: lac)
        }
    }
    
    
}
