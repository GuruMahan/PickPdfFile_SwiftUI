//
//  ContentView.swift
//  PickPdfFile
//
//  Created by Guru Mahan on 04/01/23.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @State var deSelected = false
    @State var selected = false
    @State var fileName = ""
    
    let documentURL: URL? =  Bundle.main.url(forResource: "", withExtension: "pdf")
    //    Bundle.main.url(forResource: "Deepak rsm", withExtension: "pdf")!
    @State var document: PDFDocument?
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text("PSPDFKit SwiftUI")
                .font(.largeTitle)
            HStack(alignment: .top) {
                Text("Made with ❤ at WWDC19")
                    .font(.title)
                Button{
                    deSelected = true
                } label: {
                    Text("Clear")
                    
                }
                
            }
           
            if document == nil{
                PdfView
                    .frame(width: 300,height: 300)
                    .background(Color.red)
                    .onTapGesture {
                        selected = true
                    }
                    .fileImporter(isPresented: $selected, allowedContentTypes: [.pdf,.data]) { result in
                        
                        do {
                            let furl = try result.get()
                            let data = try Data(contentsOf: furl)
                            if let pdf = PDFDocument(data: data) {
                                print(furl)
                                
                                    document = pdf
                       
                                
                                self.fileName = furl.lastPathComponent
                                
                            }
                        } catch {
                            print("error: \(error)") // todo
                        }
                    }
            }
            
        }
        
        if let doc = document {
            PDFKitView(document: doc)
        }
        
        
        
    }
    
    @ViewBuilder var PdfView: some View{
        
        VStack{
            
        }
        
    }
}
struct PDFKitRepresentedView: UIViewRepresentable {
    let document: PDFDocument
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = document
      //  pdfView.captureTextFromCamera(document)
        
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitView: View {
    var document: PDFDocument
   
    var body: some View {
        PDFKitRepresentedView(document: document)

    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
