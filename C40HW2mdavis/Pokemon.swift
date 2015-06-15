//
//  Pokemon.swift
//  C40HW2mdavis
//
//  Created by mike davis on 6/4/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

// nor fir wat ele gra ice fig poi gro fly psy bug roc gho dra dar ste fai
enum Element: Int {
  case normal = 0
  case fire,water,electr,grass,ice,fight,poison,ground,flying
  case psychc,bug,rock,ghost,dragon,dark,steel,fairy
}

enum MoveType {
  case any, physical, special, status
}

enum Move {
  case airSlash, ember, growl, heatWave, leechSeed, scratch, tackle, vineWhip
  case poisonPowder, sleepPowder, takeDown, smokeScreen, dragonRage, scaryFace
  func moveStats() -> (element: Element, moveType: MoveType, basePower: Int, accuracy: Int, powerPoints: Int, name: String) {
    switch self {
    case .airSlash:
      return (Element.flying, MoveType.special, 75, 95, 20, "Air Slash")
    case .dragonRage:
      return (Element.dragon, MoveType.special, 0, 100, 10, "Dragon Rage")
    case .ember:
      return (Element.fire, MoveType.special, 40, 100, 25, "Ember")
    case .growl:
      return (Element.normal, MoveType.status, 0, 100, 40, "Growl")
    case .heatWave:
      return (Element.fire, MoveType.special, 95, 90, 15, "Heat Wave")
    case .leechSeed:
      return (Element.grass, MoveType.status, 0, 90, 10, "Leech Seed")
    case .poisonPowder:
      return (Element.poison, MoveType.status, 0, 75, 35, "Poison Powder")
    case .scaryFace:
      return (Element.normal, MoveType.status, 0, 100, 10, "Scary Face")
    case .scratch:
      return (Element.normal, MoveType.status, 40, 100, 35, "Scratch")
    case .sleepPowder:
      return (Element.grass, MoveType.status, 0, 75, 15, "Sleep Powder")
    case .smokeScreen:
      return (Element.normal, MoveType.status, 0, 100, 20, "Smoke Screen")
    case .tackle:
      return (Element.normal, MoveType.physical, 50, 100, 35, "Tackle")
    case .takeDown:
      return (Element.normal, MoveType.physical, 90, 85, 20, "Take Down")
    case .vineWhip:
      return (Element.grass, MoveType.physical, 40, 100, 25, "Vine Whip")
    }
  }
}

struct Stats {
  var hp = 0
  var attack = 0
  var defense = 0
  var specialAttack = 0
  var specialDefense = 0
  var speed = 0
}

class Pokemon {
  var name = "unknown pokemon"
  var elements: Set<Element> = [Element.normal]
  var stats = Stats()
  var moves: [Move] = []
  var level = 1
  var life = 0
  
  init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    stats.hp = hp
    stats.attack = attack
    stats.defense = defense
    stats.specialAttack = specialAttack
    stats.specialDefense = specialDefense
    stats.speed = speed
    life = hp
  }
  
  func isOwnElement(anyElement: Element) -> Bool {
    for element in elements {
      if element == anyElement {
        return true
      }
    }
    return false
  }
  func isValidMove(anyMove: Move) -> Bool {
    for move in moves {
      if move == anyMove {
        return true
      }
    }
    return false
  }
  
  func getSomeMoves(anyMoveType: MoveType) -> [Move] {
    var someMoves = [Move]()
    if anyMoveType == MoveType.any {
      return moves
    }
    for move in moves {
      let ms = move.moveStats()
      if anyMoveType == ms.moveType {
        //&& (ms.element == Element.normal || isOwnElement(ms.element))
        someMoves.append(move)
      }
    }
    return someMoves
  }
  
  func getMultiplierFor (attackElement: Element, defenseElement: Element) -> Float {
    let rowIdx = attackElement.rawValue
    let colIdx = defenseElement.rawValue
    assert(rowIdx >= Element.normal.rawValue && rowIdx <= Element.fairy.rawValue,
      "Attacking Element Type invalid")
    assert(colIdx >= Element.normal.rawValue && colIdx <= Element.fairy.rawValue,
      "Defending Element Type invalid")
    // probably a better (safer) data structure for this, perhaps a 2-dim dictionary
    let mult: [[Float]] =
    //                           defending type
    // nor fir wat ele gra ice fig poi gro fly psy bug roc gho dra dar ste fai
    [[  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,0.5,  0,  1,  1,0.5,  1],//nor
      [  1,0.5,0.5,  1,  2,  2,  1,  1,  1,  1,  1,  2,0.5,  1,0.5,  1,  2,  1],//fir
      [  1,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],//wat
      [  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  1],//ele
      [  1,0.5,  2,0.5,0.5,  1,  1,0.5,  2,0.5,  1,0.5,  2,  1,0.5,  1,0.5,  1],//gra
      [  1,0.5,  1,  1,  1,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  1],//ice
      [  2,  1,  1,  1,  1,  1,  1,0.5,  1,0.5,  1,  1,  1,  1,  1,  1,  1,  1],//fig
      [  1,  1,  1,  1,  2,  1,  1,0.5,0.5,  1,  1,  1,0.5,0.5,  1,  1,  0,  2],//poi    attacking
      [  1,  2,  1,  1,  1,  1,  1,  2,  1,  0,  1,  1,  1,  1,  1,  1,  1,  1],//gro      type
      [  1,  1,  1,0.5,  2,  1,  2,  1,  1,  1,  1,  2,0.5,  1,  1,  1,0.5,  1],//fly
      [  1,  1,  1,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],//psy
      [  1,0.5,  1,  1,  1,  1,  1,0.5,  1,0.5,  1,  1,  1,  1,  1,  1,  1,  1],//bug
      [  1,  2,  1,  1,  1,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  1],//roc
      [  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],//gho
      [  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],//dra
      [  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],//dar
      [  1,0.5,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],//ste
      [  1,0.5,  1,  1,  1,  1,  1,0.5,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1]]//fai
    return mult[rowIdx][colIdx]
  }
  
  func calcMultiplierForAttacking (defenseElements: Set<Element>) -> Float {
    var result: Float = 1.0
    for ae in elements {
      for de in defenseElements {
        result *= getMultiplierFor(ae, defenseElement: de)
      }
    }
    return result
  }
  
  func takeDamage (damage: Float) {
    if damage > 0.0 {
      life -= Int(damage)
      if life <= 0 {
        println("\(name) is dead!")
      }
    }
  }
  func heal (life: Int) {
    self.life += life
    if self.life > stats.hp {
      self.life = stats.hp
    }
  }
}
