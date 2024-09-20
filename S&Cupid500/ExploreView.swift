//
//  ExploreView.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import SwiftUI
import Charts


struct PersonWidget: View {
    var couple: Couple
    var body: some View {
        HStack {
            Spacer().frame(width: 70)
            VStack {
                Text("\(couple.name) \(couple.emoji)")
                    .font(.headline)
                Text("\(couple.age.0) & \(couple.age.0) years old")
                    .font(.subheadline)
                
                    .foregroundColor(.gray)
                Text("\(couple.howWeMet)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            Spacer().frame(width: 70)
        }
        .border(Color(UIColor(red: 26/255, green: 68/255, blue: 20/255, alpha: 1.0)), width: 2)
        .cornerRadius(30)
    }
}

struct CouplesListView: View {
    let couples: [Couple]
    let title: String
    var body: some View {
        VStack {Text(title)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .bold()
            
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(couples) {
                        couple in
                        PersonWidget(couple: couple)
                    }
                }
            }
        }
    }
}


struct ProfileView: View {
    let user: User
    
    var body: some View {
        VStack {
            Text("\(user.name)'s Profile")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .bold()
            Chart(user.dataset) {dataPoint in
                LineMark(
                    x: .value("Day", dataPoint.day),
                    y: .value("Value", dataPoint.value)
                )
                .interpolationMethod(.catmullRom) // Smooth the line
                .foregroundStyle(Color.blue)  // Line color
            }
            
        }
    }
    
}

struct CoupleView: View {
    let user: User
    
    var body: some View {
        VStack{
            Text("My Couple")
                .font(.title)
                .bold()
            
        }
    }
}

struct HomeView: View {
   
    @State var model = UserViewModel()
    
    var body: some View {
    TabView {
        CouplesListView(couples: model.fetchAllCouples(), title: "Explore")
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Explore")
                    }

        CouplesListView(couples: model.fetchUserCouples(), title: "My Portfolio")
                    .tabItem {
                        Image(systemName: "person.2.circle")
                        Text("My Portfolio")
                    }
                
        CoupleView(user: user)
            .tabItem{
                Image(systemName: "person.2")
                Text("My Couple")
            }
        }
    }
}

#Preview {
    HomeView()
}
