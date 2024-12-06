//
//  WallpapersView.swift
//  Phone Guardian
//
//  Created by MacBook Pro M1 Pro on 12/2/24.
//

import SwiftUI
import Photos

struct WallpapersView: View {
    // Sample wallpapers (Replace with real image URLs or assets)
    let wallpapers = [
        Wallpaper(name: "wallpaper1"),
        Wallpaper(name: "wallpaper2"),
        Wallpaper(name: "wallpaper3"),
        Wallpaper(name: "wallpaper4"),
        Wallpaper(name: "wallpaper1"),
        Wallpaper(name: "wallpaper3")
    ]

    @State private var selectedWallpaper: Wallpaper? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 16)]) {
                    ForEach(wallpapers) { wallpaper in
                        Image(wallpaper.name) // Use the `name` property for the image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 200)
                            .clipped()
                            .cornerRadius(12)
                            .onTapGesture {
                                selectedWallpaper = wallpaper
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Wallpapers")
            .sheet(item: $selectedWallpaper) { wallpaper in
                WallpaperDetailView(wallpaper: wallpaper.name)
            }
        }
    }
}

struct WallpaperDetailView: View {
    let wallpaper: String
    @Environment(\.dismiss) var dismiss
    @State private var isDownloading = false
    @State private var showAlert = false
    @State private var downloadSuccess = false

    var body: some View {
        VStack {
            // Full-Screen Wallpaper Preview
            Image(wallpaper)
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)

            Spacer()

            // Download Button
            Button(action: downloadWallpaper) {
                Text("Download Wallpaper")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding()

            // Close Button
            Button("Close") {
                dismiss()
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(downloadSuccess ? "Download Successful" : "Download Failed"),
                message: Text(downloadSuccess
                    ? "Wallpaper has been saved to your Photos."
                    : "There was an error saving the wallpaper."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // MARK: - Download Wallpaper
    private func downloadWallpaper() {
        guard let image = UIImage(named: wallpaper) else { return }
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                downloadSuccess = true
            } else {
                downloadSuccess = false
            }
            DispatchQueue.main.async {
                showAlert = true
            }
        }
    }
}

#Preview {
    WallpapersView()
}
