import SwiftUI
import CoreImage.CIFilterBuiltins

struct ReceiveView: View {
    @State private var showCopyAlert = false

    let wallet : wallet
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        VStack(spacing: 30) {
            if let qrCode = generateQRCode(from: wallet.address.base58) {
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
            } else {
                Text("QR Code inválido")
                    .foregroundColor(.red)
            }

            HStack {
                Text(wallet.address.base58)
                    .font(.system(.body, design: .monospaced))
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundColor(.gray)

                Button(action: {
                    UIPasteboard.general.string = wallet.address.base58
                    showCopyAlert = true
                }) {
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .padding(.leading, 4)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)

        }
        .padding()
        .navigationTitle("Receber")
        .alert(isPresented: $showCopyAlert) {
            Alert(title: Text("Copiado!"), message: Text("Endereço copiado para a área de transferência."), dismissButton: .default(Text("OK")))
        }
    }

    func generateQRCode(from string: String) -> UIImage? {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))

            if let cgimg = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return nil
    }
}
#Preview {
    
    ReceiveView(wallet: wallet(
        _id: "123",
        _rev: "1-abc",
        privateKey: "EB99AC2B54334444192B21D7E7104FDF6E72FAEA8D8734F7E3E6088597A328DD",
        publicKey: "PUBLICKEY456",
        address: address(
            base58: "TC8C9sn6Vm3GPYbqLph4TBYRssHGUZDzSc",
            hex: "4117A34990EA7D273C138313F506D2815E379127FE"
        ),
        status: "p",
        rfID: "163132642"
    ))
}
