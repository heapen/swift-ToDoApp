//
//  ListeKayit.swift
//  ToDoAppd
//
//  Created by Batuhan Çelik on 20.04.2025.
//

import UIKit

class ListeKayit: UIViewController {

    @IBOutlet weak var tfListeAciklama: UITextField!
    @IBOutlet weak var tfListeAd: UITextField!
    var listeKayitViewModel = ListeKayitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   
    @IBAction func buttonKaydet(_ sender: Any) {
        if let la = tfListeAd.text, let lac = tfListeAciklama.text{
            listeKayitViewModel.kaydet(liste_ad: la, liste_aciklama: lac)
        }
    }
    
    
}
