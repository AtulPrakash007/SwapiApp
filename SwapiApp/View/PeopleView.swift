//
//  PeopleView.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import SwiftUI

struct PeopleView: View {
	
	static var noResultsRow: some View {
		Text("No results")
	}
	
	@ObservedObject var viewModel: PeopleViewModel
	
	var body: some View {
		List {
			personalSection
			physicalAttributeSection
			filmsSection
		}
		.navigationBarTitle(Text(viewModel.name), displayMode: .inline)
		.onAppear {
			self.viewModel.fetchProperties()
		}
	}
}

extension PeopleView {
	
	var personalSection: some View {
		Section(header: Text("Character")) {
			VStack(alignment: .leading, spacing: 12) {
				Text(viewModel.name)
				Text("Born: \(viewModel.birthYear)")
			}
		}
	}
	
	var physicalAttributeSection: some View {
		Section(header: Text("Physical Attributes")) {
			VStack(alignment: .leading, spacing: 12) {
				Text("Height: \(viewModel.height)")
				Text("Mass: \(viewModel.mass)")
				Text("Hair Color: \(viewModel.hair)")
				Text("Skin Color: \(viewModel.skin)")
				Text("Eye Color: \(viewModel.eyes)")
				Text("Gender: \(viewModel.gender)")
			}
		}
	}
	
	var filmsSection: some View {
		Section(header: Text("Appears in")) {
			if viewModel.films.isEmpty {
				PeopleView.noResultsRow
			} else {
				ForEach(viewModel.films, id: \.self) {
					self.viewModel.filmRowView(for: $0)
				}
			}
		}
	}
}
