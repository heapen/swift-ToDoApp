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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   
    @IBAction func buttonKaydet(_ sender: Any) {
        if let la = tfListeAd.text, let lac = tfListeAciklama.text{
            kaydet(liste_ad: la, liste_aciklama: lac)
        }
    }
    
    func kaydet(liste_ad: String, liste_aciklama: String){
        print("Liste kaydet: \(liste_ad), \(liste_aciklama)")
    }
}
