//
//  CadastroViewController.swift
//  Popcode
//
//  Created by Jayme Antonio da Rosa Caironi on 04/03/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CadastroViewController: UIViewController {


    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    var auth: Auth!
    var firestore: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        auth = Auth.auth()
        firestore = Firestore.firestore()
        
    }
    
    @IBAction func cadastrar(_ sender: Any) {
        
        if let nome = campoNome.text {
            if let email = campoEmail.text {
                if let senha = campoSenha.text {
                    
                    auth.createUser(withEmail: email, password: senha) { (dadosResultado, erro) in
                        if erro == nil {
                            
                            if let idUsuario = dadosResultado?.user.uid {
                                //salvar dados do usuario
                                self.firestore.collection("usuarios").document( idUsuario ).setData(["nome": nome, "email": email])
                            }
                            
                            let alerta = UIAlertController(title: "Aviso", message: "Usuário Cadastrado com Sucesso", preferredStyle: UIAlertController.Style.alert)
                            
                            let botaoOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                                
                            }
                            
                            alerta.addAction(botaoOk)
                            
                            self.present(alerta, animated: true, completion: nil)
                        }else{
                            let alerta = UIAlertController(title: "Alerta", message: "Erro ao Cadastrar Usuário", preferredStyle: UIAlertController.Style.alert)
                            
                            let botaoOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                                
                            }
                            
                            alerta.addAction(botaoOk)
                            
                            self.present(alerta, animated: true, completion: nil)
                        }
                    }
                }else{
                    let alerta = UIAlertController(title: "Alerta", message: "Digite sua Senha", preferredStyle: UIAlertController.Style.alert)
                    
                    let botaoOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                        
                    }
                    
                    alerta.addAction(botaoOk)
                    
                    self.present(alerta, animated: true, completion: nil)
                }
            }else{
                let alerta = UIAlertController(title: "Alerta", message: "Digite seu Email", preferredStyle: UIAlertController.Style.alert)
                
                let botaoOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    
                }
                
                alerta.addAction(botaoOk)
                
                self.present(alerta, animated: true, completion: nil)
            }
        }else{
            let alerta = UIAlertController(title: "Alerta", message: "Digite sua Senha", preferredStyle: UIAlertController.Style.alert)
            
            let botaoOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
            }
            
            alerta.addAction(botaoOk)
            
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
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
