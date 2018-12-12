//
//  ViewController.swift
//  Arcana
//
//  Created by Reid, Jon Carl on 11/18/18.
//  Copyright © 2018 Reid, Jon Carl. All rights reserved.
//

import UIKit
import CoreData

class MainMenuTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var character: Character? = nil {
        didSet{
            
        }
    }
    
    var characterArray = [Character]()
    @IBOutlet var characterTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return characterArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! MainMenuTableViewCell
        let character = characterArray[indexPath.row]
        cell.update(with: character)
        cell.showsReorderControl = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        let character = characterArray.remove(at: sourceIndexPath.row)
        characterArray.insert(character, at: destinationIndexPath.row)
        characterTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            context.delete(characterArray[indexPath.row])
            characterArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveTrips()
        }
    }
    
    func saveTrips(){
        do{
            try context.save()
        }
        catch{
            print("Error, \(error)")
        }
        self.characterTableView.reloadData()
    }
    
    func loadTrips(){
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        do{
            characterArray = try context.fetch(request)
        }
        catch {
            print("Error loading trips \(error)")
        }
        self.characterTableView.reloadData()
        
    }
    
    func saveContext(){
        print("its definetly calling it")
        do {
            try context.save() // like a git commit
        }
        catch {
            print("Error saving categories")
        }
        self.characterTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let identifier = segue.identifier{
            if identifier == "DetailSegue"{
                if let characterDetailVC = segue.destination as? CharacterDetailViewController{
                    if let indexPath = characterTableView.indexPathForSelectedRow{
                        let character = characterArray[indexPath.row]
                        characterDetailVC.character = character
                        characterDetailVC.characterCount = characterArray.count
                        characterDetailVC.characterIndex = indexPath.row
                    }
                }
            }
            else if identifier == "AddSegue"{
                if let characterAddVC = segue.destination as? AddCharacterViewController{
                    characterAddVC.numCharacters = characterArray.count + 1
                }
            }
        }
    }
    
    func addCharacterToCoreData(_ characterName: String){
        let newCharacter = Character(context: self.context)
        newCharacter.name = characterName
        self.characterArray.append(newCharacter)
    }
    
    @IBAction func editBarPressed(_ sender: UIBarButtonItem){
        let newEditing = !characterTableView.isEditing
        characterTableView.setEditing(newEditing, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrips()
    }

    @IBAction func unwind(segue: UIStoryboardSegue){
    }
    

}

