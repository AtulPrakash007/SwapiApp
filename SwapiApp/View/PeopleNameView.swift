//
//  PeopleNameView.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import SwiftUI

struct PeopleNameView: View {
    let viewModel: PeopleNameViewModel

    var body: some View {
      VStack(alignment: .leading) {
        Text(viewModel.name)
          .font(.body)
      }
    }
}
