//////
//////  WallpapersView.swift
//////  Phone Guardian
//////
//////  Created by Tipu Sultan on 12/2/24.
//////
////
//////
//////  WallpapersView.swift
//////  Phone Guardian
//////
//////  Created by MacBook Pro M1 Pro on 12/2/24.
//////
////
////import SwiftUI
////
////struct WallpapersView: View {
////    // Sample wallpapers (Replace with actual assets in your project)
////    let wallpapers = [
////        Wallpaper(name: "wallpaper1"),
////        Wallpaper(name: "wallpaper2"),
////        Wallpaper(name: "wallpaper3"),
////        Wallpaper(name: "wallpaper4"),
////        Wallpaper(name: "wallpaper3"),
////        Wallpaper(name: "wallpaper2"),
////        Wallpaper(name: "wallpaper4"),
////        Wallpaper(name: "wallpaper3"),
////        Wallpaper(name: "wallpaper1")
////    ]
////
////    @State private var selectedWallpaper: Wallpaper? = nil
////
////    var body: some View {
////        NavigationView {
////            ScrollView {
////                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 16)]) {
////                    ForEach(wallpapers) { wallpaper in
////                        Image(wallpaper.name)
////                            .resizable()
////                            .aspectRatio(contentMode: .fill)
////                            .frame(width: 120, height: 200)
////                            .clipped()
////                            .cornerRadius(12)
////                            .onTapGesture {
////                                selectedWallpaper = wallpaper
////                            }
////                    }
////                }
////                .padding()
////            }
////            .navigationTitle("Wallpapers")
////            .sheet(item: $selectedWallpaper) { wallpaper in
////                WallpaperDetailView(wallpaper: wallpaper.name)
////            }
////        }
////    }
////}
////
////
////
////#Preview {
////    WallpapersView()
////}
////
////
//////
//////  WallpaperDetailView.swift
//////  Phone Guardian
//////
//////  Created by MacBook Pro M1 Pro on 12/2/24.
//////
////
////import SwiftUI
////import Photos
////
////struct WallpaperDetailView: View {
////    let wallpaper: String
////    @Environment(\.dismiss) var dismiss
////    @State private var showAlert = false
////    @State private var downloadSuccess = false
////
////    var body: some View {
////        VStack {
////            // Full-Screen Wallpaper Preview
////            Image(wallpaper)
////                .resizable()
////                .scaledToFit()
////                .edgesIgnoringSafeArea(.all)
////
////            Spacer()
////
////            // Save to Photos Button
////            Button(action: saveWallpaperToPhotos) {
////                Text("Save Wallpaper")
////                    .font(.headline)
////                    .foregroundColor(.white)
////                    .padding()
////                    .frame(width: 200)
////                    .background(Color.blue)
////                    .cornerRadius(15)
////            }
////            .padding()
////
////            // Close Button
////            Button("Close") {
////                dismiss()
////            }
////            .padding()
////        }
////        .alert(isPresented: $showAlert) {
////            Alert(
////                title: Text(downloadSuccess ? "Wallpaper Saved" : "Failed to Save"),
////                message: Text(downloadSuccess
////                    ? """
////                      The wallpaper has been saved to your Photos. 
////                      To set it as your wallpaper:
////                      1. Open the Photos app.
////                      2. Select the saved image.
////                      3. Tap the share icon and choose 'Use as Wallpaper.'
////                      """
////                    : "There was an error saving the wallpaper."),
////                dismissButton: .default(Text("OK"))
////            )
////        }
////    }
////
////    // MARK: - Save Wallpaper to Photos
////    private func saveWallpaperToPhotos() {
////        guard let image = UIImage(named: wallpaper) else { return }
////        
////        // Request Photo Library Permissions
////        PHPhotoLibrary.requestAuthorization { status in
////            switch status {
////            case .authorized, .limited:
////                // Save the wallpaper
////                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
////                downloadSuccess = true
////            case .denied, .restricted:
////                downloadSuccess = false
////            case .notDetermined:
////                break
////            @unknown default:
////                downloadSuccess = false
////            }
////            DispatchQueue.main.async {
////                showAlert = true
////            }
////        }
////    }
////}
//
//
////
////  WallpapersView.swift
////  Phone Guardian
////
////  Created by MacBook Pro M1 Pro on 12/2/24.
////
//
//import SwiftUI
//import Photos
//import UIKit
//
//struct WallpapersView: View {
//    // Sample wallpapers (Replace with real asset names)
//    let wallpapers = [
//        Wallpaper(name: "wallpaper1"),
//        Wallpaper(name: "wallpaper2"),
//        Wallpaper(name: "wallpaper3"),
//        Wallpaper(name: "wallpaper4"),
//        Wallpaper(name: "wallpaper5"),
//        Wallpaper(name: "wallpaper6")
//    ]
//
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 16)]) {
//                    ForEach(wallpapers) { wallpaper in
//                        ZStack {
//                            // Wallpaper Image
//                            Image(wallpaper.name)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 120, height: 200)
//                                .clipped()
//                                .cornerRadius(12)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
//                                )
//
//                            // Buttons on the image
//                            VStack {
//                                Spacer()
//                                HStack {
//                                    // Download Button
//                                    Button(action: {
//                                        saveWallpaperToPhotos(wallpaper.name)
//                                    }) {
//                                        Image(systemName: "arrow.down.circle.fill")
//                                            .resizable()
//                                            .frame(width: 20, height: 20)
//                                            .foregroundColor(.white)
//                                            .padding(8)
//                                            .background(Color.red)
//                                            .clipShape(Circle())
//                                            .shadow(radius: 3)
//                                    }
//
//                                    Spacer()
//
//                                    // Share Button
//                                    Button(action: {
//                                        shareWallpaper(wallpaper.name)
//                                    }) {
//                                        Image(systemName: "square.and.arrow.up.fill")
//                                            .resizable()
//                                            .frame(width: 20, height: 20)
//                                            .foregroundColor(.white)
//                                            .padding(8)
//                                            .background(Color.red)
//                                            .clipShape(Circle())
//                                            .shadow(radius: 3)
//                                    }
//                                }
//                                .padding(8)
//                            }
//                        }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Wallpapers")
//            .alert(isPresented: $showAlert) {
//                Alert(
//                    title: Text("Download Status"),
//                    message: Text(alertMessage),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//        }
//    }
//
//    // MARK: - Save Wallpaper to Photos
//    private func saveWallpaperToPhotos(_ wallpaperName: String) {
//        guard let image = UIImage(named: wallpaperName) else {
//            alertMessage = "Failed to locate wallpaper."
//            showAlert = true
//            return
//        }
//        
//        PHPhotoLibrary.requestAuthorization { status in
//            if status == .authorized || status == .limited {
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//                alertMessage = "Wallpaper has been saved to your Photos."
//            } else {
//                alertMessage = "Photo library access denied. Enable it in Settings."
//            }
//            DispatchQueue.main.async {
//                showAlert = true
//            }
//        }
//    }
//
//    // MARK: - Share Wallpaper
//    private func shareWallpaper(_ wallpaperName: String) {
//        guard let image = UIImage(named: wallpaperName) else { return }
//        
//        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        
//        // Presenting the activity controller
//        if let topController = UIApplication.shared.windows.first?.rootViewController {
//            topController.present(activityController, animated: true, completion: nil)
//        }
//    }
//}
//
//
//#Preview {
//    WallpapersView()
//}


//
//  WallpapersView.swift
//  Phone Guardian
//
//  Created by MacBook Pro M1 Pro on 12/2/24.
//

import SwiftUI
import Photos
import UIKit

struct WallpapersView: View {
    // Sample wallpapers (Replace with real asset names)
    let wallpapers = [
        Wallpaper(name: "wallpaper1"),
        Wallpaper(name: "wallpaper2"),
        Wallpaper(name: "wallpaper3"),
        Wallpaper(name: "wallpaper4"),
        Wallpaper(name: "wallpaper1"),
        Wallpaper(name: "wallpaper2"),
        Wallpaper(name: "wallpaper3"),
        Wallpaper(name: "wallpaper4")
    ]

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 16)]) {
                    ForEach(wallpapers) { wallpaper in
                        ZStack(alignment: .bottom) {
                            // Wallpaper Image
                            Image(wallpaper.name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 200)
                                .clipped()
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )

                            // Buttons Positioned Inside the Image
                            HStack {
                                // Download Button
                                Button(action: {
                                    saveWallpaperToPhotos(wallpaper.name)
                                }) {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .shadow(radius: 3)
                                }

                                Spacer()

                                // Share Button
                                Button(action: {
                                    shareWallpaper(wallpaper.name)
                                }) {
                                    Image(systemName: "square.and.arrow.up.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .shadow(radius: 3)
                                }
                            }
                            .padding([.leading, .trailing, .bottom], 8)
                        }
                        .frame(width: 120, height: 200) // Ensures buttons stay constrained to the image
                    }
                }
                .padding()
            }
            .navigationTitle("Wallpapers")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Download Status"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // MARK: - Save Wallpaper to Photos
    private func saveWallpaperToPhotos(_ wallpaperName: String) {
        guard let image = UIImage(named: wallpaperName) else {
            alertMessage = "Failed to locate wallpaper."
            showAlert = true
            return
        }
        
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized || status == .limited {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                alertMessage = "Wallpaper has been saved to your Photos."
            } else {
                alertMessage = "Photo library access denied. Enable it in Settings."
            }
            DispatchQueue.main.async {
                showAlert = true
            }
        }
    }

    // MARK: - Share Wallpaper
    private func shareWallpaper(_ wallpaperName: String) {
        guard let image = UIImage(named: wallpaperName) else { return }
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // Presenting the activity controller
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(activityController, animated: true, completion: nil)
        }
    }
}

#Preview {
    WallpapersView()
}
