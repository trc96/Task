//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Todd Crandall on 7/29/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate: class {
    func checkButtonTapped(for cell: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var taskCheckBox: UIButton!
    
    //MARK: - Properties
    weak var delegate: ButtonCellDelegate?
    
    var task: Task? {
        didSet {
            updateCell()
        }
    }
    
    //MARK: - Actions
    @IBAction func taskCheckButtonTapped(_ sender: Any) {
        delegate?.checkButtonTapped(for: self)
    }
    
    func updateButton() {
        guard let task = task else { return }
        let completeImage = UIImage(named: "complete")
        let incompleteImage = UIImage(named: "incomplete")
        task.isComplete ? taskCheckBox.setImage(completeImage, for: .normal) : taskCheckBox.setImage(incompleteImage, for: .normal)
    }
    
    func updateCell() {
        guard let task = task else { return }
        taskTextLabel.text = task.name
        updateButton()
    }
    //MARK: - Class Methods
    
}
