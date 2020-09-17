//
//  FilmRowViewModel.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import SwiftUI

final class FilmRowViewModel {
	
	private let film: Film
	
	init(film: Film) {
		self.film = film
	}
	
	var title: String {
		film.title
	}
	
	//	var openingCrawl: String {
	//		film.openingCrawl
	//	}
	
	//	var openingCrawlCount: Int {
	//		film.openingCrawl.count
	//	}
}

struct FilmRowView: View {
	
	let viewModel: FilmRowViewModel
	
	var body: some View {
		Text(viewModel.title)
		//		Text(viewModel.openingCrawl)
		//		Text(viewModel.openingCrawlCount)
	}
}
