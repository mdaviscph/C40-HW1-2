//
//  ViewController.swift
//  C40HW2mdavis
//
//  Created by mike davis on 6/4/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let pmFight = PokemonFight()
  var name01Idx = 0
  var name02Idx = 0 //pmFight.getCount() - 1

  @IBOutlet weak var name01: UILabel!
  @IBOutlet weak var name02: UILabel!
  @IBOutlet weak var life01: UILabel!
  @IBOutlet weak var life02: UILabel!
  @IBOutlet weak var fightStatus: UILabel!
  
  func showName01() {
    if let name = pmFight.getName(name01Idx) {
      name01.text = name
    }
  }
  func showName02() {
    if let name = pmFight.getName(name02Idx) {
      name02.text = name
    }
  }
  func showLife01() {
    if let life = pmFight.getLife(name01Idx) {
      life01.text = "Life: \(life)"
    }
  }
  func showLife02() {
    if let life = pmFight.getLife(name02Idx) {
      life02.text = "Life: \(life)"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    name02Idx = pmFight.getCount() - 1
    showName01()
    showName02()
    showLife01()
    showLife02()
  }

  @IBAction func name01ScrollLeft(sender: AnyObject) {
    name01Idx--
    if name01Idx < 0 {
      name01Idx = 0
    }
    showName01()
    showLife01()
  }
  @IBAction func name01ScrollRight(sender: AnyObject) {
    name01Idx++
    if name01Idx > pmFight.getCount() - 1 {
      name01Idx = pmFight.getCount() - 1
    }
    showName01()
    showLife01()
  }
  @IBAction func name02ScrollLeft(sender: AnyObject) {
    name02Idx--
    if name02Idx < 0 {
      name02Idx = 0
    }
    showName02()
    showLife02()
  }
  @IBAction func name02ScrollRight(sender: AnyObject) {
    name02Idx++
    if name02Idx > pmFight.getCount() - 1 {
      name02Idx = pmFight.getCount() - 1
    }
    showName02()
    showLife02()
  }
  
  @IBAction func fightRightTapped(sender: AnyObject) {
    startAttack(name01Idx, defendIdx: name02Idx)
  }
  @IBAction func fightLeftTapped(sender: AnyObject) {
    startAttack(name02Idx, defendIdx: name01Idx)
  }
  
  func startAttack(attackIdx: Int, defendIdx: Int) {
    let fight = pmFight.fightIfValid(attackIdx, defenderIdx: defendIdx)
    let moveName = fight.moveName ?? "Nil Move"
    switch fight.fightStatus {
    case .error:
      fightStatus.text = "Monsters are Loose!" // out of range index
    case .immunity:
      fightStatus.text = "Defender Immunity!"
    case .isSelf:
      fightStatus.text = "Cannot Fight Itself!"
    case .miss:
      fightStatus.text = moveName + " Missed!"
    case .noMoves:
      fightStatus.text = "No Attacking Moves!"
    case .physicalHit, .specialHit:
      showLife01()
      showLife02()
      fightStatus.text = moveName + " Hit!"
    case .selfDead:
      fightStatus.text = "Dead Monsters Cannot Fight!"
    case .status:
      fightStatus.text = "Status Attack!"
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    pmFight.printOutLife()
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    pmFight.printOutLife()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

