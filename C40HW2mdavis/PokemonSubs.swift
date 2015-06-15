//
//  PokemonSubs.swift
//  C40HW2mdavis
//
//  Created by mike davis on 6/4/15.
//  Copyright (c) 2015 mike davis. All rights reserved.
//

import Foundation

class Bulbasaur: Pokemon {
  override init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    super.init(hp: hp, attack: attack, defense: defense, specialAttack: specialAttack, specialDefense: specialDefense, speed: speed)
    name = "bulbasaur"
    elements = [Element.grass, Element.poison]
    moves = [Move.tackle, Move.growl, Move.vineWhip]
    level = 1
  }
  convenience init (nameSuffix: String = "") {
    self.init(hp: 45, attack: 49, defense: 49, specialAttack: 65, specialDefense: 65, speed: 45)
    name += nameSuffix
  }
}
class Ivysaur: Bulbasaur {
  override init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    super.init(hp: hp, attack: attack, defense: defense, specialAttack: specialAttack, specialDefense: specialDefense, speed: speed)
    name = "ivysaur"
    moves += [Move.poisonPowder]
    level = 16
  }
  convenience init (nameSuffix: String = "") {
    self.init(hp: 60, attack: 62, defense: 63, specialAttack: 80, specialDefense: 80, speed: 60)
    name += nameSuffix
  }
}
class Venusaur: Ivysaur {
  override init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    super.init(hp: hp, attack: attack, defense: defense, specialAttack: specialAttack, specialDefense: specialDefense, speed: speed)
    name = "venusaur"
    moves += [Move.leechSeed, Move.sleepPowder]
    level = 32
  }
  convenience init (nameSuffix: String = "") {
    self.init(hp: 80, attack: 82, defense: 83, specialAttack: 100, specialDefense: 100, speed: 80)
    name += nameSuffix
  }
}
class Charmander: Pokemon {
  override init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    super.init(hp: hp, attack: attack, defense: defense, specialAttack: specialAttack, specialDefense: specialDefense, speed: speed)
    name = "charmander"
    elements = [Element.fire]
    moves = [Move.growl, Move.heatWave, Move.ember]
    level = 1
  }
  convenience init (nameSuffix: String = "") {
    self.init(hp: 39, attack: 52, defense: 43, specialAttack: 60, specialDefense: 50, speed: 65)
    name += nameSuffix
  }
}
class Charmeleon: Charmander {
  override init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    super.init(hp: hp, attack: attack, defense: defense, specialAttack: specialAttack, specialDefense: specialDefense, speed: speed)
    name = "charmeleon"
    moves += [Move.scratch, Move.smokeScreen]
    level = 16
  }
  convenience init (nameSuffix: String = "") {
    self.init(hp: 58, attack: 64, defense: 58, specialAttack: 80, specialDefense: 65, speed: 80)
    name += nameSuffix
  }
}
class Charizard: Charmeleon {
  override init (hp: Int,attack: Int,defense: Int,specialAttack: Int,specialDefense: Int,speed: Int) {
    super.init(hp: hp, attack: attack, defense: defense, specialAttack: specialAttack, specialDefense: specialDefense, speed: speed)
    name = "charizard"
    elements.insert(Element.flying)
    moves += [Move.airSlash, Move.heatWave, Move.scaryFace]
    level = 36
  }
  convenience init (nameSuffix: String = "") {
    self.init(hp: 78, attack: 84, defense: 78, specialAttack: 109, specialDefense: 85, speed: 100)
    name += nameSuffix
  }
}
