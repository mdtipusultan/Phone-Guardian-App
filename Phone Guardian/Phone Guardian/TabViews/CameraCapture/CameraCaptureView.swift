//
//  CameraCaptureView.swift
//  Phone Guardian
//
//  Created by Tipu Sultan on 12/2/24.
//

import SwiftUI
import AVFoundation
import Photos

struct CameraCaptureView: View {
    @State private var isEnabled = false
    @State private var isCameraPermissionGranted = false
    @State private var captureSession: AVCaptureSession?
    @State private var photoOutput = AVCapturePhotoOutput()
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Camera Security")
                .font(.largeTitle)
                .padding()

            Spacer()

            Toggle("Enable Camera Security", isOn: $isEnabled)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .onChange(of: isEnabled) { value in
                    if value {
                        checkCameraPermissions()
                        startCaptureSession()
                    } else {
                        stopCaptureSession()
                    }
                }
                .padding()

            

            Text("If someone touches or moves the phone, a photo will be captured.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
                .padding(.top, 80)
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            checkCameraPermissions()
        }
    }

    // MARK: - Camera Permission Handling
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isCameraPermissionGranted = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    isCameraPermissionGranted = true
                } else {
                    alertMessage = "Camera access is required for this feature."
                    showAlert = true
                }
            }
        case .denied, .restricted:
            alertMessage = "Camera access has been denied. Enable it in Settings."
            showAlert = true
            isCameraPermissionGranted = false
        @unknown default:
            alertMessage = "An unknown error occurred while accessing the camera."
            showAlert = true
        }
    }

    // MARK: - Capture Session
    private func startCaptureSession() {
        guard isCameraPermissionGranted else { return }

        let session = AVCaptureSession()
        session.beginConfiguration()

        // Camera Input
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera) else {
            alertMessage = "Unable to access the camera."
            showAlert = true
            return
        }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        // Photo Output
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }

        session.commitConfiguration()
        session.startRunning()
        captureSession = session

        // Simulate Motion Detection
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if isEnabled {
                capturePhoto()
            }
        }
    }

    private func stopCaptureSession() {
        captureSession?.stopRunning()
        captureSession = nil
    }

    // MARK: - Capture Photo
    private func capturePhoto() {
        guard let connection = photoOutput.connection(with: .video) else { return }

        let settings = AVCapturePhotoSettings()
        settings.flashMode = .off

        photoOutput.capturePhoto(with: settings, delegate: PhotoCaptureDelegate { image in
            savePhoto(image)
        })
    }

    // MARK: - Save Photo
    private func savePhoto(_ image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized || status == .limited {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            } else {
                alertMessage = "Photo library access is required to save photos."
                showAlert = true
            }
        }
    }
}

// MARK: - PhotoCaptureDelegate
class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    private let completion: (UIImage) -> Void

    init(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else { return }
        completion(image)
    }
}

#Preview {
    CameraCaptureView()
}
