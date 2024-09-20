//
//  ExploreView.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import SwiftUI
import Charts

enum Grade {
    case freshman
    case sophomore
    case junior
    case senior
}

struct Couple : Identifiable {
    var id = UUID()
    var name: String
    var age: (Int, Int)
    var year: (Grade, Grade)
    var howWeMet: String
    var emoji: String
}

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

struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

struct User {
    var name: String
    var dataset: [ChartData]
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
    let couples = [
        Couple(name: "Alice & Bob", age: (25, 26), year: (.senior, .junior), howWeMet: "At a mutual friend's party", emoji: "💗"),
            Couple(name: "John & Sarah", age: (28, 27), year: (.junior, .sophomore), howWeMet: "Met during a class project",  emoji: "💗"),
            Couple(name: "Mark & Jenny", age: (30, 29), year: (.freshman, .senior), howWeMet: "Introduced by a professor",  emoji: "💗")
        ]
    
    let couples_port = [
        Couple(name: "Alice & Bob", age: (25, 26), year: (.senior, .junior), howWeMet: "At a mutual friend's party", emoji: "💗"),
            Couple(name: "John & Sarah", age: (28, 27), year: (.junior, .sophomore), howWeMet: "Met during a class project",  emoji: "💗")
        ]
    
    let data = [ChartData(day: "Mon", value: 10),
        ChartData(day: "Tue", value: 30),
        ChartData(day: "Wed", value: 40),
        ChartData(day: "Thu", value: 60),
        ChartData(day: "Fri", value: 50),
        ChartData(day: "Sat", value: 80),
        ChartData(day: "Sun", value: 100)]
    
    var user: User

        init() {
            // Initialize the `User` after `data` is initialized
            self.user = User(name: "Steven", dataset: data)
        }
    
    var body: some View {
    TabView {
        CouplesListView(couples: couples, title: "Explore")
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Explore")
                    }

        CouplesListView(couples: couples_port, title: "My Portfolio")
                    .tabItem {
                        Image(systemName: "person.2.circle")
                        Text("My Portfolio")
                    }
                
        ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
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
