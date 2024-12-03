////
////  BaseView.swift
////  Phone Guardian
////
////  Created by MacBook Pro M1 Pro on 12/2/24.
////
//
//import SwiftUI
//
//struct BaseView: View {
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            
//            // Pocket-to-Phone Alarm
//            PocketAlarmView()
//                .tabItem {
//                    Image(systemName: "lock.shield")
//                    Text("Pocket Alarm")
//                }
//                .tag(0)
//            
//            // Camera Capture on Touch
//            CameraCaptureView()
//                .tabItem {
//                    Image(systemName: "camera.fill")
//                    Text("Camera Guard")
//                }
//                .tag(1)
//            
//            // Clap to Alarm
//            ClapToAlarmView()
//                .tabItem {
//                    Image(systemName: "hand.wave")
//                    Text("Clap Alarm")
//                }
//                .tag(2)
//            
//            // Alarm on Touch
//            TouchAlarmView()
//                .tabItem {
//                    Image(systemName: "bell.fill")
//                    Text("Touch Alarm")
//                }
//                .tag(3)
//            
//            // Wallpapers Management
//            WallpapersView()
//                .tabItem {
//                    Image(systemName: "photo.fill")
//                    Text("Wallpapers")
//                }
//                .tag(4)
//        }
//        .accentColor(.blue) // Customize TabBar active color
//    }
//}
//
//#Preview {
//    BaseView()
//}

//
//  BaseView.swift
//  Phone Guardian
//
//  Created by MacBook Pro M1 Pro on 12/2/24.
//

import SwiftUI

struct BaseView: View {
    @State private var selectedTab = 2 // Default to center tab (Clap Alarm)

    var body: some View {
        VStack(spacing: 0) {
            // Main Content Area
            ZStack {
                switch selectedTab {
                case 0:
                    PocketAlarmView()
                case 1:
                    CameraCaptureView()
                case 2:
                    ClapToAlarmView()
                case 3:
                    TouchAlarmView()
                case 4:
                    WallpapersView()
                default:
                    ClapToAlarmView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom TabBar
            ZStack {
                // Background covering the entire bottom
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(height: 80)
                    .ignoresSafeArea(edges: .bottom)
                
                // TabBar Items
                HStack(alignment: .center, spacing: 0) {
                    TabBarButton(icon: "lock.shield", text: "Pocket", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    Spacer()
                    TabBarButton(icon: "camera.fill", text: "Camera", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    Spacer()
                    
                    // Center Tab (Clap Alarm - Elevated and Larger)
                    VStack {
                        Button(action: {
                            selectedTab = 2
                        }) {
                            Image(systemName: "hand.wave.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(selectedTab == 2 ? .blue : .gray)
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                        .shadow(radius: 5)
                                )
                        }
                        Text("Clap")
                            .font(.caption)
                            .foregroundColor(selectedTab == 2 ? .blue : .gray)
                    }
                    .offset(y: -20) // Elevates the center button
                    Spacer()
                    
                    TabBarButton(icon: "bell.fill", text: "Touch", isSelected: selectedTab == 3) {
                        selectedTab = 3
                    }
                    Spacer()
                    TabBarButton(icon: "photo.fill", text: "Wallpapers", isSelected: selectedTab == 4) {
                        selectedTab = 4
                    }
                }
                .padding(.horizontal, 15)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - TabBarButton Component
struct TabBarButton: View {
    let icon: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            Text(text)
                .font(.caption)
                .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}

#Preview {
    BaseView()
}
