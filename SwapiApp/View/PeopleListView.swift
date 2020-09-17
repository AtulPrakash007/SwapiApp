//
//  PeopleListView.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct PeopleListView: View {
	
	@ObservedObject var viewModel: PeopleListViewModel
	
	var body: some View {
		NavigationView {
			List {
				if viewModel.peoples.isEmpty {
					emptySection
				} else {
					resultsSection
				}
			}
			.navigationBarTitle("Star Wars")
			.onAppear {
				self.viewModel.loadPeoples()
			}
		}
	}
	
	var emptySection: some View {
		Section {
			Text("No People found")
		}
	}
	
	var resultsSection: some View {
		Section {
			ForEach(viewModel.peoples, id: \.self) { people in
				NavigationLink(destination: self.viewModel.peopleView(forPeople: people)) {
					PeopleNameView(viewModel: PeopleNameViewModel(people: people))
				}
			}
		}
	}
}
