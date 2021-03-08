//
//  FavoritosViewController.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 04/03/21.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class FavoritosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableViewFavoritos: UITableView!
    var firestore: Firestore!
    var auth: Auth!
    var idUsuarioLogado: String!
    var storage: Storage!
    var usuario: Dictionary<String, Any>!
    var idUsuarioSelecionado: String!
    var filmes: [Filme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFavoritos.separatorStyle = .none
        
        firestore = Firestore.firestore()
        auth = Auth.auth()
        
/*        storage = Storage.storage()
        firestore = Firestore.firestore()
        auth = Auth.auth() */
        
        
        
    }
    
    /*Métodos para listagem na tabela*/
    func recuperarFilmes() {
        
        //Limpar listagem de Filmes
        self.filmes.removeAll()
        self.tableViewFavoritos.reloadData()
        
        firestore.collection("favoritos").getDocuments { (snapshotResultado, erro) in
            
            if let snapshot = snapshotResultado {
                for document in snapshot.documents {
                    let dados = document.data()
                    self.filmes.append(Filme(dictionary: dados))
                }
                self.tableViewFavoritos.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaFavoritos", for: indexPath) as! FavoritosTableViewCell
        
        let indice = indexPath.row
        let filme = self.filmes[indice]
        celula.setup(filme: filme)
        
//        celula.nomeFilme.text = "Nome do Filme"
//        celula.descricaoFilme.text = "Descrição do Filme"
//        celula.anoFilme.text = "Ano do Filme"
//        celula.fotoFilme.image = UIImage(named: "Popcode Logo")
        
        return celula
        
    }
    
/*    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    } */
    
}
