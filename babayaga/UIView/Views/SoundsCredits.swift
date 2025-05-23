//
//  SoundsCredits.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//

import SwiftUI

struct SoundsCredits: View {
    let creditsData: [(
        title: String,
        license: String,
        source: String,
        artistName: String,
        artistURL: String
    )] = [
        (
            title: "Fast Talkin - Kevin MacLeod",
            license: "https://creativecommons.org/licenses/by/4.0/",
            source: "http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100590",
            artistName: "incompetech.com",
            artistURL: "http://incompetech.com/"
        ),
        (
            title: "Faster Does It - Kevin MacLeod",
            license: "https://creativecommons.org/licenses/by/4.0/",
            source: "http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100794",
            artistName: "incompetech.com",
            artistURL: "http://incompetech.com/"
        ),
        (
            title: "Kool Kats - Kevin MacLeod",
            license: "https://creativecommons.org/licenses/by/4.0/",
            source: "http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100601",
            artistName: "incompetech.com",
            artistURL: "http://incompetech.com/"
        ),
        (
            title: "Hat the Jazz - Twin Musicom",
            license: "https://creativecommons.org/licenses/by/4.0/",
            source: "http://www.twinmusicom.org/song/289/hat-the-jazz",
            artistName: "twinmusicom.org",
            artistURL: "http://www.twinmusicom.org"
        ),
        (
            title: "Jumpin Boogie Woogie - Audionautix",
            license: "https://creativecommons.org/licenses/by/4.0/",
            source: "http://audionautix.com/",
            artistName: "audionautix.com",
            artistURL: "http://audionautix.com/"
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                ForEach(creditsData, id: \.title) { credit in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(credit.title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("sound_credit_license")
                            .foregroundColor(.white)
                        Link(destination: URL(string: credit.license)!) {
                            Text("sound_credit_license_link")
                                .foregroundColor(.blue)
                                .underline()
                        }
                        
                        Text("sound_credit_source")
                            .foregroundColor(.white)
                        Link(destination: URL(string: credit.source)!) {
                            Text(credit.source)
                                .foregroundColor(.blue)
                                .underline()
                        }
                        
                        Text("sound_credit_artist")
                            .foregroundColor(.white)
                        Link(destination: URL(string: credit.artistURL)!) {
                            Text(credit.artistName)
                                .foregroundColor(.blue)
                                .underline()
                        }
                    }
                    
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                }
            }
            .padding()
        }
        .background(Background().ignoresSafeArea())
    }
}

#Preview {
    SoundsCredits()
}
