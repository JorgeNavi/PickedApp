//
//  RestaurantDetail.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import SwiftUI

struct RestaurantDetail: View {
    @Environment(\.dismiss) var dismiss
    var restaurantID: String
    
    @State private var viewModel: RestaurantDetailViewModel
    
    init(restaurantID: String, viewModel: RestaurantDetailViewModel = RestaurantDetailViewModel()) {
        self.restaurantID = restaurantID
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    AsyncImage(url: viewModel.restaurantData.photoRestaurant) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 350)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(viewModel.restaurantData.name)
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("IHOP (International House of Pancakes) is a popular American restaurant chain famous for its all-day breakfast menu. From fluffy buttermilk pancakes and golden waffles to hearty omelettes, crispy bacon, and savory burgers, IHOP offers a wide variety of comfort food that satisfies any craving. Whether you’re in the mood for classic eggs and hash browns or sweet treats like French toast topped with fruit and syrup, IHOP delivers a warm, family-friendly dining experience.")
                            
                        Text("All Dishes")
                            .font(.title)
                            .padding(.top, 30)
                    }
                    Spacer()
                }
                .padding()
                VStack {
                    ForEach(viewModel.restaurantData.meals) { meal in
                        MealRowView(meal: meal)
                    }
                }
                .padding()

            }
            .onAppear {
                Task {
                    try await viewModel.getRestaurantDetail(restaurantId: restaurantID)
                }
            }

        }
        
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                   dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.primaryColor)
                                .frame(width: 32, height: 32)
                        )
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    RestaurantDetail(restaurantID: "")
}

