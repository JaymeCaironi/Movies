//
//  UsuariosViewController.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 06/03/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseUI

class UsuariosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    

    @IBOutlet weak var searchBarUsuarios: UISearchBar!
    @IBOutlet weak var tableViewUsuarios: UITableView!
    var firestore: Firestore!
    var usuarios: [Dictionary<String, Any>] = []
    var favoritos: [Dictionary<String, Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firestore = Firestore.firestore()
        self.searchBarUsuarios.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarUsuarios()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            recuperarUsuarios()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textoPesquisa = searchBar.text {
            if textoPesquisa != "" {
                pesquisarUsuarios(texto: textoPesquisa)
            }
        }
    }
    
    func pesquisarUsuarios(texto: String) {
    
        var listaFiltro: [Dictionary<String, Any>] = self.usuarios
        self.usuarios.removeAll()
        
        for item in listaFiltro {
            if let nome = item["nome"] as? String {
                if nome.lowercased().contains(texto.lowercased()){
                    self.usuarios.append(item)
                }
            }
        }
        
        self.tableViewUsuarios.reloadData()
    }
    
    func recuperarUsuarios() {
        
        //Limpa listagem de usuarios
        self.usuarios.removeAll()
        self.tableViewUsuarios.reloadData()
        
        firestore.collection("usuarios").getDocuments {
            (snapshotResultado, erro) in
            
            if let snapshot = snapshotResultado {
                for document in snapshot.documents {
                    let dados = document.data()
                    self.usuarios.append(dados)
                }
                self.tableViewUsuarios.reloadData()
            }
        }
    
    }
    
    /*Metodos para listagem na tabela*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usuarios.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaUsuarios", for: indexPath)
        
        let indice = indexPath.row
        let usuario = self.usuarios[indice]
        
        let nome = usuario["nome"] as? String
        let email = usuario["email"] as? String
        
        celula.textLabel?.text = nome
        celula.detailTextLabel?.text = email
        
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableViewUsuarios.deselectRow(at: indexPath, animated: true)
        
        let indice = indexPath.row
        let usuario = self.usuarios[indice]
        
        self.performSegue(withIdentifier: "segueFavoritos", sender: usuario)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueFavoritos" {
            let viewDestino = segue.destination as! FavoritosViewController
            
            viewDestino.usuario = sender as? Dictionary
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
