//
//  NewProfficencyCell.swift
//  Arcana
//
//  Created by Gianatassio, Dominic Kanyo on 12/10/18.
//  Copyright © 2018 Reid, Jon Carl. All rights reserved.
//

import UIKit
import CoreData

class NewProfficencyCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var valueField: UITextField!
    
    var skill: Skill? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func updateSkill(_ sender: Any) {
        if let skill = skill{
            if let valueString = valueField.text, let value = Int16(valueString){
                skill.value = value
            } else {
                update(skill: skill)
            }
        }
        
    }
    
    func update(skill: Skill) {
        nameLabel.text = skill.name
        valueField.text = "\(skill.value)"
        self.skill = skill
    }
    

}
