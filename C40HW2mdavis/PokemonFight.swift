//
//  PokemonFight.swift
//  C40HW2mdavis
//
//  Created by mike davis on 6/4/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

enum FightStatus {
  case error, immunity, noMoves, physicalHit, specialHit, miss, status, isSelf, selfDead
}

class PokemonFight {

  // create some pokemon characters
  let monsters = [Bulbasaur(nameSuffix: "1"), Bulbasaur(nameSuffix: "2"),
                  Charmander(nameSuffix: "1"), Charmander(nameSuffix: "2"),
                  Ivysaur(nameSuffix: "1"), Ivysaur(nameSuffix: "2"),
                  Charmeleon(nameSuffix: "1"), Charmeleon(nameSuffix: "2"),
                  Venusaur(nameSuffix: "1"), Venusaur(nameSuffix: "2"),
                  Charizard(nameSuffix: "1"), Charizard(nameSuffix: "2")]

  func getCount() -> Int {
    return monsters.count
  }
  func isValidIndex(monsterIdx: Int) -> Bool {
    if monsterIdx >= 0 && monsterIdx < monsters.count {
      return true
    }
    return false
  }
  func getName(monsterIdx: Int) -> String? {
    if isValidIndex(monsterIdx) {
      return monsters[monsterIdx].name
    }
    return nil
  }
  func getLife(monsterIdx: Int) -> Int? {
    if isValidIndex(monsterIdx) {
      return monsters[monsterIdx].life
    }
    return nil
  }  
  func printOutLife(){
    for monster in monsters {
      println("Character: \(monster.name) life: \(monster.life)")
    }
  }

  func fightIfValid(attackerIdx: Int, defenderIdx: Int) ->
      (fightStatus: FightStatus, moveName: String?) {
        
    if attackerIdx == defenderIdx {
      return (FightStatus.isSelf, nil)
    }
    if monsters[attackerIdx].life <= 0 {
      return (FightStatus.selfDead, nil)
    }
    if !isValidIndex(attackerIdx) || !isValidIndex(defenderIdx) {
      return (FightStatus.error, nil)
    }
    return monsterFight(monsters[attackerIdx], defender: monsters[defenderIdx])
  }
  
  func monsterFight(attacker: Pokemon, defender: Pokemon) ->
      (fightStatus: FightStatus, moveName: String?) {
    
    let multiplier = attacker.calcMultiplierForAttacking(defender.elements)
    if multiplier == 0 {
      return (FightStatus.immunity, nil)
    }
    
    let someMoves = attacker.getSomeMoves(MoveType.any)
    if someMoves.isEmpty {
      return (FightStatus.noMoves, nil)
    }
          
    // have already spent too much time trying to figure out how these
    // guys fight, with little success, so I am going to fake it from here...
    let randomMove = someMoves[Int(arc4random()) % someMoves.count]
    let ms = randomMove.moveStats()
          
    switch ms.moveType {
    case .physical:
      println("physical attack? \(attacker.name)->\(defender.name) \(ms.name) stats:\(attacker.stats.attack)->\(defender.stats.defense) mult:\(multiplier)")
      let diff = attacker.stats.attack - defender.stats.defense
      if diff > 0 {
        defender.takeDamage(Float(diff) * multiplier)
        return (FightStatus.physicalHit, ms.name)
      } else {
        return (FightStatus.miss, ms.name)
      }
    case .special:
      println("special attack? \(attacker.name)->\(defender.name) \(ms.name) stats:\(attacker.stats.specialAttack)->\(defender.stats.specialDefense) mult:\(multiplier)")
      let diff = attacker.stats.specialAttack - defender.stats.specialDefense
      if diff > 0 {
        defender.takeDamage(Float(diff) * multiplier)
        return (FightStatus.specialHit, ms.name)
      } else {
        return (FightStatus.miss, ms.name)
      }
    case .status:
      println("status attack")
      return (FightStatus.status, ms.name)
    case .any:
      println("unknown type of attack")
      return (FightStatus.error, nil)
    }
  }
}
