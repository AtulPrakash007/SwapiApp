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
		Section(header: Text("People Info")) {
			VStack(alignment: .leading, spacing: 12) {
				Text(viewModel.name)
				Text("Gender: \(viewModel.gender)")
				Text("Born: \(viewModel.birthYear)")
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
