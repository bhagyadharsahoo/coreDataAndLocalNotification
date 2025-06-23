//
//  PdfReaderVc.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import UIKit
import PDFKit

final class PdfReaderVc: UIViewController {
    private var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPDFView()
        loadPDF()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupPDFView() {
            pdfView = PDFView()
            pdfView.translatesAutoresizingMaskIntoConstraints = false
            pdfView.autoScales = true
            view.addSubview(pdfView)

            NSLayoutConstraint.activate([
                pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    
    private func loadPDF() {
            if let url = URL(string: "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"),
               let document = PDFDocument(url: url) {
                pdfView.document = document
            }
        }
}
