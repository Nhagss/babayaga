//
//  SoundsCredits.swift
//  babayaga
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/05/25.
//

import SwiftUI

struct SoundsCredits: View {
    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()

            ScrollView {
                Text("""
                Trilha sonora - Direitos autorais

                Fast Talkin de Kevin MacLeod é licenciada de acordo com a licença Atribuição 4.0 da Creative Commons.
                https://creativecommons.org/licenses/by/4.0/

                Fonte: http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100590
                Artista: http://incompetech.com/

                Faster Does It de Kevin MacLeod é licenciada de acordo com a licença Atribuição 4.0 da Creative Commons.
                https://creativecommons.org/licenses/by/4.0/

                Fonte: http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100794
                Artista: http://incompetech.com/

                Kool Kats de Kevin MacLeod é licenciada de acordo com a licença Atribuição 4.0 da Creative Commons.
                https://creativecommons.org/licenses/by/4.0/

                Fonte: http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100601
                Artista: http://incompetech.com/

                Hat the Jazz de Twin Musicom é licenciada de acordo com a licença Atribuição 4.0 da Creative Commons.
                https://creativecommons.org/licenses/by/4.0/

                Fonte: http://www.twinmusicom.org/song/289/hat-the-jazz
                Artista: http://www.twinmusicom.org

                Jumpin Boogie Woogie de Audionautix é licenciada de acordo com a licença Atribuição 4.0 da Creative Commons.
                https://creativecommons.org/licenses/by/4.0/

                Artista: http://audionautix.com/
                """)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding()
            }
        }
    }
}

#Preview {
    SoundsCredits()
}
