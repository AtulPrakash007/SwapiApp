//
//  PeopleNameViewModel.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import SwiftUI

final class PeopleNameViewModel {
  private let people: People

  init(people: People) {
    self.people = people
  }

  var name: String {
    people.name
  }
}
