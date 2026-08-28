//  ImportSheetView.swift
//  Headlong
//  Created by Holger Hinzberg on 24.08.26.
//  Copyright © 2026 Holger Hinzberg. All rights reserved.

import SwiftUI

struct ImportSheetView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var jsonString = ""
    @State private var replaceLocations = true
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var dismissAfterAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("JSON")
                    .font(.headline)
                    .foregroundColor(.veryPeri))
                {
                    TextEditor(text: $jsonString)
                        .frame(minHeight: 250)
                        .font(.system(size: 12, design: .monospaced))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }

                Section(header: Text("Options")
                    .font(.headline)
                    .foregroundColor(.veryPeri))
                {
                    Toggle("Replace existing locations", isOn: $replaceLocations)
                }

                Section {
                    Button("Import") {
                        importLocations()
                    }
                    .disabled(jsonString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .buttonStyle(.glass)

                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.glass)
                }
            }
            .navigationBarTitle("Import Locations", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
            }
        }
        .alert("Import", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                if dismissAfterAlert {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    private func importLocations() {
        do {
            let count = try GeolocationRepository.shared.importFromJson(json: jsonString,
                                                                        replaceExisting: replaceLocations)
            alertMessage = count == 1 ? "1 location imported." : "\(count) locations imported."
            dismissAfterAlert = true
            showAlert = true
        } catch {
            alertMessage = "Import failed: \(error.localizedDescription)"
            dismissAfterAlert = false
            showAlert = true
        }
    }
}

struct ImportSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ImportSheetView()
    }
}
